//
//  DayCell.swift
//  CalendarControl
//
//  Created by Grzegorz Tatarzyn on 24/10/2014.
//  Copyright (c) 2014 gregttn. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {
    private let selectedBackgroundId = 11
    private let circlePadding: CGFloat = 14.0
    private let dayLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildCell()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildCell()
    }
    
    func updateWithDay(day: Int) {
        dayLabel.text = "\(day)"
        dayLabel.frame = createBestFrame()
   }
    
    private func createBestFrame() -> CGRect {
        let bestSize: CGSize = dayLabel.sizeThatFits(frame.size)
        let frameWidth = bestSize.width + circlePadding > frame.size.width ? frame.size.width : bestSize.width + circlePadding;
        let frameHeight = bestSize.height + circlePadding > frame.size.height ? frame.size.height : bestSize.height + circlePadding;
        
        // redo with layout constrains
        let originX: CGFloat = (frame.size.width - frameWidth) / 2
        let originY: CGFloat = (frame.size.height - frameHeight) / 2

        return CGRectMake(originX, originY, frameWidth, frameHeight)
    }
    
    private func buildCell() {
        dayLabel.frame = CGRectZero
        dayLabel.backgroundColor = UIColor.clearColor()
        dayLabel.textAlignment = NSTextAlignment.Center
        
        addSubview(dayLabel)
    }
    
    func selected() {
        insertSelectedBackground()
        
        dayLabel.font = UIFont.boldSystemFontOfSize(dayLabel.font.pointSize)
    }
    
    func unselected() {
        removeSelectedBackground()
        
        dayLabel.font = UIFont.systemFontOfSize(dayLabel.font.pointSize)
    }
    
    private func insertSelectedBackground() {
        let selectionMarker = CircleView(frame: self.dayLabel.frame, fillColor: UIColor.lightGrayColor())
        selectionMarker.tag = selectedBackgroundId;
        insertSubview(selectionMarker, atIndex:0)
    }
    
    private func removeSelectedBackground() {
        let selectionMarker = viewWithTag(selectedBackgroundId)
        
        if var marker = selectionMarker {
            marker.removeFromSuperview()
        }
    }
}
