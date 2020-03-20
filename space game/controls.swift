//
//  Controls.swift
//  space game
//
//  Created by Adrien Pringle on 27/9/2016.
//  Copyright (c) 2016 Adrien Pringle. All rights reserved.
//

import SpriteKit
class controls{
    // left default controls
    let lUp = 13 //w
    let lDown = 1//s
    let lLeft = 0//a
    let lRight = 2//d
    let lShoot = 49//space
    let lShield = 8//c
    // right defaullt controls
    let rUp = 126 //up
    let rDown = 125//down
    let rLeft = 123//left
    let rRight = 124//right
    let rShoot = 45//n
    let rShield = 46//m
    //test default controls in arrays
    let bUp = [13, 126]
    let bDown = [1, 125]
    let bLeft = [0, 123]
    let bRight = [2, 124]
    let bShoot = [49, 45]
	let bShield = [8, 46]
	
	var bShootToggle = [false, false]
	var bDeflectToggle = [false, false]
	var bPowerLevels = [9001, 9001]
	var bScores = [0, 0]
	
	var restart = false
	var brestartToggle = [false,false]
	var bHasRestarted = [false, false]
	var bHasEnded = [false, false]
	
	var hasEnded = false
	
	var maximumWins = Int?()
	
	var mouseDown = false
	
	let bTextures = ["shipL", "shipR"]
	let bDeflectTextures = ["shipLD", "shipRD"]
    
    let bStartPositions = [CGFloat(100),CGFloat(924)]//1024 = width of gamescene
	var bEPositions = [CGFloat(100), CGFloat(924)]// meant to change border positions over time
    
    let esc = 53//esc
    let tab = 48//tab
    let enter = 36//enter
    let up = 126//up
    let down = 125//down
    let left = 123//left
    let right = 124//right
	
	var moveUp = [false, false]
	var moveDown = [false, false]
	var moveLeft = [false, false]
	var moveRight = [false, false]
	var shoot = [false, false]
	var deflect = [false, false]//used to control the ships regardless of the keys pressed
}
