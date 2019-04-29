//
//  GameScene.swift
//  Project26
//
//  Created by Brian Phillips on 4/27/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import CoreMotion
import SpriteKit
import UIKit

enum CollisionTypes: UInt32 {
	case player = 1
	case wall = 2
	case star = 4
	case vortex = 8
	case finish = 16
}

class GameScene: SKScene, SKPhysicsContactDelegate {
	
	var player: SKSpriteNode!
	var lastTouchPosition: CGPoint?
	var motionManager: CMMotionManager!
	
	var scoreLabel: SKLabelNode!
	
	var score = 0 {
		didSet {
			scoreLabel.text = "Score: \(score)"
		}
	}
	
	var isGameOver = false
	var level = 1
	
    override func didMove(to view: SKView) {
		
		loadLevel("level\(level)")
		
		physicsWorld.gravity = .zero
		
		motionManager = CMMotionManager()
		motionManager.startAccelerometerUpdates()
		
		physicsWorld.contactDelegate = self
    }
	
	func loadLevel(_ level: String) {
		guard let levelURL = Bundle.main.url(forResource: level, withExtension: "txt") else {
			fatalError("Could not find level1.txt in the app bundle.")
		}
		guard let levelString = try? String(contentsOf: levelURL) else {
			fatalError("Could not load level1.txt from the app bundle.")
		}
		
		loadBackground()
		createPlayer()
		loadScore()
		
		let lines = levelString.components(separatedBy: "\n")
		
		for (row, line) in lines.reversed().enumerated() {
			for (column, letter) in line.enumerated() {
				let position = CGPoint(x: (64 * column) + 32, y: (64 * row) + 32)
				
				if letter == "x" {
					letterX(position)
				} else if letter == "v"  {
					letterV(position)
				} else if letter == "s"  {
					letterS(position)
				} else if letter == "f"  {
					letterF(position)
				} else if letter == " " {
					// this is an empty space – do nothing!
				} else {
					fatalError("Unknown level letter: \(letter)")
				}
			}
		}
	}
	
	func loadBackground() {
		let background = SKSpriteNode(imageNamed: "background.jpg")
		background.position = CGPoint(x: 512, y: 384)
		background.blendMode = .replace
		background.zPosition = -1
		addChild(background)
	}
	
	func loadScore() {
		scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
		scoreLabel.text = "Score: 0"
		scoreLabel.horizontalAlignmentMode = .left
		scoreLabel.position = CGPoint(x: 16, y: 16)
		scoreLabel.zPosition = 2
		addChild(scoreLabel)
	}
	
	func letterX(_ position: CGPoint) {
		let node = SKSpriteNode(imageNamed: "block")
		node.position = position
		
		node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
		node.physicsBody?.categoryBitMask = CollisionTypes.wall.rawValue
		node.physicsBody?.isDynamic = false
		addChild(node)
	}
	
	func letterV(_ position: CGPoint) {
		let node = SKSpriteNode(imageNamed: "vortex")
		node.name = "vortex"
		node.position = position
		node.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
		node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
		node.physicsBody?.isDynamic = false
	
		node.physicsBody?.categoryBitMask = CollisionTypes.vortex.rawValue
		node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
		node.physicsBody?.collisionBitMask = 0
		addChild(node)
	}
	
	func letterS(_ position: CGPoint) {
		let node = SKSpriteNode(imageNamed: "star")
		node.name = "star"
		node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
		node.physicsBody?.isDynamic = false
		
		node.physicsBody?.categoryBitMask = CollisionTypes.star.rawValue
		node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
		node.physicsBody?.collisionBitMask = 0
		node.position = position
		addChild(node)
	}
	
	func letterF(_ position: CGPoint) {
		let node = SKSpriteNode(imageNamed: "finish")
		node.name = "finish"
		node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
		node.physicsBody?.isDynamic = false
		
		node.physicsBody?.categoryBitMask = CollisionTypes.finish.rawValue
		node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
		node.physicsBody?.collisionBitMask = 0
		node.position = position
		addChild(node)
	}
	
	func createPlayer() {
		player = SKSpriteNode(imageNamed: "player")
		player.position = CGPoint(x: 96, y: 672)
		player.zPosition = 1
		player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
		player.physicsBody?.allowsRotation = false
		player.physicsBody?.linearDamping = 0.5
		
		player.physicsBody?.categoryBitMask = CollisionTypes.player.rawValue
		player.physicsBody?.contactTestBitMask = CollisionTypes.star.rawValue | CollisionTypes.vortex.rawValue | CollisionTypes.finish.rawValue
		player.physicsBody?.collisionBitMask = CollisionTypes.wall.rawValue
		addChild(player)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		let location = touch.location(in: self)
		lastTouchPosition = location
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		let location = touch.location(in: self)
		lastTouchPosition = location
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		lastTouchPosition = nil
	}
	
	override func update(_ currentTime: TimeInterval) {
		guard isGameOver == false else { return }
		
		#if targetEnvironment(simulator)
		if let currentTouch = lastTouchPosition {
			let diff = CGPoint(x: currentTouch.x - player.position.x, y: currentTouch.y - player.position.y)
			physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
		}
		#else
		if let accelerometerData = motionManager.accelerometerData {
			physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
		}
		#endif
	}
	
	func didBegin(_ contact: SKPhysicsContact) {
		guard let nodeA = contact.bodyA.node else { return }
		guard let nodeB = contact.bodyB.node else { return }
		
		if nodeA == player {
			playerCollided(with: nodeB)
		} else if nodeB == player {
			playerCollided(with: nodeA)
		}
	}
	
	func playerCollided(with node: SKNode) {
		if node.name == "vortex" {
			player.physicsBody?.isDynamic = false
			isGameOver = true
			score -= 1
			
			let move = SKAction.move(to: node.position, duration: 0.25)
			let scale = SKAction.scale(to: 0.0001, duration: 0.25)
			let remove = SKAction.removeFromParent()
			let sequence = SKAction.sequence([move, scale, remove])
			
			player.run(sequence) { [weak self] in
				self?.createPlayer()
				self?.isGameOver = false
			}
		} else if node.name == "star" {
			node.removeFromParent()
			score += 1
		} else if node.name == "finish" {
			let ac = UIAlertController(title: "WIN!", message: "You have won", preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: newLevel))
			
			let vc = self.view?.window?.rootViewController
			if vc?.presentedViewController == nil {
				vc?.present(ac, animated: true, completion: nil)
			}
			
		}
	}
	
	func newLevel(action: UIAlertAction) {
		self.removeAllChildren()
		level += 1
		loadLevel("level\(level)")
	}
}
