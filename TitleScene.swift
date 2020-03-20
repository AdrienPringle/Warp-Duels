
import SpriteKit

class TitleScene: SKScene {
	let keys = controls()
	let titleImage = SKSpriteNode(imageNamed: "title")
	var keyPresses: [Bool] = []
	
	override func didMoveToView(view: SKView) {
		self.backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 1)
		for i in 0...126{ // this creates a true/false value for all keys
			keyPresses.append(false)
		}
		titleImage.xScale /= 3
		titleImage.yScale /= 3
		self.addChild(titleImage)
	}
	
	override func mouseDown(theEvent: NSEvent) {
		var location = theEvent.locationInWindow
		println(location)
		
		let transition = SKTransition.revealWithDirection(.Down, duration: 0)
		
		let nextScene = GameScene(size: scene!.size)
		nextScene.scaleMode = .AspectFill
		
		scene?.view?.presentScene(nextScene, transition: transition)
	}
	override func keyDown(theEvent: NSEvent) {
		keyPresses[theEvent.keyCode.hashValue] = true
	}
	override func keyUp(theEvent: NSEvent) {
		keyPresses[theEvent.keyCode.hashValue] = false
	}
}
