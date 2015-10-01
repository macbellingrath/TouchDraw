//
//  ToggleButton.swift
//  DrawSomething
//
//  Created by Mac Bellingrath on 10/1/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit

@IBDesignable

class ToggleButton: UIButton {
    
    @IBInspectable var strokeWidth: CGFloat = 1
    
    @IBInspectable var circleInset: CGFloat = 0
    
//    @IBInspectable var indicator: DrawView
    

        override func drawRect(rect: CGRect) {
            
            let midX = CGRectGetMidX(rect)
            let midY = CGRectGetMidY(rect)
            
      
            
            let context = UIGraphicsGetCurrentContext()
            
            let insetRect = CGRectInset(rect, circleInset, circleInset)
            
            tintColor.set()
            
            CGContextSetLineWidth(context, strokeWidth)
            
            CGContextStrokeEllipseInRect(context, insetRect)
            
            
            
            CGContextMoveToPoint(context, circleInset + 10, midY - 2)
         
            CGContextAddLineToPoint(context, midX, midY + 8)
           
            CGContextAddLineToPoint(context, rect.width - circleInset - 10, midY - 3 )
           
            
            CGContextStrokePath(context)
            
            
            
            
            
            
            
           
            
        
            
    }


}
