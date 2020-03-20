//
//  BorderWalls.swift
//  space game
//
//  Created by Adrien Pringle on 29/9/2016.
//  Copyright (c) 2016 Adrien Pringle. All rights reserved.
//
import SpriteKit

class BorderWalls: SKSpriteNode {
    let borderWall = SKEmitterNode(fileNamed: "BorderEffect")
      override init(texture: SKTexture!, color: SKColor!, size: CGSize){
        var image = SKTexture(imageNamed: "bullet")
        super.init(texture: image, color: nil, size: image.size())
        self.runAction(SKAction.rotateToAngle(1.5708, duration: 0))
        self.size.height *= 3
        self.size.width *= 3
        
        self.addChild(borderWall)
        borderWall.runAction(SKAction.rotateToAngle(-1.5708, duration: 0))
        borderWall.particleTexture = SKTexture(imageNamed: "spark")
       //borderWall.xScale /= 2
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

