//
//  GameSelectorViewController.swift
//  MultipleMVC
//
//  Created by Pawel Misiak on 11/20/18.
//  Copyright © 2018 Pawel Misiak. All rights reserved.
//

import UIKit

class GameSelectorViewController: UIViewController {
    
    let themes = [
        ["👻","🎃","☠️","👹","😈","🧟‍♂️","🧛🏻‍♂️","☄️","🍬"],
        ["🤾‍♀️","🏊‍♂️","🥊","🏈","🚴‍♂️","🏓","🏌🏻‍♂️","⚽️","🎳"],
        ["🍝","🥓","🍜","🥞","🍕","🍟","🍔","🌮","🌭"],
        ["🇵🇱","🇺🇸","🇵🇹","🇦🇷","🇨🇦","🇮🇹","🇩🇪","🇯🇵","🏴󠁧󠁢󠁥󠁮󠁧󠁿"],
        ["🛸","🛥","🚂","🚅","🚲","🚜","🚗","✈️","🚀"],
        ["😇","😤","😑","🤢","😱","😂","😎","😡","😀"],
        ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let button = sender as? UIButton {
                if let themeName = button.currentTitle {
                    
                }
            }
        }
    }
}
