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
        setupTimer()
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
        let background = SKNode()
        
        let river = setupRiverBackground(extend: true)
        river.position = CGPoint(x: 0, y: 300)
        
        let earth = setupEarthBackground(crackWaitTime: 4)
        earth.position = CGPoint(x: 0, y: -150)
        
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
            .move(to: CGPoint(x: 900, y: 300), duration: 3.5),
            .run {
                naipi.run(.move(to: CGPoint(x: 200, y: 700), duration: 0.3))
                taroba.run(.move(to: CGPoint(x: 900, y: 600), duration: 0.3))
                
                canoe.run(.moveTo(y: 200, duration: 0.3))
                canoe.run(.rotate(byAngle: toRadians(-20), duration: 0.2))
            },
            .group([.move(to: CGPoint(x: 1000, y: 200), duration: 0.2), .rotate(byAngle: toRadians(-60), duration: 0.2)]),
            .group([.move(to: CGPoint(x: 1150, y: -200), duration: 1), .rotate(byAngle: toRadians(-30), duration: 0.2)]),
        ])
     
        naipiAndTaroba.zRotation = toRadians(-5)
        naipiAndTaroba.setScale(0.2)
        
        let removeEarthAndAddFalls = SKAction.run {
            earth.removeFromParent()
            river.removeFromParent()
            
            let falls = self.setupRiverBackground()
            falls.zRotation = toRadians(-5)
            falls.position = CGPoint(x: 0, y: 300)
            
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
        
        // Adicionar os Naipi e Taroba
        // Naipi e Taroba caindo
        
        let take4 = SKNode()
        
        take4.addChild(background)
        
        take4.addChild(mboiCharacter)
        take4.addChild(naipiAndTaroba)
        
        // naipiAndTaroba.run(moveCharacters)
        
        self.addChild(take4)
    }
    
    func setupEarthBackground(crackWaitTime: TimeInterval) -> SKNode {
        let node = SKNode()
        
        let earth = SKSpriteNode(imageNamed: "cena-5/earth")
        earth.zPosition = 4
        
        let crack = SKSpriteNode(imageNamed: "cena-5/crack-4")
        crack.alpha = 0
        crack.zPosition = 5
        crack.position = CGPoint(x: earth.size.width / 2 - crack.size.width / 2, y: 0)
        
        var animationCrackList = [SKTexture]()
        
        animationCrackList.append(SKTexture(imageNamed: "cena-5/crack-0"))
        animationCrackList.append(SKTexture(imageNamed: "cena-5/crack-1"))
        animationCrackList.append(SKTexture(imageNamed: "cena-5/crack-2"))
        animationCrackList.append(SKTexture(imageNamed: "cena-5/crack-3"))
        animationCrackList.append(SKTexture(imageNamed: "cena-5/crack-4"))
        
        let animateCrack = SKAction.animate(with: animationCrackList, timePerFrame: 0.3, resize: true, restore: true)
        
        crack.run(.sequence([.wait(forDuration: crackWaitTime), .fadeIn(withDuration: 0), animateCrack]))
        
        node.addChild(earth)
        node.addChild(crack)
        
        node.setScale(0.5)
        return node
    }
}
