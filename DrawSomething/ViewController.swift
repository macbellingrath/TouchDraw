//
//  ViewController.swift
//  DrawSomething
//
//  Created by Mac Bellingrath on 10/1/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var controlPanelTop: NSLayoutConstraint!
    
    @IBOutlet weak var controlPanelView: UIView!
    
    @IBAction func toggleControlPanel(sender: AnyObject) {
        
        self.controlPanelTop.constant = self.controlPanelView.frame.origin.y == 0 ? -200 : 0
        view.setNeedsUpdateConstraints()
        
        UIView.animateWithDuration(0.4) { () -> Void in
            
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            
            switch chosenTool {
            case 1:
                
                let newScribble = Scribble()
                
                newScribble.points.append(touch.locationInView(view))
                
                newScribble.strokeWidth = 10
                newScribble.strokeColor = UIColor.blackColor()
                
                (view as? DrawView)?.lines.append(newScribble)
            case 2:
                ///// SHAPE
                
                let shape = Shape(type: .Circle)
                
                shape.start = touch.locationInView(view)
                shape.fillColor = UIColor.blackColor()
                
                (view as? DrawView)?.lines.append(shape)
                
                view.setNeedsDisplay()
                

            case 3: drawShape(withShape: .Rectangle, andTouch: touch)
            case 4: drawShape(withShape: .Triangle, andTouch: touch)
                
            case 5:
                drawShape(withShape: .Diamond, andTouch: touch)
            default:
                /// LINE
                
                            let newLine = Line()
                
                            newLine.start = touch.locationInView(view)
                            newLine.strokeColor = UIColor.blackColor()
                            newLine.strokeWidth = 10
                
                            (view as? DrawView)?.lines.append(newLine)
                
                
            }

            
                   }
        
    }
    
    
    
    var chosenTool = 0
    
    
    @IBAction func chooseTool(sender: UIButton) {
        
        chosenTool = sender.tag
        
        
        
    }
    
    var chosenColor: UIColor = UIColor.blackColor()
    
    @IBAction func chooseColor(sender: UIButton) {
        print(chosenColor)
        chosenColor = sender.backgroundColor ?? UIColor.blackColor()
        
    }
    
    
    @IBAction func undo(sender: UIButton) {
        
        if (view as? DrawView)?.lines.count > 0 {
        
        (view as? DrawView)?.lines.removeLast()
    view.setNeedsDisplay()
        }
        
    }
    
    @IBAction func clearAction(sender: UIButton) {
        
        (view as? DrawView)?.lines = []
        view.setNeedsDisplay()
        
        
    }
    
   
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            
            
            if let currentScribble = (view as? DrawView)?.lines.last as? Scribble {
                currentScribble.points.append(touch.locationInView(view))
                view.setNeedsDisplay()
                
            } else if let currentLine = (view as? DrawView)?.lines.last {
                currentLine.end = touch.locationInView(view)
                view.setNeedsDisplay()
            }
            
            ///// LINE
            //
            //            if let currentLine = (view as? DrawView)?.lines.last {
            //
            //                currentLine.end = touch.locationInView(view)
            //
            //                view.setNeedsDisplay()
            //
            //            }
            
            ///// SCRIBBLE
            
            //            if let currentScribble = (view as? DrawView)?.lines.last as? Scribble {
            //
            //                currentScribble.points.append(touch.locationInView(view))
            //
            //                view.setNeedsDisplay()
            //
            //            }
            
            ///// SHAPE
            
            
          
            
            
        }
        
    }
    
    func drawShape(withShape shape: ShapeType, andTouch touch: UITouch) {
       
        if let currentShape = (view as? DrawView)?.lines.last {
            currentShape.end = touch.locationInView(view)
        }
        
        let shape = Shape(type: shape)
        
        
        shape.start = touch.locationInView(view)

        
        
        
        
        
        
        
        (view as? DrawView)?.lines.append(shape)
        
        
        
        
        
        view.setNeedsDisplay()
    
    
}

}
