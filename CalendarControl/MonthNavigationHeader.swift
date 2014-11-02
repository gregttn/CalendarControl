//
//  MonthNavigationHeader.swift
//  CalendarControl
//
//  Created by Grzegorz Tatarzyn on 01/11/2014.
//  Copyright (c) 2014 gregttn. All rights reserved.
//

import UIKit

class MonthNavigationHeader: UICollectionReusableView {
    var title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        build()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        build()
    }
    
    func build() {
        title.frame = frame
        title.textAlignment = NSTextAlignment.Center
        
        addSubview(title)
    }
}