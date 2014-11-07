//
//  HeaderCell.swift
//  CalendarControl
//
//  Created by Grzegorz Tatarzyn on 24/10/2014.
//  Copyright (c) 2014 gregttn. All rights reserved.
//

import UIKit

class CalendarHeader: UICollectionReusableView, UICollectionViewDelegate, UICollectionViewDataSource {
    private let weekdaySymbols = NSDateFormatter().shortWeekdaySymbols
    private let cellIdentifier = "cId"
    private let headerIdentifier = "headerId"
    private let cellHeight:CGFloat = 30
    var displayMonth: String = ""
    
    private var calendarInfo: UICollectionView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        build()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        build()
    }
    
    private func build() {
        calendarInfo = createCollectionView()
        
        if var collectionView = calendarInfo {
            addSubview(collectionView)
        }
    }
    
    private func createCollectionView() -> UICollectionView {
        let collectionFrame = CGRectMake(0, 0, frame.width, frame.height)
    
        let collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: MonthCalendarCollectionLayout(frame: collectionFrame, headerSize: CGSizeMake(frame.width, frame.height-cellHeight), itemHeight: cellHeight))
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollEnabled = false
        collectionView.registerClass(WeekdaySymbolCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.registerClass(MonthNavigationHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        return collectionView
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekdaySymbols.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as WeekdaySymbolCell
        cell.symbol.text = weekdaySymbols[indexPath.row] as? String
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var header: MonthNavigationHeader =  collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier, forIndexPath: indexPath) as MonthNavigationHeader
        header.title.text = displayMonth
        
        return header
    }
    
    func updateMonthHeader(text: String) {
        displayMonth = text
        if var collectionView = calendarInfo {
            var header: MonthNavigationHeader =  collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier, forIndexPath: NSIndexPath(forItem: 0, inSection: 0)) as MonthNavigationHeader
            
            header.title.text = displayMonth
        }
    }
}
