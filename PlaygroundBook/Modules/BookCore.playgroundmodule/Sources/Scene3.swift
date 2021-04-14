//
//  Scene3.swift
//  PlaygroundBook
//
//  Created by Djenifer Renata Pereira on 11/04/21.
//

import Foundation
import SpriteKit

public class Scene3: PreScene {
    
    override public func didMove(to view: SKView) {
        self.backgroundColor = .white
        setupTimer()
        setupTake3()
    }
    
    
    @objc static override public var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
    func setupTake3() {
        let take3 = SKNode()
        
        let background = setupBackground()
        background.position = CGPoint(x: 700, y: 300)
        
        let taroba = setupTarobaFront(walkDuration: 4.2)
        taroba.position = CGPoint(x: -500, y: 600)
        
        let moveTaroba = SKAction.move(to: CGPoint(x: 500, y: 500), duration: 4.5)
        moveTaroba.timingMode = .easeOut
        taroba.run(moveTaroba)
        
        let naipi = setupNaipiBack(walkDuration: 3.5)
        naipi.position = CGPoint(x: 1600, y: 350)
        
        let moveNaipi = SKAction.move(to: CGPoint(x: 900, y: 450), duration: 4)
        moveNaipi.timingMode = .easeOut
        naipi.run(moveNaipi)
        
        let hearts = setupRedHearts(waitTime: 4)
        hearts.position = CGPoint(x: 700, y: 600)
        
        take3.addChild(background)
        take3.addChild(taroba)
        take3.addChild(naipi)
        take3.addChild(hearts)
        
        self.addChild(take3)
        
        let text = setupText(text: "But Naipi met Tarobá, and these two fell in love.")
        
        self.addChild(text)
    }
    
    func setupBackground() -> SKNode {
        let background = SKNode()
        
        let earth = SKSpriteNode(imageNamed: "images/earth-2ce")
        earth.position = CGPoint(x: 0, y: 0)
        earth.zPosition = 1
        
        background.addChild(earth)
        
        background.setScale(0.5)
        
        return background
    }
    
    func setupCharacterActions(nodes: [SKSpriteNode]) {
        let rightArm = nodes[0]
        let leftArm = nodes[1]
        let rightLeg = nodes[2]
        let leftLeg = nodes[3]
        
        let rotate40degrees = SKAction.sequence([
            .rotate(byAngle: toRadians(40), duration: 0.5),
            .rotate(byAngle: toRadians(-40), duration: 0.5)
        ])
        let rotate80degrees = SKAction.sequence([
            .rotate(byAngle: toRadians(80), duration: 0.5),
            .rotate(byAngle: toRadians(-80), duration: 0.5)
        ])
        
        // rightArm.zRotation = toRadians(-30) // taroba
        rightArm.zRotation = toRadians(-40)
        rightArm.run(.repeatForever(rotate80degrees))
        
        leftArm.zRotation = toRadians(40)
        leftArm.run(.sequence([
            .rotate(byAngle: toRadians(-80), duration: 0.5),
            .repeatForever(rotate80degrees)
        ]))
        
        rightLeg.zRotation = toRadians(20)
        rightLeg.run(.sequence([
            .rotate(byAngle: toRadians(-20), duration: 0.5),
            .repeatForever(rotate40degrees)
        ]))
        
        leftLeg.zRotation = toRadians(-20)
        leftLeg.run(.repeatForever(rotate40degrees))
    }
    
    func setupTarobaFront(walkDuration: TimeInterval) -> SKNode {
        let character = SKNode()
        
        let rightArm = SKSpriteNode(imageNamed: "images/arm-front")
        rightArm.anchorPoint = CGPoint(x: 0.7, y: 0.9)
        rightArm.position = CGPoint(x: 74, y: -123)
        rightArm.zPosition = 4
        
        let body = SKSpriteNode(imageNamed: "images/t-body-front")
        body.position = CGPoint(x: 0, y: 0)
        body.zPosition = 5
        
        let leftArm = SKSpriteNode(imageNamed: "images/arm-front")
        leftArm.anchorPoint = CGPoint(x: 0.7, y: 0.9)
        leftArm.position = CGPoint(x: -42, y: -125)
        leftArm.zPosition = 6
        
        let rightLeg = SKSpriteNode(imageNamed: "images/foot-front")
        rightLeg.anchorPoint = CGPoint(x: 0.5, y: 1)
        rightLeg.position = CGPoint(x: 55, y: -240)
        rightLeg.zPosition = 3
        
        let leftLeg = SKSpriteNode(imageNamed: "images/foot-front")
        leftLeg.anchorPoint = CGPoint(x: 0.5, y: 1)
        leftLeg.position = CGPoint(x: -24, y: -240)
        leftLeg.zPosition = 4
        
        setupCharacterActions(nodes: [rightArm, leftArm, rightLeg, leftLeg])
        
        let wait = SKAction.wait(forDuration: walkDuration)
        let removeActions = SKAction.run({
            rightArm.removeAllActions()
            rightArm.run(.rotate(toAngle: toRadians(30), duration: 0.5))
            
            leftArm.removeAllActions()
            leftArm.run(.rotate(toAngle: toRadians(0), duration: 0.5))
            
            rightLeg.removeAllActions()
            rightLeg.run(.rotate(toAngle: toRadians(0), duration: 0.5))
            
            leftLeg.removeAllActions()
            leftLeg.run(.rotate(toAngle: toRadians(0), duration: 0.5))
        })
        
        character.run(.sequence([wait, removeActions]))
        
        character.addChild(rightArm)
        character.addChild(body)
        character.addChild(leftArm)
        character.addChild(rightLeg)
        character.addChild(leftLeg)
        
        character.setScale(0.5)
        
        return character
    }
    
