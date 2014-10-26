//
//  MonthCalendarCollectionLayout.swift
//  CalendarControl
//
//  Created by Grzegorz Tatarzyn on 24/10/2014.
//  Copyright (c) 2014 gregttn. All rights reserved.
//

import UIKit

class MonthCalendarCollectionLayout: UICollectionViewFlowLayout {
    let columns: CGFloat = 7
    
    init(frame: CGRect) {
        super.init()
        setup(frame, headerSize: nil, itemHeight: nil)
    }
    
    init(frame: CGRect, headerSize: CGSize) {
        super.init()
        setup(frame, headerSize: headerSize, itemHeight: nil)
    }

    init(frame: CGRect, headerSize: CGSize, itemHeight: CGFloat) {
        super.init()
        setup(frame, headerSize: headerSize, itemHeight: itemHeight)
    }
    
    override init() {
        super.init()
        setup(CGRectZero, headerSize: nil, itemHeight: nil)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup(CGRectZero, headerSize: nil, itemHeight: nil)
    }
    
    private func setup(frame: CGRect, headerSize: CGSize?, itemHeight: CGFloat?){
        let remainder = frame.width % columns
        let cellSize = (frame.width-remainder) / columns
        
        var cellHeight = cellSize
        if var height = itemHeight {
            cellHeight = height
        }
        
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        sectionInset = UIEdgeInsets(top: 0, left: remainder/2, bottom: 0, right: remainder/2)
        
        if var hSize = headerSize {
            headerReferenceSize = hSize
            itemSize = CGSize(width: cellSize, height: cellHeight)
        } else {
            headerReferenceSize = CGSizeMake(frame.width, cellSize)
            itemSize = CGSize(width: cellSize, height: cellSize)
        }
    }
}
