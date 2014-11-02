//
//  WeekDayCell.swift
//  CalendarControl
//
//  Created by Grzegorz Tatarzyn on 24/10/2014.
//  Copyright (c) 2014 gregttn. All rights reserved.
//

import UIKit


class WeekdaySymbolCell: UICollectionViewCell {
    let symbol: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildCell()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildCell()
    }
    
    private func buildCell() {
        symbol.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        symbol.backgroundColor = UIColor.grayColor()
        symbol.textAlignment = NSTextAlignment.Center
        symbol.textColor = UIColor.whiteColor()
        symbol.font = UIFont.boldSystemFontOfSize(symbol.font.pointSize)
        
        addSubview(symbol)
    }
}