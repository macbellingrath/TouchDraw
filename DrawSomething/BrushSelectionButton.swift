//
//  BrushSelectionButton.swift
//  DrawSomething
//
//  Created by Mac Bellingrath on 10/4/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit

@IBDesignable
class BrushSelectionButton: UIButton {
    
    @IBInspectable var status = true
    
    @IBInspectable var shapeType: Int = 0

       override func drawRect(rect: CGRect) {
        // Drawing code
        
        
        //Get Current Context
        let context = UIGraphicsGetCurrentContext()
        
        //Set Color
        UIColor.blackColor().set()
        
        
        //Draw Oval 
        let circleInset = CGRectInset(rect, 2, 2)
        CGContextStrokeEllipseInRect(context, circleInset)
        
        //Draw Brush Style in Button
        let top = CGPoint(x: circleInset.midX , y: circleInset.minY + 3)
        let right = CGPoint(x: circleInset.midX + 8 ,y: circleInset.midY + 8)
        let left = CGPoint(x: circleInset.midX - 8 , y: circleInset.maxY - 5)

        
        
        switch tag {
            //line
        case 0: CGContextMoveToPoint(context, rect.minX + 5, rect.width/2)
                CGContextAddLineToPoint(context, rect.maxX - 5 , rect.width/2)
                CGContextStrokePath(context)
            //squiggle
        case 1:
        CGContextMoveToPoint(context, rect.minX + 5, rect.width/2)
        CGContextAddArcToPoint(context, rect.midX - 3, (rect.width/2) - 4, rect.midX - 1, (rect.width/2) + 5, 1)
        CGContextAddArcToPoint(context, rect.midX - 1, (rect.width/2) + 5, rect.midX + 7, (rect.width/2) - 2, 1)
        CGContextAddArcToPoint(context, rect.midX + 7, (rect.width/2) - 2, rect.midX + 10, (rect.width/2) + 5, 1)
        CGContextStrokePath(context)
           //circle
        case 2: CGContextStrokeEllipseInRect(context, CGRectInset(rect, 10, 10))
            //rect
        case 3: CGContextStrokeRect(context, CGRectInset(rect, 10, 10))
            //triangle
        case 4:
            
            
            CGContextMoveToPoint(context, top.x, top.y)
            CGContextAddLineToPoint(context, right.x, right.y)
            CGContextAddLineToPoint(context, left.x, left.y)
            CGContextAddLineToPoint(context, top.x, top.y)            
            CGContextStrokePath(context)

            
            
            //diamond
        case 5:
   
            let bottom = CGPoint(x: (circleInset.width / 2) + 2, y: circleInset.maxY - 4 )
            
            CGContextMoveToPoint(context, top.x, top.y + 2)
            CGContextAddLineToPoint(context, right.x, right.y - 6)
            CGContextAddLineToPoint(context, bottom.x, bottom.y - 1)
            CGContextAddLineToPoint(context, left.x, left.y - 6 )
            CGContextAddLineToPoint(context, top.x, top.y + 2)
            CGContextStrokePath(context)
            
        case 7:
            if !status {
            CGContextMoveToPoint(context, rect.minX + 5, rect.width/2)
            CGContextAddLineToPoint(context, rect.maxX - 5 , rect.width/2)
            CGContextStrokePath(context)
            } else if status {
                CGContextMoveToPoint(context, rect.minX + 5, rect.width/2)
                CGContextAddLineToPoint(context, rect.maxX - 5 , rect.width/2)
                CGContextSetLineWidth(context, 10)
                CGContextStrokePath(context)
                
            }

            

        default:
            CGContextStrokeRect(context, CGRectInset(rect, 10, 10))
            
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
           
            if tag == 7 {
                if status {
                    status = false
                } else  if !status {
                    status = true
                }
                setNeedsDisplay()
                
            }
        }
    }
    
    


}
