//
//  CircleView.swift
//  CalendarControl
//
//  Created by Grzegorz Tatarzyn on 24/10/2014.
//  Copyright (c) 2014 gregttn. All rights reserved.
//

import UIKit
import QuartzCore

class CircleView: UIView {
    init(frame: CGRect, fillColor color: UIColor) {
        super.init(frame: frame)
        self.backgroundColor = color
        
        self.layer.cornerRadius = frame.height/2
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}