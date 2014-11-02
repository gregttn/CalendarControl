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
    
    lazy private var next: UIButton = {
        return self.navigationButton(">>")
    }()
    
    lazy private var previous: UIButton = {
        return self.navigationButton("<<")
    }()
    
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
        
        addSubview(next)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[btn]|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: ["btn":next]))
        
        addSubview(previous)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[btn]", options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: ["btn":previous]))
    }
    
    private func navigationButton(title: String) -> UIButton {
        var button = UIButton()
        button.setTitle(title, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        button.sizeToFit()
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        button.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin
        
        
        return button
    }
}