//
//  ViewController.swift
//  Simon Says
//
//  Created by Johannes Ruof on 06.04.16.
//  Copyright © 2016 Rume Academy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var highscoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        highscoreLabel.text = "Highscore: " + String(UserDefaults.standard.integer(forKey: "Highscore"))
    }
    
    @IBAction func startGame(_ sender: AnyObject?) {
        let gameData = GameData(multiplayer: false)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ColorViewController") as? ColorViewController {
            vc.gameData = gameData
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func startMultiPlayerGame(_ sender: AnyObject?) {
        let gameData = GameData(multiplayer: true)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ColorViewController") as? ColorViewController {
            vc.gameData = gameData
            present(vc, animated: true, completion: nil)
        }
    }

}

