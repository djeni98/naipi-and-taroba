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
        let text = setupText(texts: [
            ("The legend tells that Naipi became a rock in the middle of the Falls", 1),
            ("and Tarobá became a palm.", 5),
            ("", 0),
            ("In this way, they are fated to see each other without being able to be together again.", 7.5)
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

                let fadeOut = SKAction.fadeOut(withDuration: 1)
                fadeOut.timingMode = .easeIn
                whiteRect.run(fadeOut)

                self.addChild(whiteRect)
                self.addChild(animation)
            }
        ]))
    }

    func setupAnimation() -> SKNode {
        let background = SKNode()
        background.position = CGPoint(x: -150, y: 100)
        
        let falls = self.setupRiverBackground()
        falls.zRotation = toRadians(-5)
        falls.position = CGPoint(x: self.size.width * 0.35, y: 250)
        
        let fallsLines = self.setupFallsLines(hideMiddleLine: true)
        fallsLines.position = CGPoint(x: 2100, y: -1000)
        
        falls.addChild(fallsLines)
        background.addChild(falls)
        
        let rock = setupRock()
        rock.position = CGPoint(x: self.size.width - 150, y: 50)
        
        background.addChild(rock)
        
        let earthAndPalm = setupEarthAndPalm()
        earthAndPalm.position = CGPoint(x: -300, y: 50)
        background.addChild(earthAndPalm)
        
        background.run(.sequence([
            .wait(forDuration: 2),
            .move(to: CGPoint(x: 600, y: 100), duration: 1.5),
            .wait(forDuration: 1.5),
            .group([
                .move(to: CGPoint(x: 400, y: 100), duration: 1.5),
                .scale(to: 0.7, duration: 1.5)
            ])
        ]))
        
        let take6 = SKNode()

        take6.addChild(background)

        let infoBox = setupInfoBox()
        infoBox.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.4)
        infoBox.alpha = 0

        take6.addChild(infoBox)

        let handButton = setupHandButton(infoNode: infoBox, setupNextPage: false)
        handButton.position = CGPoint(x: self.size.width * 0.5, y: 200)

        take6.run(.sequence([
            .wait(forDuration: 10),
            .run {
                take6.addChild(handButton)
            }
        ]))

        return take6
    }

    func setupInfoBox() -> SKNode {
        let node = SKNode()

        let balloon = SKSpriteNode(imageNamed: "images/b-5")
        balloon.zPosition = UI_ZPOSITION + 3
        balloon.setScale(0.5)

        let infoText = setupParagraph(
            text: "This legend has other versions,\n but the essence\n is Naipi and Tarobá running away\n and Mboi creating the Falls,\n like I told you here.",
            font: self.infoFont, fontSize: 30
        )
        infoText.zPosition = UI_ZPOSITION + 4
        infoText.position = CGPoint(x: 0, y: -25)

        node.addChild(infoText)
        node.addChild(balloon)

        return node
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
        
        let earth = SKSpriteNode(imageNamed: "images/earth-1-rescale")
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
