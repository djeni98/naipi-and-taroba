//
//  Scene2.swift
//  PlaygroundBook
//
//  Created by Djenifer Renata Pereira on 11/04/21.
//

import Foundation
import SpriteKit

public class Scene2: SKScene {
    
    let CHARACTER_ZPOSITION: CGFloat = 10
    let FOREGROUNG_ZPOSITION: CGFloat = 20
    
    var timerCounter = 0
    var timer = SKLabelNode(text: "--")
    
    override public func didMove(to view: SKView) {
        self.backgroundColor = .white
        setupTimer()
        setupTake2()
    }
    
    @objc static override public var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
    func setupTimer() {
        let background = SKSpriteNode(color: .brown, size: CGSize(width: 100, height: 50))
        timer.position = CGPoint(x: 0, y: -10)
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height - 40)
        
        let wait = SKAction.wait(forDuration: 1)
        let update = SKAction.run(
        {
            self.timerCounter += 1
            self.timer.text = "\(self.timerCounter)"
        }
        )
        let seq = SKAction.sequence([wait,update])
        
        background.addChild(timer)
        self.addChild(background)
        self.run(.repeatForever(seq))
    }
    
    func setupTake2() {
        let background = setupBackground()
        background.position = CGPoint(x: 700, y: 300)
        
        let mboi = setupMboi()
        mboi.position = CGPoint(x: 2000, y: 300)
        
        let moveMboi = SKAction.move(to: CGPoint(x: 1100, y: 300), duration: 10)
        moveMboi.timingMode = .easeIn
        mboi.run(moveMboi)
        
        let naipi = setupNaipi(forwardDuration: 5)
        naipi.position = CGPoint(x: 0, y: 675)
        
        let moveNaipi = SKAction.move(to: CGPoint(x: 300, y: 675), duration: 5)
        moveNaipi.timingMode = .easeOut
        naipi.run(moveNaipi)

        
        let take2 = SKNode()
        
        take2.addChild(background)
        take2.addChild(mboi)
        take2.addChild(naipi)
        
        self.addChild(take2)
    }
    
    func setupBackground() -> SKNode {
        let background = SKNode()
        
        let earth = SKSpriteNode(imageNamed: "cena-2/earth")
        earth.position = CGPoint(x: 0, y: 500)
        earth.zPosition = 1
        background.addChild(earth)
        
        let river = SKSpriteNode(imageNamed: "cena-2/river")
        river.position = CGPoint(x: 0, y: -500)
        river.zPosition = 2
        background.addChild(river)
        
        background.setScale(0.5)
        
        return background
    }
    
    func setupMboi() -> SKNode {
        let mboiNode = SKNode()
        
        let mboi = SKSpriteNode(imageNamed: "cena-2/mboi-curve-1")
        mboi.position = CGPoint(x: 0, y: 200)
        mboi.zPosition = 10
        
        let rotateLeft = SKAction.rotate(byAngle: 0.1, duration: 1)
        let rotateRight = SKAction.rotate(byAngle: -0.1, duration: 1)
        let moveLeft = SKAction.move(to: CGPoint(x: 10, y: 250), duration: 0.5)
        let moveRight = SKAction.move(to: CGPoint(x: 0, y: 200), duration: 0.5)
        
        let groups: [SKAction] = [.group([rotateLeft, moveLeft]), .group([rotateRight, moveRight])]
        
        // mboi.run(.repeatForever(.sequence([rotateLeft, moveLeft, rotateRight, moveRight])))
        mboi.run(.repeatForever(.sequence(groups)))
        
        let river = SKSpriteNode(imageNamed: "cena-2/mboi-river-0")
        river.position = CGPoint(x: 150, y: -400)
        river.zPosition = 12

        let animationList = [SKTexture(imageNamed: "cena-2/mboi-river-0"), SKTexture(imageNamed: "cena-2/mboi-river-1")]
        let animateRiver = SKAction.animate(with: animationList, timePerFrame: 1, resize: true, restore: true)
        river.run(.repeatForever(animateRiver))
        
        mboiNode.addChild(mboi)
        mboiNode.addChild(river)
        
        mboiNode.setScale(0.5)
        
        return mboiNode
    }
    
    func setupNaipi(forwardDuration: TimeInterval) -> SKNode {
        let front = setupNaipiFront(walkDuration: forwardDuration - 0.75)
        return front
    }
    
    func setupNaipiFront(walkDuration: TimeInterval) -> SKNode {
        let character = SKNode()
        
        let hair = SKSpriteNode(imageNamed: "cena-2/n-hair")
        hair.position = CGPoint(x: 0, y: 0)
        hair.zPosition = 3
        
        let rightArm = SKSpriteNode(imageNamed: "cena-2/arm-front")
        rightArm.anchorPoint = CGPoint(x: 0.7, y: 0.9)
        rightArm.position = CGPoint(x: 74, y: -123)
        rightArm.zPosition = 4
        
        let body = SKSpriteNode(imageNamed: "cena-2/n-body-front")
        body.position = CGPoint(x: 0, y: 0)
        body.zPosition = 5
        
        let leftArm = SKSpriteNode(imageNamed: "cena-2/arm-front")
        leftArm.anchorPoint = CGPoint(x: 0.7, y: 0.9)
        leftArm.position = CGPoint(x: -42, y: -125)
        leftArm.zPosition = 6
        
        let rightLeg = SKSpriteNode(imageNamed: "cena-2/foot-front")
        rightLeg.anchorPoint = CGPoint(x: 0.5, y: 1)
        rightLeg.position = CGPoint(x: 55, y: -240)
        rightLeg.zPosition = 3
        
        let leftLeg = SKSpriteNode(imageNamed: "cena-2/foot-front")
        leftLeg.anchorPoint = CGPoint(x: 0.5, y: 1)
        leftLeg.position = CGPoint(x: -24, y: -240)
        leftLeg.zPosition = 4
        
        let rotate40degrees = SKAction.sequence([
            .rotate(byAngle: toRadians(40), duration: 0.5),
            .rotate(byAngle: toRadians(-40), duration: 0.5)
        ])
        let rotate80degrees = SKAction.sequence([
            .rotate(byAngle: toRadians(80), duration: 0.5),
            .rotate(byAngle: toRadians(-80), duration: 0.5)
        ])
        
        rightArm.zRotation = toRadians(-30)
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
        
        character.addChild(hair)
        character.addChild(rightArm)
        character.addChild(body)
        character.addChild(leftArm)
        character.addChild(rightLeg)
        character.addChild(leftLeg)
        
        character.setScale(0.5)
        
        return character
    }
}