//
//  GameScene.swift
//  Project23
//
//  Created by Brian Phillips on 4/4/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
	
	var starfield: SKEmitterNode!
	var player: SKSpriteNode!
	var scoreLabel: SKLabelNode!
	
	var possibleEnemies = ["ball", "hammer", "tv"]
	var isGameOver = false
	var gameTimer: Timer?
	var fingerLifted: CGPoint?
	
	var counter = 0
	
	var score = 0 {
		didSet {
			scoreLabel.text = "Score: \(score)"
		}
	}
    
    override func didMove(to view: SKView) {
		backgroundColor = .black
		
		starfield = SKEmitterNode(fileNamed: "Starfield")!
		starfield.position = CGPoint(x: 1024, y: 384)
		starfield.advanceSimulationTime(10)
		addChild(starfield)
		starfield.zPosition = -1
		
		player = SKSpriteNode(imageNamed: "player")
		player.position = CGPoint(x: 100, y: 384)
		player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
		player.physicsBody?.contactTestBitMask = 1
		addChild(player)
		
		scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
		scoreLabel.position = CGPoint(x: 16, y: 16)
		scoreLabel.horizontalAlignmentMode = .left
		addChild(scoreLabel)
		
		score = 0
		
		physicsWorld.gravity = CGVector(dx: 0, dy: 0)
		physicsWorld.contactDelegate = self
		
		setGameTimer(1)
    }
	
	@objc func createEnemy() {
		guard let enemy = possibleEnemies.randomElement() else { return }
		
		let sprite = SKSpriteNode(imageNamed: enemy)
		sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
		addChild(sprite)
		
		sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
		sprite.physicsBody?.categoryBitMask = 1
		sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
		sprite.physicsBody?.angularVelocity = 5
		sprite.physicsBody?.linearDamping = 0
		sprite.physicsBody?.angularDamping = 0
		
		counter += 1
	}
	
	override func update(_ currentTime: TimeInterval) {
		for node in children {
			if node.position.x < -300 {
				node.removeFromParent()
			}
		}
		
		if !isGameOver {
			score += 1
		}
		
		if counter == 20 {
			let interval = gameTimer?.timeInterval
			gameTimer?.invalidate()
			counter = 0
			setGameTimer(interval! - 0.1)
		}
	}
	
	func setGameTimer(_ timer: Double) {
		gameTimer = Timer.scheduledTimer(timeInterval: timer, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		var location = touch.location(in: self)
		
		if location.y < 100 {
			location.y = 100
		} else if location.y > 668 {
			location.y = 668
		}
		
		player.position = location
	}
	
	func didBegin(_ contact: SKPhysicsContact) {
		let explosion = SKEmitterNode(fileNamed: "explosion")!
		explosion.position = player.position
		addChild(explosion)
		
		player.removeFromParent()
		
		isGameOver = true
		gameTimer?.invalidate()
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		let location = touch.location(in: self)
		
		fingerLifted = location
	}
}
