//
//  BorderEmitter.swift
//  space game
//
//  Created by Adrien Pringle on 1/10/2016.
//  Copyright (c) 2016 Adrien Pringle. All rights reserved.
//

import SpriteKit

class BorderEmitter: SKNode {
    let emitter = SKEmitterNode(fileNamed: "BorderEffect")
    let keys = controls()
    
    override init(){
        super.init()
		self.addChild(emitter)
		emitter.particleTexture = SKTexture(imageNamed: "spark")        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
