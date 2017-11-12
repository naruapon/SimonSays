//
//  GameData.swift
//  Simon Says
//
//  Created by Johannes Ruof on 06.04.16.
//  Copyright © 2016 Rume Academy. All rights reserved.
//

import UIKit

class GameData {
    
    let colors = ["Red","Green","Blue","Yellow"]
    
    let colorMapDictionary = [
        "Red": UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0),
        "Blue": UIColor(red: 34.0/255.0, green: 167.0/255.0, blue: 240.0/255.0, alpha: 1.0),
        "Green": UIColor(red: 46.0/255.0, green: 204.0/255.0, blue: 113.0/255.0, alpha: 1.0),
        "Yellow": UIColor(red: 248.0/255.0, green: 148.0/255.0, blue: 6.0/255.0, alpha: 1.0)
    ]
    
    var sequenceArray = [String]()
    
    var twoPlayer: Bool
    var player = 1
    
    init(multiplayer twoPlayer: Bool) {
        self.twoPlayer = twoPlayer
    }
    
    func switchPlayers() {
        if player == 1 {
            player = 2
        } else {
            player = 1
        }
    }
    
    func randomColor() -> UIColor {
        let randomColorIndex = Int(arc4random_uniform(UInt32(colors.count)))
        let randomColorString = colors[randomColorIndex]
        sequenceArray.append(randomColorString)
        
        let randomColor = colorMapDictionary[randomColorString]!
        return randomColor
    }
    
}