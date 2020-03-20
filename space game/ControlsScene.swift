
import SpriteKit

class ControlsScene: SKScene {
	var keyPresses: [Bool] = []
	var location = CGPoint()
	let keys = controls()
	let exit = TitleSceneText(imageNamed: "Texit")
	let text = SKSpriteNode(imageNamed: "ControlsPage")

	override func didMoveToView(view: SKView) {
		/* Setup your scene here */
		for i in 0...126{
			keyPresses.append(false)
		}
		self.backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 1)
		addMenu(exit, position: 660, cscale: 6)
		text.position.x = self.size.width/2
		text.position.y = self.size.height/2 + 50
		text.xScale = 0.35
		text.yScale = 0.35
		self.addChild(text)

	}
	
	override func keyDown(theEvent: NSEvent) {
		keyPresses[theEvent.keyCode.hashValue] = true
		
	}
	override func keyUp(theEvent: NSEvent) {
		keyPresses[theEvent.keyCode.hashValue] = false
	}
	
	override func mouseDown(theEvent: NSEvent) {
		if exit.collision(exit, mousePosition: location) {
			let nextScene = TitleScene(size: scene!.size)
			nextScene.scaleMode = .AspectFill
			scene?.view?.presentScene(nextScene)
		}
	}
	
	override func update(currentTime: NSTimeInterval) {
		exit.grow(exit.collision(exit, mousePosition: location))
		
		if keyPresses[keys.esc]{
			let nextScene = TitleScene(size: scene!.size)
			nextScene.scaleMode = .AspectFill
			scene?.view?.presentScene(nextScene)
		}
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
}
