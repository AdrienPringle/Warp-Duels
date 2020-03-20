
import SpriteKit

class GameScene: SKScene {
    let ship = [spaceship(imageNamed: "shipR"),spaceship(imageNamed: "shipL")]
    let trail = [SKEmitterNode(fileNamed: "Trail"), SKEmitterNode(fileNamed: "Trail")]
    let keys = controls()
    let border = [SKEmitterNode(fileNamed: "BorderEffect"),SKEmitterNode(fileNamed: "BorderEffect2")]
    var firstTime = CGFloat?()
    var gameTime = CGFloat?()
	var prevGameTime = CGFloat?()
    var keyPresses: [Bool] = []
	var bullets = [Bullet(rotation: 0)]
    let borderEffect = SKEmitterNode(fileNamed: "BorderEffect")
	var fps = CGFloat()
	var winningPlayer = Int()
	let stars = SKEmitterNode(fileNamed: "Stars")
	let bar = [SKSpriteNode(imageNamed: "barL"), SKSpriteNode(imageNamed: "barR")]
	let barEnd = [SKSpriteNode(imageNamed: "barLE"), SKSpriteNode(imageNamed: "barRE")]
	let score = [SKLabelNode(fontNamed: "Arial Rounded MT Bold"), SKLabelNode(fontNamed: "Arial Rounded MT Bold")]
	let string = "doggo"
	let keyRestart = [SKSpriteNode(imageNamed: "w"), SKSpriteNode(imageNamed: "up")]
	let keyRestartTrail = [SKEmitterNode(fileNamed: "Trail"), SKEmitterNode(fileNamed: "Trail")]
	let exit = TitleSceneText(imageNamed: "Texit")
	var location = CGPoint()
	let winnerLabel = SKSpriteNode(imageNamed: "EblueWins")
	let ai = AIOpponent()
	
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
		for i in 0...126{ // this creates a true/false value for all keys
			keyPresses.append(false)
		}
		self.backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 1)
		gameInit()
		exit.csize = 1/3
		exit.position.x = self.size.width/2
		exit.position.y = self.size.height - 600
		
		
    }
    override func keyDown(theEvent: NSEvent) {
        keyPresses[theEvent.keyCode.hashValue] = true
		//print(theEvent.charactersIgnoringModifiers)
        //allows for multiple button presses to be detected at once
		if keyPresses[keys.esc]{
			let nextScene = TitleScene(size: scene!.size)
			nextScene.scaleMode = .AspectFill
			scene?.view?.presentScene(nextScene)
		}
		
    }
    override func keyUp(theEvent: NSEvent) {
        keyPresses[theEvent.keyCode.hashValue] = false
		for i in 0...ship.count - 1{
			if keyPresses[keys.bShoot[i]] == false{
				keys.bShootToggle[i] = false
			}
		}
        //allows for multiple button presses to be detected at once
    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        calculateTime(currentTime)
		control()
		if keys.restart == false {
			if gameTime > 10 {
				calculateBorderPositions()
				//move the boundaries in after 10 seconds
			}
			calculateDirections()
			calculateTextures()
			
			if prevGameTime != nil {
				fps = 1/(gameTime! - prevGameTime!)
				// NEVER take this out of this if statement
			}
			calculateBullets()
		} else {
			calculateEndGame()
		}
		calculateStats()
		
		
    }
	func control(){ //insert ai here
		for i in 0...ship.count-1 {
			keys.moveUp[i] = shipControl(keyPresses[keys.bUp[i]])
			keys.moveDown[i] = shipControl(keyPresses[keys.bDown[i]])
			keys.moveLeft[i] = shipControl(keyPresses[keys.bLeft[i]])
			keys.moveRight[i] = shipControl(keyPresses[keys.bRight[i]])
			keys.shoot[i] = shipControl(keyPresses[keys.bShoot[i]])
			keys.deflect[i] = shipControl(keyPresses[keys.bShield[i]])
		}
	}
	func shipControl(key: Bool) -> Bool{
		if key{return true}else{return false}
	}
    func calculateTime(currentTime: CFTimeInterval){
        if firstTime == nil {
            firstTime = CGFloat(currentTime)
            //detects the time when the program started running
		} else{
			prevGameTime = gameTime
		}
		
        gameTime = CGFloat(currentTime) - firstTime!
    }
    func calculateDirections(){
		//calculateBorderPositions()
        for i in 0...ship.count-1{
            var x = 0
            if keys.moveRight[i]{
                x += 1
            }
            if keys.moveLeft[i]{
                x -= 1
            }
            var y = 0
            if keys.moveUp[i]{
                y += 1
            }
            if keys.moveDown[i]{
                y -= 1
            }
            ship[i].move(x, yVel: y, speed: 6)
            trail[i].particleAlpha = CGFloat(Double(y)/100+0.015)//changing the alpha based on the yspeed
			trail[i].particleRotation = ship[i].rotation * 0.0174533//converting radians to degrees
        }
		ship[0].collision(CGPoint(x: 0, y: 0), topRight: CGPoint(x: border[0].position.x - 10, y: 768))
		ship[1].collision(CGPoint(x: border[1].position.x + 10, y: 0), topRight: CGPoint(x: 1024, y: 768))
		// setting the collision boundaries for the ships

    }
	func calculateBorderPositions(){
		let borderSpeed = CGFloat(1)
		for i in 0...border.count-1{
			if keys.bEPositions[1].distanceTo(keys.bEPositions[0]) > -1670 {
				keys.bEPositions[i] += borderSpeed*2*(CGFloat(i)-0.5)
			}
			border[i].position.x = keys.bStartPositions[i] + (keys.bEPositions[i].distanceTo(512)/512 * 250)
		}
	}
    func shipInit(){
        for i in 0...ship.count-1 {
            self.addChild(ship[i])
            self.addChild(trail[i])
            ship[i].position.x = keys.bStartPositions[i]
            ship[i].position.y = self.size.height/2
            trail[i].xScale = ship[i].xScale
            trail[i].yScale = ship[i].yScale
			keys.brestartToggle[i] = false
			
        }
	}
    func borderInit(){
		keys.bEPositions = keys.bStartPositions
		for i in 0...border.count-1 {
			self.addChild(border[i])
			border[i].particleTexture  = SKTexture(imageNamed: "spark")
			border[i].position.x = keys.bStartPositions[i] + (keys.bEPositions[i].distanceTo(512)/512 * 250) //i'm not sure why this gives the right position but it works
			border[i].position.y = self.size.height/2
			border[i].zPosition = 100
		}
    }
	func starsInit(){
		self.addChild(stars)
		stars.position.y = self.size.height
		stars.particleTexture = SKTexture(imageNamed: "spark")
		stars.position.x = self.size.width/2
		stars.zPosition = -100
	}
	func barInit(){
		for i in 0...bar.count - 1{
			addChild(bar[i])
			addChild(barEnd[i])
			bar[i].position.y = self.size.height - 2.1 * bar[i].size.height
			barEnd[i].position.y = bar[i].position.y
			barEnd[i].position.x = CGFloat(i) * (self.size.width - barEnd[i].size.width) + barEnd[i].size.width/2
			bar[i].zPosition = -100
			barEnd[i].zPosition = -99
			if i == 1 {
				bar[1].xScale = -1
			}
		}
	}
	func calculateTextures(){
		for i in 0...ship.count-1 {
			if keys.bDeflectToggle[i]{
				ship[i].texture = SKTexture(imageNamed: keys.bDeflectTextures[i])
			} else {
				ship[i].texture = SKTexture(imageNamed: keys.bTextures[i])
			}
			trail[i].particleTexture = ship[i].texture//the texutres are kind of messed up and I dont know why
			trail[i].particlePosition = CGPoint(x: ship[i].position.x * 1/ship[i].xScale, y: ship[i].position.y * 1/ship[i].yScale)
			//syncing up the movements of the spaceships and their trails
		}
	}
	func calculateBullets(){
		checkNewBullets()
		removeHitBullets()
	}
	func gameInit(){
		firstTime = nil
		self.removeAllChildren()
		shipInit()
		borderInit()
		starsInit()
		barInit()
		keyRestartInit()
		keys.bPowerLevels = [9001, 9001]
		if bullets.count == 1{
			bullets.removeAtIndex(0)
		}
		for i in 0...score.count - 1{
			score[i].position.y = self.size.height - 155
			score[i].zPosition = -100
			self.addChild(score[i])
		}
		winnerLabel.position.y = self.size.height/2
		winnerLabel.position.x = self.size.width/2
		winnerLabel.xScale = 0.3
		winnerLabel.yScale  = 0.3
	}
	func checkBulletCollision(i: Int) -> Bool{
		if bullets[i].direction%360 < -90 {
			let bL = CGPoint(x: ship[0].position.x - ship[0].size.width/2, y: ship[0].position.y - ship[0].size.height/2)
			let tR = CGPoint(x: ship[0].position.x + ship[0].size.width/2, y: ship[0].position.y + ship[0].size.height/2)
			if bullets[i].collision(bL, topRight: tR){
				if keys.bDeflectToggle[0]{
					bullets[i].direction = -1*(bullets[i].direction - 180)
					bullets[i].move()
					return false
				}
				winningPlayer = 1
				keys.restart = true
				return true
			}
		}else{
			let bL = CGPoint(x: ship[1].position.x - ship[1].size.width/2, y: ship[1].position.y - ship[1].size.height/2)
			let tR = CGPoint(x: ship[1].position.x + ship[1].size.width/2, y: ship[1].position.y + ship[1].size.height/2)
			if bullets[i].collision(bL, topRight: tR){
				if keys.bDeflectToggle[1]{
					bullets[i].direction = -1*(bullets[i].direction + 180)
					bullets[i].move()
					return false
				}
				winningPlayer = 0
				keys.restart = true
				return true
			}
		}
		return false
	}
	func removeHitBullets(){
		if bullets.count > 0{ // because it has an error if it is 0
			var removedBullets: [Int] = []
			for i in 0...bullets.count - 1{
				bullets[i].move()
				// move bullets
				if bullets[i].position.x < 0 || bullets[i].position.x > self.size.width{
					removedBullets.append(i)
					bullets[i].removeFromParent()
					//check for and remove bullets that are off screen
				}
				if checkBulletCollision(i){
					removedBullets.append(i)
					keys.bScores[winningPlayer] += 1
					bullets[i].removeFromParent()
				}
			}
			if removedBullets.count > 0{
				for i in 0...removedBullets.count - 1{
					bullets.removeAtIndex(removedBullets[i]-i)
					// get rid of the array value of the bullet to make space for more
				}
			}
		}
	}
	func checkNewBullets(){
		for i in 0...ship.count-1 {
			if keys.shoot[i] && keys.bShootToggle[i] == false{
				if keys.bPowerLevels[i]>0{
					addBullet(i)
				}
				keys.bShootToggle[i] = true
				//add a bullet once per keydown
			}
			if keys.deflect[i] == true{
				deflect(i)
			} else {
				keys.bDeflectToggle[i] = false
			}
			if keys.bPowerLevels[i] < 9001{
				keys.bPowerLevels[i] += 100
			}
			
		}
	}
	func deflect (i: Int){
		if keys.bPowerLevels[i]>0 {
			keys.bPowerLevels[i] -= 250
		}
		if keys.bPowerLevels[i]>250{
			keys.bDeflectToggle[i] = true
		} else {
			keys.bDeflectToggle[i] = false
		}
	}
	func addBullet(i: Int){
		if i == 0 {
			bullets.append(Bullet(rotation: ship[i].rotation))
		} else {
			bullets.append(Bullet(rotation: -(180 - ship[i].rotation)))
		}
		// adds a new bullet with the angles of either ship
		self.addChild(bullets[bullets.count-1])
		bullets[bullets.count-1].position = ship[i].position
		bullets[bullets.count-1].position.y -= 8
		// puts the bullet in the ideal position to start at
			keys.bPowerLevels[i] -= 3000
		
	}
	func calculateEndGame(){
		self.removeChildrenInArray(bullets)
		self.removeChildrenInArray(ship)
		self.removeChildrenInArray(trail)
		self.addChild(ship[winningPlayer])
		self.addChild(trail[winningPlayer])
		for i in 0...ship.count - 1{
			if keys.hasEnded == false{
				self.addChild(keyRestart[i])
				//keys.bHasEnded[i] = true
			}
			if keyPresses[keys.bUp[i]] == true{
				if keys.bHasRestarted[i] == false{
					self.addChild(keyRestartTrail[i])
					keys.bHasRestarted[i] = true
				}
				
				keys.brestartToggle[i] = true
			}
		}
		
		if keys.bScores[0] == keys.maximumWins || keys.bScores[1] == keys.maximumWins {
			if keys.hasEnded == false {
				self.addChild(exit)
				self.addChild(winnerLabel)
				if keys.bScores[0]<keys.bScores[1] {
					//winnerLabel.
				} else {
					winnerLabel.texture = SKTexture(imageNamed: "EredWins")
				}
			}
			exit.grow(exit.collision(exit, mousePosition: location))
			if (exit.collision(exit, mousePosition: location) && keys.mouseDown)||(keys.brestartToggle[0] && keys.brestartToggle[1]) {
				let nextScene = TitleScene(size: scene!.size)
				nextScene.scaleMode = .AspectFill
				scene?.view?.presentScene(nextScene)
			}
			keys.hasEnded = true
		}else {
			keys.hasEnded = true
			if keys.brestartToggle[0] && keys.brestartToggle[1]{
				keys.restart = false
				if bullets.count > 1{
					for i in 0...bullets.count - 1{
						bullets.removeLast()
					}
				}
				gameInit()
			}
		}
		
	}
	func calculateStats(){
		for i in 0...bar.count - 1{
			if i == 1 {
				if keys.bPowerLevels[i] < 0 {
					bar[i].position.x = 1115
				} else {
					bar[i].position.x = CGFloat(keys.bPowerLevels[i] / -40) + 1115
				}
			} else{
				if keys.bPowerLevels[i] < 0 {
					bar[i].position.x = -91
				} else {
					bar[i].position.x = CGFloat(keys.bPowerLevels[i] / 40) - 91
				}
				
			}
			score[i].text = String(keys.bScores[i])
			score[i].position.x = CGFloat(i) * (self.size.width - CGFloat(count(score[i].text.utf16))*18) + CGFloat(count(score[i].text.utf16))*9 - (CGFloat(i)-0.5)*25
		}
	}
	func keyRestartInit(){
		for i in 0...keyRestart.count - 1{
			keys.bHasRestarted[i] = false
			keys.bHasEnded[i] = false
			keyRestart[i].position = ship[i].position
			keyRestart[i].xScale = 0.5
			keyRestart[i].yScale = 0.5
			keyRestart[i].zPosition = 100
			keyRestartTrail[i].position = keyRestart[i].position
			keyRestartTrail[i].particleTexture = keyRestart[i].texture
			keyRestartTrail[i].particleAlpha = 0.015
			keyRestartTrail[i].xScale = 0.5
			keyRestartTrail[i].yScale = 0.5
			keyRestartTrail[i].zPosition = 8
		}
		keys.hasEnded = false
	}
	override func mouseDown(theEvent: NSEvent) {
		keys.mouseDown = true
	}
	override func mouseUp(theEvent: NSEvent) {
		keys.mouseDown = false
	}
	override func mouseMoved(theEvent: NSEvent) {
		location = theEvent.locationInNode(self)
	}
}