    func setupNaipiBack(walkDuration: TimeInterval) -> SKNode {
        let character = SKNode()
        
        let rightArm = SKSpriteNode(imageNamed: "images/arm-back")
        rightArm.anchorPoint = CGPoint(x: 0.7, y: 0.9)
        rightArm.position = CGPoint(x: 48, y: -114)
        rightArm.zPosition = 3
        
        let body = SKSpriteNode(imageNamed: "images/n-only-body-back")
        body.position = CGPoint(x: 0, y: 0)
        body.zPosition = 5
        
        let leftArm = SKSpriteNode(imageNamed: "images/arm-back")
        leftArm.anchorPoint = CGPoint(x: 0.7, y: 0.9)
        leftArm.position = CGPoint(x: -55, y: -125)
        leftArm.zPosition = 6
        
        let hair = SKSpriteNode(imageNamed: "images/n-hair-back")
        hair.position = CGPoint(x: 0, y: 0)
        hair.zPosition = 7
        
        let rightLeg = SKSpriteNode(imageNamed: "images/foot-back")
        rightLeg.anchorPoint = CGPoint(x: 0.5, y: 1)
        rightLeg.position = CGPoint(x: 30, y: -240)
        rightLeg.zPosition = 3
        
        let leftLeg = SKSpriteNode(imageNamed: "images/foot-back")
        leftLeg.anchorPoint = CGPoint(x: 0.5, y: 1)
        leftLeg.position = CGPoint(x: -41, y: -240)
        leftLeg.zPosition = 4
        
        setupCharacterActions(nodes: [rightArm, leftArm, rightLeg, leftLeg])
        
        let wait = SKAction.wait(forDuration: walkDuration)
        let removeActions = SKAction.run({
            rightArm.removeAllActions()
            rightArm.run(.rotate(toAngle: toRadians(0), duration: 0.5))
            
            leftArm.removeAllActions()
            leftArm.run(.rotate(toAngle: toRadians(-30), duration: 0.5))
            
            rightLeg.removeAllActions()
            rightLeg.run(.rotate(toAngle: toRadians(0), duration: 0.5))
            
            leftLeg.removeAllActions()
            leftLeg.run(.rotate(toAngle: toRadians(0), duration: 0.5))
        })
        
        character.run(.sequence([wait, removeActions]))
        
        character.addChild(hair)
        character.addChild(rightArm)
        character.addChild(body)
        character.addChild(leftArm)
        character.addChild(rightLeg)
        character.addChild(leftLeg)
        
        character.setScale(0.5)
        
        return character
    }
    
    func setupRedHearts(waitTime: TimeInterval) -> SKNode {
        let hearts = SKNode()
        
        let h0 = SKSpriteNode(imageNamed: "images/red-heart")
        h0.zPosition = 15
        h0.alpha = 0
        
        let h1 = SKSpriteNode(imageNamed: "images/red-heart")
        h1.position = CGPoint(x: -100, y: -200)
        h1.zPosition = 15
        h1.alpha = 0
        h1.setScale(0.75)
        
        let h2 = SKSpriteNode(imageNamed: "images/red-heart")
        h2.position = CGPoint(x: 100, y: -150)
        h2.zPosition = 15
        h2.alpha = 0
        h2.setScale(0.5)
        
        hearts.addChild(h0)
        hearts.addChild(h1)
        hearts.addChild(h2)
        
        let fadeIn = SKAction.fadeIn(withDuration: 0.2)
        
        h2.run(.sequence([.wait(forDuration: waitTime), fadeIn]))
        h1.run(.sequence([.wait(forDuration: waitTime + 0.5), fadeIn]))
        h0.run(.sequence([.wait(forDuration: waitTime + 1), fadeIn]))
        
        let rotateHeart = { (_ node: SKSpriteNode) -> Void in
            let rotate = SKAction.sequence([
                .rotate(byAngle: toRadians(10), duration: TimeInterval(0.25 * node.xScale)),
                .rotate(byAngle: toRadians(-10), duration: TimeInterval(0.25 * node.xScale))
            ])
            
            node.run(.repeatForever(rotate))
        }
        
        rotateHeart(h0)
        rotateHeart(h1)
        rotateHeart(h2)
        
        hearts.setScale(0.5)
        
        return hearts
    }
    
}
