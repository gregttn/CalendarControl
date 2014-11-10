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
    private let highligtedBackgroundId = 12
    private let circlePadding: CGFloat = 14.0
    private let dayLabel: UILabel = UILabel()
    
    var highlightedColour = UIColor(red: 232.0/255.0, green: 232.0/255.0, blue: 238.0/255.0, alpha: 1)
    var selectedColour = UIColor.lightGrayColor()
    
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
    }
    
    func clear() {
        dayLabel.text = ""
    }
    
    private func createBestFrame() -> CGRect {
        let label = UILabel()
        label.text = "00"
        
        let bestSize: CGSize = label.sizeThatFits(frame.size)
        let frameWidth = bestSize.width + circlePadding > frame.size.width ? frame.size.width : bestSize.width + circlePadding;
        let frameHeight = bestSize.height + circlePadding > frame.size.height ? frame.size.height : bestSize.height + circlePadding;
        
        // redo with layout constrains
        let originX: CGFloat = (frame.size.width - frameWidth) / 2
        let originY: CGFloat = (frame.size.height - frameHeight) / 2

        return CGRectMake(originX, originY, frameWidth, frameHeight)
    }
    
    private func buildCell() {
        dayLabel.frame = createBestFrame()
        dayLabel.backgroundColor = UIColor.clearColor()
        dayLabel.textAlignment = NSTextAlignment.Center
        
        addSubview(dayLabel)
    }
    
    func select() {
        insertSelectedBackground(selectedColour, backgroundId: selectedBackgroundId)
        
        dayLabel.font = UIFont.boldSystemFontOfSize(dayLabel.font.pointSize)
    }
    
    func deselect() {
        removeSelectedBackground(selectedBackgroundId)
    }
    
    func highlight() {
        insertSelectedBackground(highlightedColour, backgroundId: highligtedBackgroundId)
    }
    
    func unhighlight() {
        removeSelectedBackground(highligtedBackgroundId)
    }
    
    private func insertSelectedBackground(highlightColor: UIColor, backgroundId: Int) {
        if viewWithTag(backgroundId) == nil {
            let selectionMarker = CircleView(frame: dayLabel.frame, fillColor: highlightColor)
            selectionMarker.tag = backgroundId;
            insertSubview(selectionMarker, atIndex:0)
        }
    }
    
    private func removeSelectedBackground(backgroundId: Int) {
        viewWithTag(backgroundId)?.removeFromSuperview()
    }
}
