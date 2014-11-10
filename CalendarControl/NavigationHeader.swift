//
//  MonthNavigationHeader.swift
//  CalendarControl
//
//  Created by Grzegorz Tatarzyn on 01/11/2014.
//  Copyright (c) 2014 gregttn. All rights reserved.
//

import UIKit

class NavigationHeader: UICollectionReusableView {
    private let previousButtonTag = 11
    private let nextButtonTag = 12
   
    let NavigationHeaderNextMonthSelected: String = "NavigationHeaderNextMonthSelected"
    let NavigationHeaderPreviousMonthSelected: String = "NavigationHeaderNextMonthSelected"
    
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
        title.sizeToFit()
        title.textAlignment = NSTextAlignment.Center
        title.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        addSubview(title)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[superview]-(<=1)-[label]", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["superview":self, "label":title]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[superview]-(<=1)-[label]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["superview":self, "label":title]))

        
        addSubview(next)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[btn]|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: ["btn":next]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[superview]-(<=1)-[btn]", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["superview":self, "btn":next]))
        
        addSubview(previous)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[btn]", options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: ["btn":previous]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[superview]-(<=1)-[btn]", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["superview":self, "btn":previous]))
    }
    
    private func navigationButton(title: String, tag: Int) -> UIButton {
        var button = UIButton()
        button.tag = tag
        button.setTitle(title, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        button.sizeToFit()
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.addTarget(self, action: "navigationButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }
    
    func navigationButtonPressed(button: UIButton) {
        switch button.tag {
            case previousButtonTag:
                notifyMonthChangeRequest(NavigationHeaderPreviousMonthSelected)
            case nextButtonTag:
                notifyMonthChangeRequest(NavigationHeaderNextMonthSelected)
            default:
                println("not known id")
        }
    }
    
    private func notifyMonthChangeRequest(notification: String) {
        NSNotificationCenter.defaultCenter().postNotificationName(notification, object: nil)
    }
}