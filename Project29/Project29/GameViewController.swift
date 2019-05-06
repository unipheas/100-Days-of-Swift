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
}
