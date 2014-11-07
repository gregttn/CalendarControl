//
//  File.swift
//  CalendarControl
//
//  Created by Grzegorz Tatarzyn on 24/10/2014.
//  Copyright (c) 2014 gregttn. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    let calendarView = CalendarView(frame: CGRectZero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = UIView(frame: UIScreen.mainScreen().applicationFrame)
        view.backgroundColor = UIColor.whiteColor()
        
        calendarView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        view.addSubview(calendarView)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
