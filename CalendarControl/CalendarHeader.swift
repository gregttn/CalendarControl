//
//  HeaderCell.swift
//  CalendarControl
//
//  Created by Grzegorz Tatarzyn on 24/10/2014.
//  Copyright (c) 2014 gregttn. All rights reserved.
//

import UIKit

class CalendarHeader: UICollectionReusableView, UICollectionViewDelegate, UICollectionViewDataSource {
    private let dayInitial = NSDateFormatter().shortWeekdaySymbols
    private let cellIdentifier = "cId"
    private let cellHeight:CGFloat = 30
    private let headerLabelHeight: CGFloat = 33
    
    private var initialsCollectionView: UICollectionView?
    private var textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildCell()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildCell()
    }
    
    private func buildCell() {
        textLabel.frame = CGRectMake(0, 0, frame.width, headerLabelHeight)
        textLabel.textAlignment = NSTextAlignment.Center
        
        addSubview(textLabel)
    }
    
    func updateHeaderText(text: String) {
        textLabel.text = text
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        if initialsCollectionView == nil {
            initialsCollectionView = createDaysCollectionView()
            
            if var collectionView = initialsCollectionView {
                addSubview(collectionView)
                initialsCollectionView?.reloadData()
            }
        }
    }
    
    func createDaysCollectionView() -> UICollectionView {
        let yCoordinate = (frame.height - cellHeight)
        let collectionFrame = CGRectMake(0, yCoordinate, frame.width, cellHeight)
    
        let collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: MonthCalendarCollectionLayout(frame: collectionFrame, headerSize: CGSizeZero, itemHeight: cellHeight))
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollEnabled = false
        collectionView.registerClass(WeekDayNameCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        return collectionView
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dayInitial.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as WeekDayNameCell
        cell.weekNameLabel.text = dayInitial[indexPath.row] as? String
        
        return cell
    }
}
