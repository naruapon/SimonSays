//
//  ButtonsViewController.swift
//  Simon Says
//
//  Created by Johannes Ruof on 06.04.16.
//  Copyright © 2016 Rume Academy. All rights reserved.
//

import UIKit
import AVFoundation

class ButtonsViewController: UIViewController {
    
    var correctSound: AVAudioPlayer?
    var wrongSound: AVAudioPlayer?
    
    var gameData: GameData!
    
    var index = 0
    
    var highscore = UserDefaults.standard.integer(forKey: "Highscore")
    
    @IBOutlet var colorButtons: [ColorButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        createAudioPlayers()
        configureButtons()
    }
    
    func createAudioPlayers() {
        if let correctSound = createAudioPlayerForFile("correct", ofType: "aiff") {
            self.correctSound = correctSound
            correctSound.prepareToPlay()
        }
        if let wrongSound = createAudioPlayerForFile("wrong", ofType: "aiff") {
            self.wrongSound = wrongSound
            wrongSound.prepareToPlay()
        }
    }
    
    func configureButtons() {
        for (index,button) in colorButtons.enumerated() {
            button.color = gameData.colors[index]
            button.backgroundColor = gameData.colorMapDictionary[button.color!]
        }
    }
    
    func showAlert(forPlayer player: Int, andReason reason: Int) {
        switch reason {
        case 0:
            let alertController = UIAlertController(title: "Player \(player)", message: "Are you ready?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Start", style: .default, handler: { (action: UIAlertAction) -> Void in
                self.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(ok)
            present(alertController, animated: true, completion: nil)
        case 1:
            let alertController = UIAlertController(title: "Wrong Answer", message: "Player \(player) won the game!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Continue", style: .default, handler: { (action: UIAlertAction) -> Void in
                if let vc = self.presentingViewController as? ColorViewController {
                    vc.gameOver = true
                    self.dismiss(animated: false, completion: nil)
                }
            })
            alertController.addAction(ok)
            present(alertController, animated: true, completion: nil)
        default:
            break
        }
    }
    
    func createAudioPlayerForFile(_ file: String, ofType type: String) -> AVAudioPlayer? {
        let path = Bundle.main.path(forResource: file, ofType: type)
        let url = URL(fileURLWithPath: path!)
        
        let audioPlayer = try? AVAudioPlayer(contentsOf: url)
        
        return audioPlayer
    }
    
    @IBAction func buttonHandler(_ sender: ColorButton) {
        if sender.color == gameData.sequenceArray[index] {
            correctSound?.play()
            index += 1
            if index >= gameData.sequenceArray.count {
                gameData.switchPlayers()
                showAlert(forPlayer: gameData.player, andReason: 0)
            }
        } else {
            wrongSound?.play()
            if (gameData.sequenceArray.count - 1) > highscore {
                UserDefaults.standard.set((gameData.sequenceArray.count - 1), forKey: "Highscore")
            }
            gameData.switchPlayers()
            showAlert(forPlayer: gameData.player, andReason: 1)
        }
    }

}
