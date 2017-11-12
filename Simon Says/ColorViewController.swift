//
//  ColorViewController.swift
//  Simon Says
//
//  Created by Johannes Ruof on 06.04.16.
//  Copyright © 2016 Rume Academy. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {
    
    var gameData: GameData!
    
    var index = 0
    
    var timer = Timer()
    
    var gameOver: Bool?
    
    let switchColor = UIColor(red: 218.0/255.0, green: 223.0/255.0, blue: 225.0/255.0, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (gameOver != nil) {
            dismiss(animated: false, completion: nil)
            return
        }
        if gameData.sequenceArray.isEmpty {
            changeToRandomColor()
        } else {
            index += 1
            if index < gameData.sequenceArray.count {
                timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(displayNextColor), userInfo: nil, repeats: false)
            } else {
                timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeToRandomColor), userInfo: nil, repeats: false)
            }
        }
    }
    
    func changeToRandomColor() {
        timer.invalidate()
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.backgroundColor = self.switchColor
            self.view.backgroundColor = self.gameData.randomColor()
        })
        
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(returnToButtons), userInfo: nil, repeats: false)
    }
    
    func displayNextColor() {
        timer.invalidate()
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.backgroundColor = self.switchColor
            self.view.backgroundColor = self.gameData.colorMapDictionary[self.gameData.sequenceArray[self.index]]
        })
        
        index += 1
        if index < gameData.sequenceArray.count {
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(displayNextColor), userInfo: nil, repeats: false)
        } else {
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeToRandomColor), userInfo: nil, repeats: false)
        }
    }
    
    func returnToButtons() {
        timer.invalidate()
        index = 0
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ButtonsViewController") as? ButtonsViewController {
            vc.gameData = gameData
            present(vc, animated: true, completion: nil)
        }
        view.backgroundColor = gameData.colorMapDictionary[gameData.sequenceArray[index]]
    }

}
