//
//  Scene6.swift
//  PlaygroundBook
//
//  Created by Djenifer Renata Pereira on 12/04/21.
//

import Foundation
import SpriteKit

public class Scene6: PreScene {
    
    override public func didMove(to view: SKView) {
        self.backgroundColor = .white
        setupTimer()
        setup()
    }
    
    @objc static override public var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
    func setup() {
        let background = SKNode()
        background.position = CGPoint(x: -150, y: 100)
        
        let falls = self.setupRiverBackground()
        falls.zRotation = toRadians(-5)
        falls.position = CGPoint(x: 0, y: 300)
        
        let fallsLines = self.setupFallsLines(hideMiddleLine: true)
        fallsLines.position = CGPoint(x: 2100, y: -1000)
        
        falls.addChild(fallsLines)
        background.addChild(falls)
        
        let rock = setupRock()
        rock.position = CGPoint(x: 1150, y: 50)
        
        background.addChild(rock)
        
        let earthAndPalm = setupEarthAndPalm()
        earthAndPalm.position = CGPoint(x: -300, y: 50)
        background.addChild(earthAndPalm)
        
        background.run(.sequence([
            .wait(forDuration: 1),
            .move(to: CGPoint(x: 600, y: 100), duration: 1.5),
            .wait(forDuration: 1),
            .group([
                .move(to: CGPoint(x: 400, y: 100), duration: 1.5),
                .scale(to: 0.7, duration: 1.5)
            ])
        ]))
        
        self.addChild(background)
        
        let text = setupText(texts: [
            "The legend tells that Naipi became a rock in the middle of the Falls and Tarobá became a palm.",
            "In this way, they are fated to see each other without being able to be together again."
        ])
        
        self.addChild(text)
    }
    
    func setupRock() -> SKNode {
        let node = SKNode()
        
        let rock = SKSpriteNode(imageNamed: "images/rock")
        rock.zPosition = CHARACTER_ZPOSITION
        
        node.addChild(rock)
        node.setScale(0.5)
        
        return node
    }
    
    func setupEarthAndPalm() -> SKNode {
        let node = SKNode()
        
        let earth = SKSpriteNode(imageNamed: "images/earth-1")
        earth.yScale = earth.yScale * -1
        earth.position = CGPoint(x: -200, y: -400)
        earth.zRotation = toRadians(-7)
        earth.zPosition = CHARACTER_ZPOSITION + 1
        
        let palm = SKSpriteNode(imageNamed: "images/palm")
        palm.zPosition = CHARACTER_ZPOSITION + 2
        palm.position = CGPoint(x: 100, y: 500)
        
        node.addChild(earth)
        node.addChild(palm)
        
        node.setScale(0.5)
        
        return node
    }
}
