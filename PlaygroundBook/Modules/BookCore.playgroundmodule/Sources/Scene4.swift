//
//  Scene4.swift
//  PlaygroundBook
//
//  Created by Djenifer Renata Pereira on 10/04/21.
//

import Foundation
import SpriteKit


public class Scene4: SKScene {
    
    let CHARACTER_ZPOSITION: CGFloat = 10
    let FOREGROUNG_ZPOSITION: CGFloat = 20
    
    var timerCounter = 0
    var timer = SKLabelNode(text: "--")
    
    override public func didMove(to view: SKView) {
        self.backgroundColor = .white
        setupTimer()
        setupTake4()
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
    
    func setupTake4() {
        // 20 seconds
        let fullCanoe = SKNode()
        
        let taroba = setupCharacterTake0(prefix: "t")
        taroba.name = "taroba"
        taroba.position = CGPoint(x: 700, y: 500)
        fullCanoe.addChild(taroba)
        
        let naipi = setupCharacterTake0(prefix: "n")
        naipi.position = CGPoint(x: 400, y: 500)
        naipi.name = "naipi"
        fullCanoe.addChild(naipi)
        
        let canoe = setupCanoe()
        canoe.position = CGPoint(x: 600, y: 500)
        fullCanoe.addChild(canoe)
        
        let river = setupRiverBackground()
        river.position = CGPoint(x: 600, y: 100)
        
        let riverForeground = setupRiverForeground(prefix: "character-river")
        riverForeground.position = CGPoint(x: 600, y: 300)
        
        let naipiAndTaroba = SKNode()
        naipiAndTaroba.addChild(fullCanoe)
        naipiAndTaroba.addChild(riverForeground)
        
        naipiAndTaroba.position = CGPoint(x: -1400, y: 0)
        
        let moveCharacters = SKAction.move(to: CGPoint(x: 1400, y: 0), duration: 15)
        naipiAndTaroba.run(moveCharacters)
        
        let mboi = setupMboi()
        mboi.position = CGPoint(x: 0, y: 500)
        
        let mboiRiverForeground = setupRiverForeground(prefix: "mboi-river")
        mboiRiverForeground.position = CGPoint(x: 100, y: 100)
        
        let mboiCharacter = SKNode()
        mboiCharacter.addChild(mboi)
        mboiCharacter.addChild(mboiRiverForeground)
        
        mboiCharacter.position = CGPoint(x: -1600,  y: 0)
        
        let moveMboi = SKAction.move(to: CGPoint(x: 1800, y: 0), duration: 20)
        moveMboi.timingMode = .easeIn
        
        mboiCharacter.run(moveMboi)
        
        let take4 = SKNode()
        
        take4.addChild(river)
        take4.addChild(mboiCharacter)
        take4.addChild(naipiAndTaroba)
        
        self.addChild(take4)
    }
    
    func setupMboi() -> SKNode {
        let mboiNode = SKNode()
        
        let mboi = SKSpriteNode(imageNamed: "cena-4/mboi-curve-0")
        mboi.zPosition = 5 + CHARACTER_ZPOSITION
        
        var animationMboi = [SKTexture]()
        
        animationMboi.append(SKTexture(imageNamed: "cena-4/mboi-curve-0"))
        animationMboi.append(SKTexture(imageNamed: "cena-4/mboi-curve-1"))
        animationMboi.append(SKTexture(imageNamed: "cena-4/mboi-curve-2"))
        
        let animateMboi = SKAction.animate(with: animationMboi, timePerFrame: 0.2, resize: true, restore: true)
        
        mboi.run(.repeatForever(animateMboi))
        
        mboiNode.addChild(mboi)
        // mboiNode.setScale(0.5) // It doesn't work. Why??
        
        mboi.setScale(0.5)
        
        return mboi
    }
    
    func setupCanoe() -> SKNode {
        let front = SKSpriteNode(imageNamed: "cena-4/canoe-front")
        front.position = CGPoint(x: 0, y: -214)
        front.zPosition = 5 + CHARACTER_ZPOSITION
        
        let back = SKSpriteNode(imageNamed: "cena-4/canoe-back")
        back.position = CGPoint(x: -40, y: -128)
        back.zPosition = 0 + CHARACTER_ZPOSITION
        
        let canoe = SKNode()
        
        canoe.addChild(front)
        canoe.addChild(back)
        
        canoe.setScale(0.5)
        
        let rotateF = SKAction.rotate(byAngle: 0.025, duration: 0.30)
        rotateF.timingMode = .easeInEaseOut
        let rotateB = SKAction.rotate(byAngle: -0.025, duration: 0.30)
        rotateB.timingMode = .easeInEaseOut
        let rotateCanoe = SKAction.sequence([rotateF, rotateB, rotateB, rotateF])
        canoe.run(.repeatForever(rotateCanoe))
        
        return canoe
    }
    
    func setupRiverBackground() -> SKNode {
        let river = SKNode()
        
        let back = SKSpriteNode(imageNamed: "cena-4/river")
        back.zPosition = 3
        
        let move = SKAction.sequence([.move(to: CGPoint(x: 200, y: 20), duration: 2), .move(to: CGPoint(x: 0, y: 0), duration: 2)])
        back.run(.repeatForever(move))
        
        river.addChild(back)
        
        river.setScale(0.5)
        
        return river
    }
    
    func setupRiverForeground(prefix: String) -> SKNode {
        let river = SKNode()
        
        let front = SKSpriteNode(imageNamed: "cena-4/\(prefix)-0")
        front.zPosition = FOREGROUNG_ZPOSITION
        
        let animationList = [SKTexture(imageNamed: "cena-4/\(prefix)-0"), SKTexture(imageNamed: "cena-4/\(prefix)-1")]
        let animateRiver = SKAction.animate(with: animationList, timePerFrame: 1, resize: true, restore: true)
        front.run(.repeatForever(animateRiver))
        
        river.addChild(front)
        
        river.setScale(0.5)
        
        return river
    }
    
    func setupCharacterTake0(prefix: String) -> SKNode {
        if prefix != "t" && prefix != "n" { return SKNode() }
        
        let character = SKNode()
        
        let rightArm = SKSpriteNode(imageNamed: "cena-4/right-arm")
        rightArm.anchorPoint = CGPoint(x: 0.2, y: 0.8)
        rightArm.position = CGPoint(x: 80, y: -120)
        rightArm.zPosition = 2 + CHARACTER_ZPOSITION
        
        let body = SKSpriteNode(imageNamed: "cena-4/\(prefix)-0")
        body.position = CGPoint.zero
        body.zPosition = 4 + CHARACTER_ZPOSITION
        
        let leftArm = SKSpriteNode(imageNamed: "cena-4/left-arm")
        leftArm.anchorPoint = CGPoint(x: 0.5, y: 1)
        leftArm.position = CGPoint(x: -20, y: -100)
        leftArm.zPosition = 6 + CHARACTER_ZPOSITION
        
        if prefix == "n" {
            rightArm.position = CGPoint(x: 72, y: -120)
            leftArm.position = CGPoint(x: -32, y: -104)
            
            let hair = SKSpriteNode(imageNamed: "cena-4/n-hair")
            hair.position = CGPoint.zero
            hair.zPosition = 1 + CHARACTER_ZPOSITION
            
            character.addChild(hair)
        }
        
        character.addChild(rightArm)
        character.addChild(body)
        character.addChild(leftArm)
        
        var faceAnimationList = [SKTexture]()
        
        faceAnimationList.append(SKTexture(imageNamed: "cena-4/\(prefix)-0"))
        faceAnimationList.append(SKTexture(imageNamed: "cena-4/\(prefix)-0"))
        faceAnimationList.append(SKTexture(imageNamed: "cena-4/\(prefix)-1"))
        faceAnimationList.append(SKTexture(imageNamed: "cena-4/\(prefix)-2"))
        faceAnimationList.append(SKTexture(imageNamed: "cena-4/\(prefix)-1"))
        
        let animateFace = SKAction.animate(with: faceAnimationList, timePerFrame: 0.2, resize: true, restore: true)
        let rotate40degrees = SKAction.sequence([
            .rotate(byAngle: toRadians(40), duration: 0.5),
            .rotate(byAngle: toRadians(-40), duration: 0.5)
        ])
        let rotate80degrees = SKAction.sequence([
            .rotate(byAngle: toRadians(80), duration: 0.5),
            .rotate(byAngle: toRadians(-80), duration: 0.5)
        ])
        
        body.run(.repeatForever(animateFace))
        rightArm.run(.repeatForever(rotate80degrees))
        leftArm.run(.repeatForever(rotate40degrees))
        
        character.setScale(0.5)
        
        return character
    }
    
}
