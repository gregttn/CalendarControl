//
//  MonthNavigationHeader.swift
//  CalendarControl
//
//  Created by Grzegorz Tatarzyn on 01/11/2014.
//  Copyright (c) 2014 gregttn. All rights reserved.
//

import UIKit

class MonthNavigationHeader: UICollectionReusableView {
    private let previousButtonTag = 11
    private let nextButtonTag = 12
   
    let MonthNavigationHeaderNextMonthSelected: String = "MonthNavigationHeaderNextMonthSelected"
    let MonthNavigationHeaderPreviousMonthSelected: String = "MonthNavigationHeaderNextMonthSelected"
    
    var title = UILabel()
    
    lazy private var next: UIButton = {
        return self.navigationButton(">>", tag: self.nextButtonTag)
    }()
    
    lazy private var previous: UIButton = {
        return self.navigationButton("<<", tag: self.previousButtonTag)
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
    
    private func navigationButton(title: String, tag: Int) -> UIButton {
        var button = UIButton()
        button.tag = tag
        button.setTitle(title, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        button.sizeToFit()
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin
        button.addTarget(self, action: "navigationButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return button
    }
    
    func navigationButtonPressed(button: UIButton) {
        switch button.tag {
            case previousButtonTag:
                notifyMonthChangeRequest(MonthNavigationHeaderPreviousMonthSelected)
            case nextButtonTag:
                notifyMonthChangeRequest(MonthNavigationHeaderNextMonthSelected)
            default:
                println("not known id")
        }
    }
    
    private func notifyMonthChangeRequest(notification: String) {
        NSNotificationCenter.defaultCenter().postNotificationName(notification, object: nil)
    }
}