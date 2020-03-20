//
//  AppDelegate.swift
//  space game
//
//  Created by Adrien Pringle on 27/9/2016.
//  Copyright (c) 2016 Adrien Pringle. All rights reserved.
//


import Cocoa
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! TitleScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
		}
    }
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var skView: SKView!
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        /* Pick a size for the scene */
        if let scene = TitleScene.unarchiveFromFile("TitleScene") as? TitleScene {
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            self.skView!.presentScene(scene)
            window.acceptsMouseMovedEvents = true
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            self.skView!.ignoresSiblingOrder = true

			self.skView!.showsFPS = true
        }
		
    }
	
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }

}
