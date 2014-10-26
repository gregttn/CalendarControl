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
    private let defaultMargin: CGFloat = 2
    var fillColor: UIColor = UIColor.whiteColor()
    
    init(frame: CGRect, fillColor color: UIColor) {
        super.init(frame: frame)
        fillColor = color
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        let drawingRectangle = CGRectMake(1,1,rect.size.width - defaultMargin,rect.size.height  - defaultMargin)
        let context: CGContextRef = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, fillColor.CGColor);
        CGContextSetAlpha(context, 1);
        CGContextFillEllipseInRect(context, drawingRectangle);
        
        CGContextSetStrokeColorWithColor(context, fillColor.CGColor);
        CGContextStrokeEllipseInRect(context, drawingRectangle);
    }
}