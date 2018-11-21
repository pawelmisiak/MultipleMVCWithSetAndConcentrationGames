//
//  PlayingCardView.swift
//  drawing practice
//
//  Created by Pawel Misiak on 10/25/18.
//  Copyright © 2018 Pawel Misiak. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIView {
    
    var shape: String = ""
    
    var numberOfObjects: Int = 0
    
    var color: UIColor = UIColor.white
    
    var lineWidth: Float = 3.0
    
    var shade: String = ""
    
    /* Diamonds */
    
    func diamond(path: UIBezierPath) -> UIBezierPath {
        let leftCorner = CGPoint(x: bounds.width * 0.36, y: bounds.height * 0.5)
        let rightCorner = CGPoint(x: bounds.width - (bounds.width * 0.36), y: bounds.height * 0.5)
        let topCorner = CGPoint(x: bounds.midX, y: bounds.height * 0.25)
        let bottomCorner = CGPoint(x: bounds.midX, y: bounds.height * 0.75)
        
        path.move(to: leftCorner)
        path.addLine(to: topCorner)
        path.addLine(to: rightCorner)
        path.addLine(to: bottomCorner)
        path.close()
        
        return path
    }
    
    /* Ovals */
    
    func oval(path: UIBezierPath) -> UIBezierPath {
        let leftTop = CGPoint(x: bounds.width * 0.4, y: bounds.height * 0.2)
        
        let ctrPoint1 = CGPoint(x: bounds.width * 0.4, y: bounds.height * 0.1)
        let ctrPoint2 = CGPoint(x: bounds.width * 0.6, y: bounds.height * 0.1)
        
        let RightTop = CGPoint(x: bounds.width * 0.6, y: bounds.height * 0.2)
        let RightBottom = CGPoint(x: bounds.width * 0.6, y: bounds.height * 0.8)
        
        let centerBottom1 = CGPoint(x: bounds.width * 0.4, y: bounds.height * 0.9)
        let centerBottom2 = CGPoint(x: bounds.width * 0.6, y: bounds.height * 0.9)
        
        let LeftBottom = CGPoint(x: bounds.width * 0.4, y: bounds.height * 0.8)
        
        path.move(to: leftTop)
        path.addCurve(to: RightTop, controlPoint1: ctrPoint1, controlPoint2: ctrPoint2)
        path.addLine(to: RightBottom)
        path.addCurve(to: LeftBottom, controlPoint1: centerBottom2, controlPoint2: centerBottom1)
        path.close()
        
        return path
    }
    
    /* Squigle */
    
    func squigle(path: UIBezierPath) -> UIBezierPath {
        let leftTop = CGPoint(x: bounds.width * 0.4, y: bounds.height * 0.2)
        let AB_ctrPoint1 = CGPoint(x: bounds.width * 0.4, y: bounds.height * 0.1)
        let AB_ctrPoint2 = CGPoint(x: bounds.width * 0.6, y: bounds.height * 0.1)
        let RightTop = CGPoint(x: bounds.width * 0.6, y: bounds.height * 0.2)
        
        let centerRight = CGPoint(x: bounds.width * 0.6, y: bounds.height * 0.5)
        let B_ctrPoint1 = CGPoint(x: bounds.width * 0.7, y: bounds.height * 0.3)
        let B_ctrPoint2 = CGPoint(x: bounds.width * 0.7, y: bounds.height * 0.4)
        
        let bottomRight = CGPoint(x: bounds.width * 0.6, y: bounds.height * 0.8)
        let D_ctrPoint1 = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.6)
        let D_ctrPoint2 = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.7)
        
        let DC_controlPoint1 = CGPoint(x: bounds.width * 0.4, y: bounds.height * 0.9)
        let DC_controlPoint2 = CGPoint(x: bounds.width * 0.6, y: bounds.height * 0.9)
        let LeftBottom = CGPoint(x: bounds.width * 0.4, y: bounds.height * 0.8)
        
        let centerLeft = CGPoint(x: bounds.width * 0.4, y: bounds.height * 0.5)
        let C_ctrPoint1 = CGPoint(x: bounds.width * 0.3, y: bounds.height * 0.7)
        let C_ctrPoint2 = CGPoint(x: bounds.width * 0.3, y: bounds.height * 0.6)
        
        let A_ctrPoint1 = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.4)
        let A_ctrPoint2 = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.3)
        
        path.move(to: leftTop)
        path.addCurve(to: RightTop, controlPoint1: AB_ctrPoint1, controlPoint2: AB_ctrPoint2)
        path.addCurve(to: centerRight, controlPoint1: B_ctrPoint1, controlPoint2: B_ctrPoint2)
        path.addCurve(to: bottomRight, controlPoint1: D_ctrPoint1, controlPoint2: D_ctrPoint2)
        path.addCurve(to: LeftBottom, controlPoint1: DC_controlPoint2, controlPoint2: DC_controlPoint1)
        path.addCurve(to: centerLeft, controlPoint1: C_ctrPoint1, controlPoint2: C_ctrPoint2)
        path.addCurve(to: leftTop, controlPoint1: A_ctrPoint1, controlPoint2: A_ctrPoint2)
        
        return path
    }
    
    
    func createShade(path: UIBezierPath) -> UIBezierPath {
        if shade == "striped" {
            path.addClip()
            var start = CGPoint(x: 0.0, y: 0.0)
            var end = CGPoint(x: bounds.width, y: 0.0)
            let move: CGFloat = bounds.height / 15.0
            while start.y <= bounds.height {
                path.move(to: start)
                path.addLine(to: end)
                start.y += move
                end.y += move
            }
            
        } else if shade == "full" {
            color.setFill()
            path.fill()
        } else {
            return path
        }
        
        return path
    }
    
    
    override func draw(_ rect: CGRect) {
        var path = UIBezierPath()
        let pathToReturn = UIBezierPath()
        var path_1 = UIBezierPath()
        if shape == "oval" {
            path_1 = oval(path: pathToReturn)
        } else if shape == "diamond" {
            path_1 = diamond(path: pathToReturn)
        } else {
            path_1 = squigle(path: pathToReturn)
        }
        
        let twoSpace = self.bounds.width * 0.15
        let threeSpace = self.bounds.width * 0.3
        
        
        if numberOfObjects == 1 {
            path.append(path_1)
        } else if numberOfObjects == 2 {
            let leftPath = UIBezierPath()
            leftPath.append(path_1)
            
            let leftTransform = CGAffineTransform(translationX: CGFloat(twoSpace * (-1)), y: CGFloat(0))
            leftPath.apply(leftTransform)
            
            let rightPath = UIBezierPath()
            rightPath.append(path_1)
            let rightTransform = CGAffineTransform(translationX: CGFloat(twoSpace), y: CGFloat(0))
            rightPath.apply(rightTransform)
            
            path.append(leftPath)
            path.append(rightPath)
        } else if numberOfObjects == 3 {
            let leftPath = UIBezierPath()
            leftPath.append(path_1)
            let leftTransform = CGAffineTransform(translationX: CGFloat(threeSpace * (-1)), y: CGFloat(0))
            leftPath.apply(leftTransform)
            
            let rightPath = UIBezierPath()
            rightPath.append(path_1)
            let rightTransform = CGAffineTransform(translationX: CGFloat(threeSpace), y: CGFloat(0))
            rightPath.apply(rightTransform)
            
            path.append(pathToReturn)
            path.append(leftPath)
            path.append(rightPath)
        }
        
        path = createShade(path: path)
        
        color.setStroke()
        path.lineWidth = CGFloat(lineWidth)
        path.stroke()
    }
}
