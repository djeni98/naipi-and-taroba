//
//  Scene4.swift
//  PlaygroundBook
//
//  Created by Djenifer Renata Pereira on 10/04/21.
//

import Foundation
import SpriteKit


public class Scene4: PreScene {
    
    override public func didMove(to view: SKView) {
        self.backgroundColor = .white
        setupTake4()
    }
    
    @objc static override public var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
    func setupTake4() {
        let text = setupText(texts: [
            ("They decided to run away from Mboi through the river.", 1),
            ("", 0),
            ("However, Mboi realized it and started chasing them.", 5)
        ])
        text.position = CGPoint(x: self.size.width / 2, y: self.size.height - 200)

        self.addChild(text)

        nextButtonWaitTime = 3.5

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
        // 20 seconds
        
        let river = setupRiverBackground()
        river.position = CGPoint(x: 600, y: 100)
        
        let fullCanoe = SKNode()
        
        let taroba = setupCharacterPaddling(prefix: "t")
        taroba.name = "taroba"
        taroba.position = CGPoint(x: 700, y: 500)
        fullCanoe.addChild(taroba)
        
        let naipi = setupCharacterPaddling(prefix: "n")
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
        naipiAndTaroba.addChild(riverForeground)
        
        naipiAndTaroba.position = CGPoint(x: -1000, y: 0)
        
        let moveCharacters = SKAction.move(to: CGPoint(x: self.size.width, y: 0), duration: 7.5)
        naipiAndTaroba.run(moveCharacters)
        
        let mboi = setupMboi()
        mboi.position = CGPoint(x: 0, y: 500)
        
        let mboiRiverForeground = setupRiverForeground(prefix: "mboi-river")
        mboiRiverForeground.position = CGPoint(x: 100, y: 100)
        
        let mboiCharacter = SKNode()
        mboiCharacter.addChild(mboi)
        mboiCharacter.addChild(mboiRiverForeground)
        
        mboiCharacter.position = CGPoint(x: -1600,  y: 0)
        
        let moveMboi = SKAction.move(to: CGPoint(x: self.size.width + 400, y: 0), duration: 10)
        moveMboi.timingMode = .easeIn
        
        mboiCharacter.run(.sequence([.wait(forDuration: 1), moveMboi]))
        mboiCharacter.run(.sequence([.wait(forDuration: 10.5), .fadeOut(withDuration: 0)]))
        
        let take4 = SKNode()
        
        take4.addChild(river)
        take4.addChild(mboiCharacter)
        take4.addChild(naipiAndTaroba)

        let infoBox = setupInfoBox()
        infoBox.position = CGPoint(x: self.size.width * 0.7, y: self.size.height / 2)
        infoBox.alpha = 0

        take4.addChild(infoBox)

        let handButton = setupHandButton(infoNode: infoBox)
        handButton.position = CGPoint(x: self.size.width * 0.5, y: 200)

        take4.run(.sequence([
            .wait(forDuration: 12),
            .run {
                take4.addChild(handButton)
            }
        ]))

        if let animationSound = self.setupMusic(resource: "scene-4", withExtension: "mp3") {
            animationSound.run(.sequence([
                .changeVolume(to: 0, duration: 0),
                .changeVolume(to: 0.04, duration: 2),
            ]))
            self.sounds.append(animationSound)
            self.addChild(animationSound)
        }


        if let charactersSound = self.setupMusic(resource: "characters-paddling", withExtension: "mp3") {
            charactersSound.run(.sequence([
                .changeVolume(to: 0, duration: 0),
                .changeVolume(to: 0.025, duration: 1),
                .wait(forDuration: 4.5),
                .changeVolume(to: 0, duration: 3.1),
            ]))
            self.sounds.append(charactersSound)
            self.addChild(charactersSound)
        }


        if let mboiSound = self.setupMusic(resource: "mboi-river-1", withExtension: "mp3") {
            mboiSound.run(.sequence([
                .changeVolume(to: 0, duration: 0),
                .wait(forDuration: 4),
                .changeVolume(to: 0.08, duration: 1),
                .wait(forDuration: 5.5),
                .changeVolume(to: 0, duration: 1.5),
            ]))
            self.sounds.append(mboiSound)
            self.addChild(mboiSound)
        }

        return take4
    }

    func setupInfoBox() -> SKNode {
        let node = SKNode()

        let balloon = SKSpriteNode(imageNamed: "b-3")
        balloon.zPosition = UI_ZPOSITION + 3
        balloon.setScale(0.5)

        let infoText = setupParagraph(
            text: "The Iguazu name means 'big river':\n 'y' (water, river) and 'guasu' (big)",
            font: self.infoFont, fontSize: 30
        )
        infoText.zPosition = UI_ZPOSITION + 4

        node.addChild(infoText)
        node.addChild(balloon)

        return node
    }
}
