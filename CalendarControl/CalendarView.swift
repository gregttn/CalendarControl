//
//  Calendar.swift
//  CalendarControl
//
//  Created by Grzegorz Tatarzyn on 24/10/2014.
//  Copyright (c) 2014 gregttn. All rights reserved.
//

import UIKit

class CalendarView: UIControl, UICollectionViewDelegate, UICollectionViewDataSource {
    private let cellIdentifier = "DayCell"
    private let headerCellIdentifier = "HeaderCell"
    private let calendar = NSCalendar.currentCalendar()
    
    private var currentDate: NSDate = NSDate()
    lazy private var daysOffset: Int = {
        return self.calendar.weekdayForFirstOfTheMonthFor(self.currentDate)
    }()
    
    
    lazy var daysCollectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: self.frame, collectionViewLayout: MonthCalendarCollectionLayout(frame: self.frame, headerSize: CGSizeMake(self.frame.width, 63)))
        collectionView.backgroundColor = UIColor.appGreen()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollEnabled = false
        collectionView.registerClass(DayCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
        collectionView.registerClass(CalendarHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: self.headerCellIdentifier)
        
        return collectionView
    }()
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        addSubview(daysCollectionView)
        daysCollectionView.reloadData()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as DayCell
        cell.backgroundColor = UIColor.appGreen()
        
        if indexPath.row >= daysOffset {
            var dayToDisplay = indexPath.row - daysOffset + 1
            cell.updateWithDay(dayToDisplay)
            
            if dayToDisplay == calendar.dayOfTheMonthFor(currentDate) {
                cell.selected()
            }
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendar.daysInMonthFor(currentDate) + daysOffset
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var header: CalendarHeader =  collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellIdentifier, forIndexPath: indexPath) as CalendarHeader

        header.updateHeaderText(calendar.monthNameFor(currentDate))
        
        return header
    }
}