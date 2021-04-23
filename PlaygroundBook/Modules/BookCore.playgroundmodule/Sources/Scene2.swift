//
//  Scene2.swift
//  PlaygroundBook
//
//  Created by Djenifer Renata Pereira on 11/04/21.
//

import Foundation
import SpriteKit

public class Scene2: PreScene {
    
    override public func didMove(to view: SKView) {
        self.backgroundColor = .white
        setupTake2()
    }
    
    @objc static override public var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
    func setupTake2() {
        let text = setupText(
            texts: [
                ("Era hora da tribo oferecer Naipi, uma jovem mulher,", 1),
                ("ao deus serpente Mboi.", 4)
            ]
        )
        text.position = CGPoint(x: self.size.width / 2, y: self.size.height - 200)

        self.addChild(text)

        nextButtonWaitTime = 3.5

        self.run(.sequence([
            .wait(forDuration: 4.5),
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
        let background = setupBackground()
        background.position = CGPoint(x: 700, y: 300)
        
        let mboi = setupMboi()
        mboi.position = CGPoint(x: self.size.width * 1.3, y: 300)
        
        let moveMboi = SKAction.move(to: CGPoint(x: self.size.width * 0.75, y: 300), duration: 5)
        moveMboi.timingMode = .easeIn
        mboi.run(.sequence([.wait(forDuration: 1), moveMboi]))

        let moveTimeInterval: TimeInterval = 3.5
        let naipi = setupNaipi(forwardDuration: moveTimeInterval + 0.25)
        naipi.position = CGPoint(x: 0 - self.size.width * 0.1, y: 675)
        
        let moveNaipi = SKAction.move(to: CGPoint(x: self.size.width * 0.25, y: 675), duration: moveTimeInterval)
        moveNaipi.timingMode = .easeOut
        naipi.run(moveNaipi)

        let take2 = SKNode()
        
        take2.addChild(background)
        take2.addChild(mboi)
        take2.addChild(naipi)

        let infoBox = setupInfoBox()
        infoBox.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.2)
        infoBox.alpha = 0

        take2.addChild(infoBox)

        let handButton = setupHandButton(infoNode: infoBox)
        handButton.position = CGPoint(x: 1500, y: 400)

        take2.run(.sequence([
            .wait(forDuration: 8),
            .run {
                take2.addChild(handButton)
            }
        ]))

        if let animationSound = self.setupMusic(resource: "scene-2", withExtension: "mp3") {
            animationSound.run(.sequence([
                .changeVolume(to: 0, duration: 0),
                .changeVolume(to: 0.04, duration: 2),
            ]))
            self.sounds.append(animationSound)
            self.addChild(animationSound)
        }

        if let mboiSound = self.setupMusic(resource: "mboi-river-0", withExtension: "mp3") {
            mboiSound.run(.sequence([
                .changeVolume(to: 0, duration: 0),
                .wait(forDuration: 2),
                .changeVolume(to: 0.08, duration: 2),
            ]))
            self.sounds.append(mboiSound)
            self.addChild(mboiSound)
        }
        
        return take2
    }

    func setupInfoBox() -> SKNode {
        let node = SKNode()

        let balloon = SKSpriteNode(imageNamed: "b-1")
        balloon.zPosition = UI_ZPOSITION + 3
        balloon.setScale(0.5)
//        balloon.yScale = -1 * balloon.yScale
//        balloon.xScale = -1 * balloon.xScale

        let infoText = setupParagraph(
            text: "Mboi era o Deus das Águas\n e ele protegia o rio Iguaçu.",
            font: self.infoFont, fontSize: 30
        )
        infoText.zPosition = UI_ZPOSITION + 4
        infoText.position = CGPoint(x: -50, y: -40)

        node.addChild(infoText)
        node.addChild(balloon)

        return node
    }
    
    func setupBackground() -> SKNode {
        let background = SKNode()
        
        let earth = SKSpriteNode(imageNamed: "earth-1-rescale")
        earth.position = CGPoint(x: self.size.width * 0.25, y: 500)
        earth.zPosition = 1
        background.addChild(earth)
        
        let river = SKSpriteNode(imageNamed: "river-1")
        river.position = CGPoint(x: 0, y: -500)
        river.zPosition = 2
        background.addChild(river)
        
        background.setScale(0.5)
        
        return background
    }
    
    override func setupMboi() -> SKNode {
        let mboiNode = SKNode()
        
        let mboi = SKSpriteNode(imageNamed: "mboi-curve-1-crop")
        mboi.position = CGPoint(x: 0, y: 200)
        mboi.zPosition = 10
        
        let rotateLeft = SKAction.rotate(byAngle: 0.1, duration: 1)
        let rotateRight = SKAction.rotate(byAngle: -0.1, duration: 1)
        let moveLeft = SKAction.move(to: CGPoint(x: 10, y: 250), duration: 0.5)
        let moveRight = SKAction.move(to: CGPoint(x: 0, y: 200), duration: 0.5)
        
        let groups: [SKAction] = [.group([rotateLeft, moveLeft]), .group([rotateRight, moveRight])]
        
        // mboi.run(.repeatForever(.sequence([rotateLeft, moveLeft, rotateRight, moveRight])))
        mboi.run(.repeatForever(.sequence(groups)))
        
        let river = SKSpriteNode(imageNamed: "mboi-river-0")
        river.position = CGPoint(x: 150, y: -400)
        river.zPosition = 12

        let animationList = [SKTexture(imageNamed: "mboi-river-0"), SKTexture(imageNamed: "mboi-river-1")]
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
        
        let hair = SKSpriteNode(imageNamed: "n-hair")
        hair.position = CGPoint(x: 0, y: 0)
        hair.zPosition = 3
        
        let rightArm = SKSpriteNode(imageNamed: "arm-front")
        rightArm.anchorPoint = CGPoint(x: 0.7, y: 0.9)
        rightArm.position = CGPoint(x: 74, y: -123)
        rightArm.zPosition = 4
        
        let body = SKSpriteNode(imageNamed: "n-body-front")
        body.position = CGPoint(x: 0, y: 0)
        body.zPosition = 5
        
        let leftArm = SKSpriteNode(imageNamed: "arm-front")
        leftArm.anchorPoint = CGPoint(x: 0.7, y: 0.9)
        leftArm.position = CGPoint(x: -42, y: -125)
        leftArm.zPosition = 6
        
        let rightLeg = SKSpriteNode(imageNamed: "foot-front")
        rightLeg.anchorPoint = CGPoint(x: 0.5, y: 1)
        rightLeg.position = CGPoint(x: 55, y: -240)
        rightLeg.zPosition = 3
        
        let leftLeg = SKSpriteNode(imageNamed: "foot-front")
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
