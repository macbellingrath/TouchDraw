//
//  ViewController.swift
//  DrawSomething
//
//  Created by Mac Bellingrath on 10/1/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var colorPallette: UICollectionView!
    
    @IBOutlet weak var controlPanelTop: NSLayoutConstraint!
    
    @IBOutlet weak var controlPanelView: UIView!
    
    @IBOutlet weak var isFillColor: BrushSelectionButton!
    
 
    
    @IBAction func toggleControlPanel(sender: AnyObject) {
        
        self.controlPanelTop.constant = self.controlPanelView.frame.origin.y == 0 ? -200 : 0
        
        toggleButton.transform = self.controlPanelTop.constant == 0 ?  CGAffineTransformMakeRotation(degreesToRadians(-180)) : CGAffineTransformMakeRotation(degreesToRadians(180))
       
        view.setNeedsUpdateConstraints()
        
        UIView.animateWithDuration(0.4) { () -> Void in
           
            
            self.view.setNeedsDisplay()
            
            self.view.layoutIfNeeded()
            
        }
        
    }
    
    
    
    
//    #define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
//    
//    double rads = DEGREES_TO_RADIANS(240);
//    CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, rads);
//    self.arrowView.transform = transform;
    
    let colorsSource = Colors()
    
    @IBOutlet weak var toggleButton: ToggleButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        colorPallette.delegate = self
        colorPallette.dataSource = colorsSource
        colorPallette.reloadData()
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            
            switch chosenTool {
            case 1:
                
                let newScribble = Scribble()
                
                newScribble.points.append(touch.locationInView(view))
                
                newScribble.strokeWidth = 10
                newScribble.strokeColor = chosenColor
                
                (view as? DrawView)?.lines.append(newScribble)
            case 2:
                ///// SHAPE
                
                let shape = Shape(type: .Circle)
                
                shape.start = touch.locationInView(view)
                //check for fill color 
                if let fillColor = isFillColor {
                    if fillColor == true {
                         shape.fillColor = UIColor.blackColor()
                    }
                }
                
                
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
    
    
    @IBAction func chooseTool(sender: AnyObject) {
        if let button = sender as? BrushSelectionButton{
        chosenTool = button.tag
        print(button.tag
            )
        
        }
        else {
            print("something went wrong'")
        }
    }
    
    var chosenColor: UIColor = UIColor.blackColor()
    
    @IBAction func chooseColor(sender: UIButton) {
        print(chosenColor)
        chosenColor = sender.backgroundColor ?? UIColor.blackColor()
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
   
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        chosenColor = cell?.backgroundColor ?? UIColor.blackColor()
       
        print(chosenColor)
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
    
    
    func degreesToRadians(x: Double) -> CGFloat {
        return CGFloat(M_PI * (x) / 180.0)
    }

}
