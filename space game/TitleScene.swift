
import SpriteKit

class TitleScene: SKScene {
	var keyPresses: [Bool] = []
	let keys = controls()
	let title = SKSpriteNode(imageNamed: "Ttitle")
	let border = [SKEmitterNode(fileNamed: "BorderEffect"),SKEmitterNode(fileNamed: "BorderEffect2")]
	let titleEffect = SKEmitterNode(fileNamed: "TitleEffect")
	var location = CGPoint()
	
	let endless = TitleSceneText(imageNamed: "Tendless")
	let bestFive = TitleSceneText(imageNamed: "Tfirstfive")
	let bestTwenty = TitleSceneText(imageNamed: "Tfirsttwenty")
	let control = TitleSceneText(imageNamed: "Tcontrols")
	let credits = TitleSceneText(imageNamed: "Tcredits")
	let quit = TitleSceneText(imageNamed: "Tquit")
	override func didMoveToView(view: SKView) {
		/* Setup your scene here */
		for i in 0...126{
			keyPresses.append(false)
		}
		
		self.backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 1)
		
		self.addChild(title)
		title.yScale /= 5
		title.xScale /= 5
		title.position.x = self.size.width/2
		title.position.y = self.size.height - title.size.height
		
		addMenu(endless, position: 275, cscale: 3)
		addMenu(bestFive, position: 340, cscale: 3)
		addMenu(bestTwenty, position: 405, cscale: 3)
		addMenu(control, position: 470, cscale: 3)
		addMenu(credits, position: 535, cscale: 3)
		addMenu(quit, position: 660, cscale: 6)
		
		self.addChild(titleEffect)
		titleEffect.position = title.position
		titleEffect.particleTexture = SKTexture(imageNamed: "spark")
		titleEffect.zPosition = -10
		addBorder()
	}
	
	override func keyDown(theEvent: NSEvent) {
		keyPresses[theEvent.keyCode.hashValue] = true
		
	}
	override func keyUp(theEvent: NSEvent) {
		keyPresses[theEvent.keyCode.hashValue] = false
	}
	
	override func mouseDown(theEvent: NSEvent) {
		/*if endless.collision(endless, mousePosition: location) {
			let nextScene = GameScene(size: scene!.size)
			nextScene.scaleMode = .AspectFill
			scene?.view?.presentScene(nextScene)
		}*/
		newGameTest(endless, maximumWins: nil)
		newGameTest(bestFive, maximumWins: 5)
		newGameTest(bestTwenty, maximumWins: 20)
		newSceneTest(control, newScene: ControlsScene(size: scene!.size))
		newSceneTest(credits, newScene: CreditsScene(size: scene!.size))
		if quit.collision(quit, mousePosition: location) {
			NSApplication.sharedApplication().terminate(self)
		}
		
	}
	func newSceneTest(text: TitleSceneText, newScene: SKScene){
		if text.collision(text, mousePosition: location) {
			newScene.scaleMode = .AspectFill
			scene?.view?.presentScene(newScene)
		}
	}
	func newGameTest(text:TitleSceneText, maximumWins: Int?){
		if text.collision(text, mousePosition: location) {
			let newScene = GameScene(size: scene!.size)
			newScene.scaleMode = .AspectFill
			newScene.keys.maximumWins = maximumWins
			scene?.view?.presentScene(newScene)
		}
	}
	
	override func update(currentTime: NSTimeInterval) {
		endless.grow(endless.collision(endless, mousePosition: location))
		bestFive.grow(bestFive.collision(bestFive, mousePosition: location))
		bestTwenty.grow(bestTwenty.collision(bestTwenty, mousePosition: location))
		control.grow(control.collision(control, mousePosition: location))
		credits.grow(credits.collision(credits, mousePosition: location))
		quit.grow(quit.collision(quit, mousePosition: location))
	}
	
	override func mouseMoved(event: NSEvent) {
		location = event.locationInNode(self)
	}
	
	func addMenu(node: TitleSceneText, position: CGFloat, cscale: CGFloat){
		self.addChild(node)
		node.csize = 1/cscale
		node.position.x = self.size.width/2
		node.position.y = self.size.height - position
	}
	func addBorder(){
		keys.bEPositions = keys.bStartPositions
		for i in 0...border.count-1 {
			self.addChild(border[i])
			border[i].particleTexture  = SKTexture(imageNamed: "spark")
			border[i].position.x = keys.bStartPositions[i] + (keys.bEPositions[i].distanceTo(512)/512 * 250) //i'm not sure why this gives the right position but it works
			border[i].position.y = self.size.height/2
			border[i].zPosition = 100
		}
	}
}
