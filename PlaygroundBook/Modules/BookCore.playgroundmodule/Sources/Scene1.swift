//
//  Scene1.swift
//  PlaygroundBook
//
//  Created by Djenifer Renata Pereira on 10/04/21.
//

import Foundation
import SpriteKit

public class Scene1: PreScene {
    
    override public func didMove(to view: SKView) {
        self.backgroundColor = .white
        // setupTimer()
        setupTake1()
    }
    
    
    @objc static override public var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
    func setupTake1() {
        // No specific time required
        let background = setupBackground()
        background.position = CGPoint(x: 650, y: 250)
        
        let trees = setupTrees()
        trees.position = CGPoint(x: 220, y: 750)
        
        let houses = setupHouses()
        houses.position = CGPoint(x: 500, y: 300)
        
        let indians = setupIndians()
        indians.position = CGPoint(x: 500, y: 300)
        
        let take1 = SKNode()
    
        take1.addChild(background)
        take1.addChild(trees)
        take1.addChild(houses)
        take1.addChild(indians)
        
        self.addChild(take1)

        let text = setupText(text: "A long time ago, Guarani Indians were living on the Iguassu River banks.")
        
        self.addChild(text)
    }
    
    func setupBackground() -> SKNode {
        let background = SKNode()
        
        let river = SKSpriteNode(imageNamed: "cena-1/river")
        river.position = CGPoint(x: 825, y: 0)
        river.zPosition = 1
        background.addChild(river)
        
        let earth = SKSpriteNode(imageNamed: "cena-1/earth")
        earth.position = CGPoint(x: -275, y: 100)
        earth.zPosition = 2
        background.addChild(earth)
        
        background.setScale(0.5)
        return background
    }
    
    func setupTrees() -> SKNode {
        let trees = SKNode()
        
        let t0 = SKSpriteNode(imageNamed: "cena-1/tree-0")
        t0.position = CGPoint(x: -200, y: -88)
        t0.zPosition = 5
        
        let t1 = SKSpriteNode(imageNamed: "cena-1/tree-1")
        t1.position = CGPoint(x: -60, y: 128)
        t1.zPosition = 4
        
        let t2 = SKSpriteNode(imageNamed: "cena-1/tree-2")
        t2.position = CGPoint(x: 84, y: -200)
        t2.zPosition = 6
        
        let t3 = SKSpriteNode(imageNamed: "cena-1/tree-0")
        t3.position = CGPoint(x: 200, y: 20)
        t3.zPosition = 5
        
        trees.addChild(t0)
        trees.addChild(t1)
        trees.addChild(t2)
        trees.addChild(t3)
        
        trees.setScale(0.5)
        return trees
    }
    
    func setupHouses() -> SKNode {
        let houses = SKNode()
        
        let h0 = SKSpriteNode(imageNamed: "cena-1/house-0")
        h0.position = CGPoint(x: -660, y: 100)
        h0.zPosition = 10
        
        let h1 = SKSpriteNode(imageNamed: "cena-1/house-1")
        h1.position = CGPoint(x: 0, y: 300)
        h1.zPosition = 10
        
        let h2 = SKSpriteNode(imageNamed: "cena-1/house-2")
        h2.position = CGPoint(x: 550, y: 75)
        h2.zPosition = 10
        
        let h3 = SKSpriteNode(imageNamed: "cena-1/house-3")
        h3.position = CGPoint(x: 225, y: -300)
        h3.zPosition = 10
        
        let h4 = SKSpriteNode(imageNamed: "cena-1/house-3")
        h4.position = CGPoint(x: -540, y: -220)
        h4.zPosition = 10
        
        
        houses.addChild(h0)
        houses.addChild(h1)
        houses.addChild(h2)
        houses.addChild(h3)
        houses.addChild(h4)
        
        houses.setScale(0.5)
        
        return houses
    }
    
    func moveIndian(indian: String, positions: [CGPoint], duration: TimeInterval) -> SKAction {
        let frontTexture = SKTexture(imageNamed: "cena-1/indian-\(indian)")
        let setFront = SKAction.setTexture(frontTexture, resize: true)
        
        let backTexture = SKTexture(imageNamed: "cena-1/indian-\(indian)-b")
        let setBack = SKAction.setTexture(backTexture, resize: true)
        
        let moveForward = SKAction.move(to: positions[1], duration: duration)
        let moveBackward = SKAction.move(to: positions[0], duration: duration)
        
        return SKAction.sequence([setFront, moveForward, setBack, moveBackward])
    }
    
    func setupIndians() -> SKNode {
        let indians = SKNode()
        
        let i0 = SKSpriteNode(imageNamed: "cena-1/indian-0")
        let i0_positions = [CGPoint(x: -400, y: 60),  CGPoint(x: -160, y: -60)]
        i0.position = i0_positions[0]
        i0.zPosition = 11
        
        let i1 = SKSpriteNode(imageNamed: "cena-1/indian-1")
        let i1_positions = [CGPoint(x: 10, y: 250), CGPoint(x: 300, y: 120)]
        i1.position = i1_positions[0]
        i1.zPosition = 12
        
        let i2 = SKSpriteNode(imageNamed: "cena-1/indian-2")
        let i2_positions = [CGPoint(x: 50, y: 25), CGPoint(x: 500, y: 25)]
        i2.position = i2_positions[0]
        i2.zPosition = 13
        
        i0.run(.repeatForever(self.moveIndian(indian: "0", positions: i0_positions, duration: 1.5)))
        i1.run(.repeatForever(self.moveIndian(indian: "1", positions: i1_positions, duration: 2)))
        i2.run(.repeatForever(self.moveIndian(indian: "2", positions: i2_positions, duration: 3.1)))
        
        let rotateLeft = SKAction.rotate(byAngle: 0.1, duration: 0.2)
        let rotateRight = SKAction.rotate(byAngle: -0.1, duration: 0.2)
        
        i0.run(.repeatForever(.sequence([rotateLeft, rotateRight])))
        i1.run(.repeatForever(.sequence([rotateLeft, rotateRight])))
        i2.run(.repeatForever(.sequence([rotateLeft, rotateRight])))
        
        indians.addChild(i0)
        indians.addChild(i1)
        indians.addChild(i2)
        
        indians.setScale(0.5)
        
        return indians
    }
}
