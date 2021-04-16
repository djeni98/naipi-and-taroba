//
//  Scene5.swift
//  PlaygroundBook
//
//  Created by Djenifer Renata Pereira on 12/04/21.
//

import Foundation
import SpriteKit

public class Scene5: PreScene {
    
    override public func didMove(to view: SKView) {
        self.backgroundColor = .white
        setupPart1()
        // setupTake4()
    }
    
    
    @objc static override public var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
    func setupPart1() {
        let text = setupText(texts: [
            ("Mboi couldn’t reach Naipi and Tarobá,", 1),
            ("so he cracked the earth to stop them, creating the Falls.", 4),
            ("", 0),
            ("Naipi and Tarobá fell inside it and were never seen anymore.", 10)
        ])
        text.position = CGPoint(x: self.size.width / 2, y: self.size.height - 200)

        self.addChild(text)

        self.run(.sequence([
            .wait(forDuration: 3),
            .run {
                let animation = self.setupAnimation()
                let whiteRect = SKShapeNode(rect: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
                whiteRect.fillColor = .white
                whiteRect.zPosition = self.UI_ZPOSITION - 1

                let fadeOut = SKAction.fadeOut(withDuration: 1.5)
                fadeOut.timingMode = .easeIn
                whiteRect.run(fadeOut)

                self.addChild(whiteRect)
                self.addChild(animation)
            }
        ]))
    }

    func setupAnimation() -> SKNode {
        let background = SKNode()
        
        let river = setupRiverBackground(extend: true)
        river.position = CGPoint(x: 0, y: 300)
        
        let earth = setupEarthBackground(crackWaitTime: 4)
        earth.position = CGPoint(x: 100, y: -150)
        
        background.addChild(river)
        background.addChild(earth)

        background.position = CGPoint(x: 1200, y: -200)
        
        let mboi = setupMboi()
        mboi.position = CGPoint(x: 0, y: 500)
        
        let mboiRiverForeground = setupRiverForeground(prefix: "mboi-river")
        mboiRiverForeground.position = CGPoint(x: 100, y: 100)
        
        let mboiCharacter = SKNode()
        mboiCharacter.addChild(mboi)
        mboiCharacter.addChild(mboiRiverForeground)
        
        mboiCharacter.position = CGPoint(x: 700,  y: 0)
        
        let moveMboi = SKAction.move(to: CGPoint(x: -1600, y: 0), duration: 4.5)
        moveMboi.timingMode = .easeIn
        
        mboiCharacter.run(moveMboi)
        
        let fullCanoe = SKNode()
        
        let taroba = setupCharacterPaddling(prefix: "t", animateArms: false)
        taroba.name = "taroba"
        taroba.position = CGPoint(x: 700, y: 500)
        fullCanoe.addChild(taroba)
        
        let naipi = setupCharacterPaddling(prefix: "n", animateArms: false)
        naipi.position = CGPoint(x: 400, y: 500)
        naipi.name = "naipi"
        fullCanoe.addChild(naipi)
        
        let canoe = setupCanoe()
        canoe.position = CGPoint(x: 600, y: 500)
        fullCanoe.addChild(canoe)

        let riverForeground = setupRiverForeground(prefix: "character-river")
        riverForeground.position = CGPoint(x: 600, y: 300)
        
        let naipiAndTaroba = SKNode()
        naipiAndTaroba.addChild(fullCanoe)
        // naipiAndTaroba.addChild(riverForeground)
        
        naipiAndTaroba.position = CGPoint(x: -400, y: 600)
        
        let moveCharacters = SKAction.sequence([
            .move(to: CGPoint(x: self.size.width * 0.75, y: 300), duration: 3.5),
            .run {
                naipi.run(.move(to: CGPoint(x: 200, y: 700), duration: 0.3))
                taroba.run(.move(to: CGPoint(x: 900, y: 600), duration: 0.3))
                
                canoe.run(.moveTo(y: 200, duration: 0.3))
                canoe.run(.rotate(byAngle: toRadians(-20), duration: 0.2))
            },
            .group([.move(to: CGPoint(x: self.size.width * 0.8, y: 200), duration: 0.2), .rotate(byAngle: toRadians(-60), duration: 0.2)]),
            .group([.move(to: CGPoint(x: self.size.width * 0.85, y: -200), duration: 1), .rotate(byAngle: toRadians(-30), duration: 0.2)]),
        ])
     
        naipiAndTaroba.zRotation = toRadians(-5)
        naipiAndTaroba.setScale(0.2)
        
        let removeEarthAndAddFalls = SKAction.run {
            earth.removeFromParent()
            river.removeFromParent()
            
            let falls = self.setupRiverBackground()
            falls.zRotation = toRadians(-5)
            falls.position = CGPoint(x: self.size.width * 0.3, y: 250)
            
            let fallsLines = self.setupFallsLines()
            fallsLines.position = CGPoint(x: 2100, y: -1000)
            
            falls.addChild(fallsLines)
            background.addChild(falls)
        }

        background.run(.sequence([
            .wait(forDuration: 2.5),
            .move(to: CGPoint(x: 1000, y: 340), duration: 1.5), // Move down
            .move(to: CGPoint(x: 500, y: 360), duration: 1.5), // Move forward
            .move(to: CGPoint(x: -150, y: -800), duration: 1), // Move up
            removeEarthAndAddFalls,
            .move(to: CGPoint(x: -150, y: 100), duration: 1),
            SKAction.run {
                naipiAndTaroba.run(moveCharacters)
            }
        ]))
        
        let take4 = SKNode()
        
        take4.addChild(background)
        
        take4.addChild(mboiCharacter)
        take4.addChild(naipiAndTaroba)

        let infoBox = setupInfoBox()
        infoBox.position = CGPoint(x: self.size.width * 0.3, y: self.size.height / 2)
        infoBox.alpha = 0

        take4.addChild(infoBox)

        let handButton = setupHandButton(infoNode: infoBox)
        handButton.position = CGPoint(x: self.size.width * 0.65, y: 300)

        take4.run(.sequence([
            .wait(forDuration: 13),
            .run {
                take4.addChild(handButton)
            }
        ]))

        return take4
    }

    func setupInfoBox() -> SKNode {
        let node = SKNode()

        let balloon = SKSpriteNode(imageNamed: "b-4")
        balloon.zPosition = UI_ZPOSITION + 3
        balloon.setScale(0.5)

        let infoText = setupParagraph(
            text: "The Iguazu Falls are\n between Argentina and Brazil borders.",
            font: self.infoFont, fontSize: 30
        )
        infoText.zPosition = UI_ZPOSITION + 4

        node.addChild(infoText)
        node.addChild(balloon)

        return node
    }
    
    func setupEarthBackground(crackWaitTime: TimeInterval) -> SKNode {
        let node = SKNode()
        
        let earth = SKSpriteNode(imageNamed: "earth-river")
        earth.zPosition = 4
        
        let crack = SKSpriteNode(imageNamed: "crack-4")
        crack.alpha = 0
        crack.zPosition = 5
        crack.position = CGPoint(x: earth.size.width / 2 - crack.size.width / 2, y: 0)
        
        var animationCrackList = [SKTexture]()
        
        animationCrackList.append(SKTexture(imageNamed: "crack-0"))
        animationCrackList.append(SKTexture(imageNamed: "crack-1"))
        animationCrackList.append(SKTexture(imageNamed: "crack-2"))
        animationCrackList.append(SKTexture(imageNamed: "crack-3"))
        animationCrackList.append(SKTexture(imageNamed: "crack-4"))
        
        let animateCrack = SKAction.animate(with: animationCrackList, timePerFrame: 0.3, resize: true, restore: true)
        
        crack.run(.sequence([.wait(forDuration: crackWaitTime), .fadeIn(withDuration: 0), animateCrack]))
        
        node.addChild(earth)
        node.addChild(crack)
        
        node.setScale(0.5)
        return node
    }
}
