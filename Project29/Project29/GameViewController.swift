//
//  GameViewController.swift
//  Project29
//
//  Created by Brian Phillips on 5/6/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
	
	var currentGame: GameScene!

	@IBOutlet var angelSlider: UISlider!
	@IBOutlet var angleLabel: UILabel!
	@IBOutlet var velocitySlider: UISlider!
	@IBOutlet var velocityLabel: UILabel!
	@IBOutlet var launchButton: UIButton!
	@IBOutlet var playerNumber: UILabel!
	@IBOutlet var playerOneScore: UILabel!
	@IBOutlet var playerTwoScore: UILabel!
	
	var oneScore = 0
	var twoScore = 0
	
	override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
				
				currentGame = scene as? GameScene
				currentGame.viewController = self
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
		
		angelChanged(self)
		velocityChanged(self)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
	
	@IBAction func angelChanged(_ sender: Any) {
		angleLabel.text = "Angle: \(Int(angelSlider.value))°"
	}
	
	@IBAction func velocityChanged(_ sender: Any) {
		velocityLabel.text = "Velocity: \(Int(velocitySlider.value))"
	}
	
	@IBAction func launch(_ sender: Any) {
		angelSlider.isHidden = true
		angleLabel.isHidden = true
		
		velocitySlider.isHidden = true
		velocityLabel.isHidden = true
		
		launchButton.isHidden = true
		
		currentGame.launch(angle: Int(angelSlider.value), velocity: Int(velocitySlider.value))
	}
	
	func activatePlayer(number: Int) {
		if number == 1 {
			playerNumber.text = "<<< PLAYER ONE"
		} else {
			playerNumber.text = "PLAYER TWO >>>"
		}
		
		angelSlider.isHidden = false
		angleLabel.isHidden = false
		
		velocitySlider.isHidden = false
		velocityLabel.isHidden = false
		
		launchButton.isHidden = false
	}
	
	func updateScore(for player: Int) {
		if player == 1 {
			oneScore += 1
			playerOneScore.text = "PLAYER ONE: \(oneScore)"
		} else {
			twoScore += 1
			playerTwoScore.text = "PLAYER TWO: \(twoScore)"
		}
		
		if oneScore == 3 {
			alert("Player one has won the game!")
			resetScore()
		}
		
		if twoScore == 3 {
			alert("Player two has won the game!")
			resetScore()
		}
	}
	
	func resetScore() {
		oneScore = 0
		playerOneScore.text = "PLAYER ONE: \(oneScore)"
		twoScore = 0
		playerTwoScore.text = "PLAYER TWO: \(twoScore)"
	}
	
	func alert(_ message: String) {
		let ac = UIAlertController(title: "WON!", message: message, preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "Okay", style: .default))
		present(ac, animated: true)
	}
}
