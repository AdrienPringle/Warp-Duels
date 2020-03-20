//
//  spaceship.swift
//  space game
//
//  Created by Adrien Pringle on 27/9/2016.
//  Copyright (c) 2016 Adrien Pringle. All rights reserved.
//

import SpriteKit

class TitleSceneText: SKSpriteNode {
	var csize = CGFloat()
	
	override init(texture: SKTexture!, color: SKColor!, size: CGSize){
		//var image = SKTexture(imageNamed: "ship")
		super.init(texture: texture, color: nil, size: texture.size())
		
	}
	func collision(node: SKSpriteNode, mousePosition: CGPoint) -> Bool{
		let left = node.position.x - node.size.width/2
		let right = node.position.x + node.size.width/2
		let down = node.position.y - node.size.height/2
		let up = node.position.y + node.size.height/2
		let x = mousePosition.x
		let y = mousePosition.y
		
		if x > left && x < right {
			if y < up && y > down {
				return true
			}
		}
		return false
	}
	func grow(collide: Bool){
		if collide {
			self.xScale += (1.5*csize - self.xScale)/4
			self.yScale += (1.5*csize - self.yScale)/4
		}else{
			self.xScale += (1*csize - self.xScale)/2
			self.yScale += (1*csize - self.yScale)/2
		}
	}
	
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
