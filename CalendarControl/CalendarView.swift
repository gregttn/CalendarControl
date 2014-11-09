//
//  Calendar.swift
//  CalendarControl
//
//  Created by Grzegorz Tatarzyn on 24/10/2014.
//  Copyright (c) 2014 gregttn. All rights reserved.
//

import UIKit

class CalendarView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    private let cellIdentifier = "DayCell"
    private let headerCellIdentifier = "HeaderCell"
    private let calendar = NSCalendar.currentCalendar()
    
    private var currentDate: NSDate = NSDate()
    lazy private var daysOffset: Int = {
        return self.calendar.weekdayForFirstOfTheMonthFor(self.currentDate)
    }()
    
    
    lazy var daysCollectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: self.frame, collectionViewLayout: MonthCalendarCollectionLayout(frame: self.frame, headerSize: CGSizeMake(self.frame.width, 80)))
        collectionView.backgroundColor = UIColor.whiteColor()
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
        
        if isValidDayCell(indexPath) {
            var dayToDisplay = indexPath.row - daysOffset + 1
            cell.updateWithDay(dayToDisplay)
            
            if dayToDisplay == calendar.dayOfTheMonthFor(currentDate) {
                cell.select()
            }
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendar.daysInMonthFor(currentDate) + daysOffset
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var header: CalendarHeader =  collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellIdentifier, forIndexPath: indexPath) as CalendarHeader
        
        header.displayMonth = "\(calendar.monthNameFor(currentDate)) \(calendar.basicComponents(currentDate).year)"
        
        return header
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.applyForCell(indexPath) { cell in cell.highlight() }
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        self.applyForCell(indexPath) { cell in cell.unhighlight() }
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return isValidDayCell(indexPath)
    }
    
    func collectionView(collectionView: UICollectionView, shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return isValidDayCell(indexPath)
    }
    
    private func applyForCell(indexPath: NSIndexPath, action: (DayCell) -> ()) {
        var highlightedCell = daysCollectionView.cellForItemAtIndexPath(indexPath) as DayCell
        action(highlightedCell)
    }
    
    private func isValidDayCell(indexPath: NSIndexPath) -> Bool {
        return indexPath.row >= daysOffset
    }
}