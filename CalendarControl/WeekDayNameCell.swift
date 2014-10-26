//
//  WeekDayCell.swift
//  CalendarControl
//
//  Created by Grzegorz Tatarzyn on 24/10/2014.
//  Copyright (c) 2014 gregttn. All rights reserved.
//

import UIKit


class WeekDayNameCell: UICollectionViewCell {
    let weekNameLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildCell()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildCell()
    }
    
    private func buildCell() {
        weekNameLabel.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        weekNameLabel.backgroundColor = UIColor.grayColor()
        weekNameLabel.textAlignment = NSTextAlignment.Center
        weekNameLabel.textColor = UIColor.whiteColor()
        weekNameLabel.font = UIFont.boldSystemFontOfSize(weekNameLabel.font.pointSize)
        
        addSubview(weekNameLabel)
    }
}