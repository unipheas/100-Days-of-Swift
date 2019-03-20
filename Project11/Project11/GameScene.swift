//
//  GameScene.swift
//  Project11
//
//  Created by Brian Phillips on 3/19/19.
//  Copyright © 2019 Titanian Inc. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
	

	var scoreLabel: SKLabelNode!
	var resetLabel: SKLabelNode!
	var ballsLabel: SKLabelNode!
	
	let balls = ["ballBlue", "ballCyan", "ballGreen", "ballGrey", "ballPurple", "ballRed", "ballYellow"]
	var droppedBallCount = 5
	var boxes = [SKSpriteNode]()
	
	var score = 0 {
		didSet {
			scoreLabel.text = "Score: \(score)"
		}
	}
	
	private var label : SKLabelNode?
	private var spinnyNode : SKShapeNode?
	
	override func didMove(to view: SKView) {
		let background = SKSpriteNode(imageNamed: "background.jpg")
		background.position = CGPoint(x: 512, y: 384)
		background.blendMode = .replace
		background.zPosition = -1
		addChild(background)
		
		scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
		scoreLabel.text = "Score: 0"
		scoreLabel.horizontalAlignmentMode = .right
		scoreLabel.position = CGPoint(x: 980, y: 700)
		addChild(scoreLabel)
		
		resetLabel = SKLabelNode(fontNamed: "Chalkduster")
		resetLabel.text = "Reset"
		resetLabel.position = CGPoint(x: 80, y: 700)
		addChild(resetLabel)
		
		ballsLabel = SKLabelNode(fontNamed: "Chalkduster")
		ballsLabel.text = "Balls: 5"
		ballsLabel.position = CGPoint(x: 500, y: 700)
		addChild(ballsLabel)
		
		physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
		physicsWorld.contactDelegate = self
		
		makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
		makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
		makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
		makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
		
		makeBouncer(at: CGPoint(x: 0, y: 0))
		makeBouncer(at: CGPoint(x: 256, y: 0))
		makeBouncer(at: CGPoint(x: 512, y: 0))
		makeBouncer(at: CGPoint(x: 768, y: 0))
		makeBouncer(at: CGPoint(x: 1024, y: 0))
		
		
		buildLevel()
	}
	
	func buildLevel() {
		if score >= 0 {
			for _ in 0...score {
				generateBox()
			}
		} else {
			generateBox()
		}

	}
	
	func generateBox() {
		let size = CGSize(width: Int.random(in: 16...128), height: 16)
		let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
		box.zRotation = CGFloat.random(in: 0...3)
		box.position = CGPoint(x: CGFloat.random(in: 50...1024), y: CGFloat.random(in: 50...700))
		box.name = "box"
		box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
		box.physicsBody?.isDynamic = false
		addChild(box)
		boxes.append(box)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			let location = touch.location(in: self)
			let object = nodes(at: location)
			if object.contains(resetLabel) {
				score = 0
				resetLevel()
			} else {
				let ball = SKSpriteNode(imageNamed: balls.randomElement()!)
				ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
				ball.physicsBody?.restitution = 0.4
				ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
				ball.position = CGPoint(x: location.x, y: 764.0)
				ball.name = "ball"
				addChild(ball)
				droppedBallCount -= 1
				checkBallDropped()
			}
		}
	}
	
	func makeBouncer(at position: CGPoint) {
		let bouncer = SKSpriteNode(imageNamed: "bouncer")
		bouncer.position = position
		bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
		bouncer.physicsBody?.isDynamic = false
		addChild(bouncer)
	}
	
	func makeSlot(at position: CGPoint, isGood: Bool) {
		var slotBase: SKSpriteNode
		var slotGlow: SKSpriteNode
		
		if isGood {
			slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
			slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
			slotBase.name = "good"
		} else {
			slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
			slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
			slotBase.name = "bad"
		}
		
		slotBase.position = position
		slotGlow.position = position
		
		slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
		slotBase.physicsBody?.isDynamic = false
		
		addChild(slotBase)
		addChild(slotGlow)
		
		let spin = SKAction.rotate(byAngle: .pi, duration: 10)
		let spinForever = SKAction.repeatForever(spin)
		slotGlow.run(spinForever)
	}
	
	func collisionBetween(ball: SKNode, object: SKNode) {
		if object.name == "good" {
			destroy(ball: ball)
			score += 1
		} else if object.name == "bad" {
			destroy(ball: ball)
			if score > 0 {
				score -= 1
			}
		}
	}
	
	func destroy(ball: SKNode) {
		if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
			fireParticles.position = ball.position
			addChild(fireParticles)
		}
		
		ball.removeFromParent()
	}
	
	func didBegin(_ contact: SKPhysicsContact) {
		guard let nodeA = contact.bodyA.node else { return }
		guard let nodeB = contact.bodyB.node else { return }
		
		if nodeA.name == "ball" {
			collisionBetween(ball: nodeA, object: nodeB)
		} else if nodeB.name == "ball" {
			collisionBetween(ball: nodeB, object: nodeA)
		}
	}
	
	func checkBallDropped() {
		ballsLabel.text = "Balls: \(droppedBallCount)"
		if droppedBallCount <= 0 {
			resetLevel()
		}
	}
	
	func resetLevel() {
		droppedBallCount = 5
		ballsLabel.text = "Balls: \(droppedBallCount)"
		for box in boxes {
			box.removeFromParent()
		}
		buildLevel()
	}
}
