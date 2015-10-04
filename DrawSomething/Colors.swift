//
//  Colors.swift
//  DrawSomething
//
//  Created by Mac Bellingrath on 10/2/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import Foundation
import UIKit

class Colors: NSObject, UICollectionViewDataSource {
    
    
    let fillColors = [
       
        UIColor.redColor(),
        UIColor.whiteColor(),
        UIColor.cyanColor(),
        UIColor.orangeColor(),
        UIColor.greenColor(),
        UIColor.purpleColor(),
        UIColor.grayColor()
        
    ]
    
    
    let strokeColors = [
        
        UIColor.magentaColor(),
        UIColor.blueColor(),
        UIColor.yellowColor(),
        UIColor.greenColor()
    ]
    
    
    var isFill = true
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return isFill ? fillColors.count : strokeColors.count
        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Item", forIndexPath: indexPath)
        cell.backgroundColor = isFill ? fillColors[indexPath.item] : strokeColors[indexPath.item]
        
        return cell
    }
    
    
    
}