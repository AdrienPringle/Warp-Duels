//
//  spaceship.swift
//  space game
//
//  Created by Adrien Pringle on 27/9/2016.
//  Copyright (c) 2016 Adrien Pringle. All rights reserved.
//

import SpriteKit

class spaceship: SKSpriteNode {
	var rotation = CGFloat(0) // 0 is the default angle
    override init(texture: SKTexture!, color: SKColor!, size: CGSize){
        //var image = SKTexture(imageNamed: "ship")
        
        super.init(texture: texture, color: nil, size: texture.size())
        self.xScale /= 3
        self.yScale /= 3
    }
    
    func move(xVel: Int, yVel: Int, speed: CGFloat){
        if abs(yVel) == abs(xVel) {
            self.position.y += CGFloat(yVel) * 0.707 * speed
            self.position.x += CGFloat(xVel) * 0.707 * speed
        }else{
            self.position.y += CGFloat(yVel) * speed
            self.position.x += CGFloat(xVel) * speed
            
        }
		rotation -= CGFloat(xVel) * speed/1.4
		rotation *= 0.8
        rotate(rotation)
        //self.runAction(SKAction.rotateToAngle(0, duration: 0.1))
    }
    func rotate(degrees: CGFloat){
        self.runAction(SKAction.rotateToAngle(0.0174533*degrees, duration: 0))
    }
	func collision(bottomLeft: CGPoint, topRight: CGPoint) -> CGPoint{
		var x = CGFloat()
		var y = CGFloat()
		if self.position.x > topRight.x - self.size.width/2{
			self.position.x = topRight.x - self.size.width/2
			x = 1
		}
		if self.position.y > topRight.y - self.size.height - 20{
			self.position.y = topRight.y - self.size.height - 20
			y = 1
		}
		if self.position.x < bottomLeft.x + self.size.width/2{
			self.position.x = bottomLeft.x + self.size.width/2
			x = -1
		}
		if self.position.y < bottomLeft.y + self.size.height + 20{
			self.position.y = bottomLeft.y + self.size.height + 20
			y = -1
		}
		return CGPoint(x: x, y: y)
	}


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
