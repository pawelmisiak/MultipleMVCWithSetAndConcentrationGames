//
//  GameView.swift
//  drawing practice
//
//  Created by Pawel Misiak on 10/30/18.
//  Copyright © 2018 Pawel Misiak. All rights reserved.
//

import UIKit

class GameView: UIView {
    
    override func layoutSubviews() {
        super .layoutSubviews()
        
        let setGrid = Grid(for: self.frame, withNoOfFrames: self.subviews.count, forIdeal: 2.0)
        
        for index in self.subviews.indices {
            if var frame = setGrid[index] {
                frame.size.width -= 5
                frame.size.height -= 5
                self.subviews[index].frame = frame
            }
        }
    }
    
}
