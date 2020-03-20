//
//  BorderWalls.swift
//  space game
//
//  Created by Adrien Pringle on 29/9/2016.
//  Copyright (c) 2016 Adrien Pringle. All rights reserved.
//
import SpriteKit

class Bullet: SKNode {
	var direction = CGFloat()
	let right = SKEmitterNode(fileNamed: "Bullet")
	let left = SKEmitterNode(fileNamed: "Bullet2")
	init(rotation: CGFloat){
		super.init()
		direction = rotation
		right.particleTexture = SKTexture(imageNamed: "spark")
		left.particleTexture = SKTexture(imageNamed: "spark")
		self.addChild(right)
		self.addChild(left)
		self.xScale /= 2.5
		self.yScale /= 2.5
	}
	func move(){
		self.position.x += cos(direction * 0.0174533) * 15
		self.position.y += sin(direction * 0.0174533) * 15
		if cos(direction * 0.0174533)<0{
			right.alpha = 0
			left.alpha = 1
		}else{
			right.alpha = 1
			left.alpha = 0
		}
		self.runAction(SKAction.rotateToAngle(direction*0.0174533, duration: 0))
	}
	func collision(bottomLeft: CGPoint, topRight: CGPoint) -> Bool{
		var x = CGFloat()
		var y = CGFloat()
		let width = CGFloat(20)
		if self.position.x < topRight.x - width{
			if self.position.y < topRight.y{
				if self.position.x > bottomLeft.x + width{
					if self.position.y > bottomLeft.y{
						return true
					}
				}
			}
		}
		return false
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

