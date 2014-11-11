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
    private var displayedDate: NSDate = NSDate()
    
    private var daysOffset: Int  {
        get {
            return self.calendar.weekdayForFirstOfTheMonthFor(self.displayedDate)
        }
    }
    
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
    
    override func didMoveToWindow() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "displayNextMonth", name: NavigationHeaderNextMonthSelected, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "displayPreviousMonth", name: NavigationHeaderPreviousMonthSelected, object: nil)
    }
    
    override func willMoveToWindow(newWindow: UIWindow?) {
        if newWindow == nil {
            NSNotificationCenter.defaultCenter().removeObserver(self, name: NavigationHeaderNextMonthSelected, object: nil)
            NSNotificationCenter.defaultCenter().removeObserver(self, name: NavigationHeaderPreviousMonthSelected, object: nil)
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as DayCell
        
        if isValidDayCell(indexPath) {
            var dayToDisplay = indexPath.row - daysOffset + 1
            cell.updateWithDay(dayToDisplay)
            
            if isCellForCurrentDay(dayToDisplay) {
                cell.select()
            } else {
                cell.deselect()
            }
            
        } else {
            cell.clear()
        }
        
        return cell
    }
    
    private func isCellForCurrentDay(day: Int) -> Bool {
        return currentDate.isSameDay(displayedDate, calendar: calendar) && day == calendar.dayOfTheMonthFor(currentDate)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendar.daysInMonthFor(currentDate) + daysOffset
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var header: CalendarHeader =  collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellIdentifier, forIndexPath: indexPath) as CalendarHeader
        
        header.updateMonthHeader("\(calendar.monthNameFor(displayedDate)) \(calendar.basicComponents(displayedDate).year)")
        
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
    
    func displayDate(date: NSDate) {
        displayedDate = date
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.daysCollectionView.reloadData()
        })
    }
    
    func displayNextMonth() {
        displayDate(displayedDate.nextMonth(calendar))
    }
    
    func displayPreviousMonth() {
        displayDate(displayedDate.previousMonth(calendar))
    }
}