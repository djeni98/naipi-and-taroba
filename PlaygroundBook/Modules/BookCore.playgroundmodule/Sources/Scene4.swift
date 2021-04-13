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
    
    func setupTake4() {
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
}
