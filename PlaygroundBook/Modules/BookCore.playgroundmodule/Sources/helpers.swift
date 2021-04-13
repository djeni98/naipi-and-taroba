//
//  helpers.swift
//  PlaygroundBook
//
//  Created by Djenifer Renata Pereira on 11/04/21.
//

import Foundation
import SpriteKit

public func toRadians(_ degrees: Double) -> CGFloat {
    return CGFloat(degrees * .pi / 180)
}

public class PreScene: SKScene {
    
    var timerCounter = 0
    var timer = SKLabelNode(text: "--")
    
    let CHARACTER_ZPOSITION: CGFloat = 10
    let FOREGROUNG_ZPOSITION: CGFloat = 20
    
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
    
    func setupCharacterPaddling(prefix: String, animateBody: Bool = true, animateArms: Bool = true) -> SKNode {
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
        
        if animateBody {
            var faceAnimationList = [SKTexture]()
            
            faceAnimationList.append(SKTexture(imageNamed: "cena-4/\(prefix)-0"))
            faceAnimationList.append(SKTexture(imageNamed: "cena-4/\(prefix)-0"))
            faceAnimationList.append(SKTexture(imageNamed: "cena-4/\(prefix)-1"))
            faceAnimationList.append(SKTexture(imageNamed: "cena-4/\(prefix)-2"))
            faceAnimationList.append(SKTexture(imageNamed: "cena-4/\(prefix)-1"))
            
            let animateFace = SKAction.animate(with: faceAnimationList, timePerFrame: 0.2, resize: true, restore: true)
            
            body.run(.repeatForever(animateFace))
        }
        
        if animateArms {
            let rotate40degrees = SKAction.sequence([
                .rotate(byAngle: toRadians(40), duration: 0.5),
                .rotate(byAngle: toRadians(-40), duration: 0.5)
            ])
            let rotate80degrees = SKAction.sequence([
                .rotate(byAngle: toRadians(80), duration: 0.5),
                .rotate(byAngle: toRadians(-80), duration: 0.5)
            ])
            
            rightArm.run(.repeatForever(rotate80degrees))
            leftArm.run(.repeatForever(rotate40degrees))
        }
        
        character.setScale(0.5)
        
        return character
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
    
    func setupRiverBackground(extend: Bool = false) -> SKNode {
        let river = SKNode()
        
        let back = SKSpriteNode(imageNamed: "cena-4/river")
        back.zPosition = 3
        
        let move = SKAction.sequence([.move(to: CGPoint(x: 200, y: 20), duration: 2), .move(to: CGPoint(x: 0, y: 0), duration: 2)])
        back.run(.repeatForever(move))
        
        river.addChild(back)
        
        if extend {
            let copy = back.copy() as! SKSpriteNode
            copy.alpha = 0.5
            copy.position = CGPoint(x: back.size.width, y: 0)
            
            copy.removeAllActions()
            
            let moveCopy = SKAction.sequence([.move(to: CGPoint(x: copy.position.x + 200, y: 20), duration: 2), .move(to: CGPoint(x: copy.position.x, y: 0), duration: 2)])
            copy.run(.repeatForever(moveCopy))
            
            river.addChild(copy)
        }

        river.setScale(0.5)
        
        return river
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
    
    func setupFallsLines(hideMiddleLine: Bool = false) -> SKNode {
        let lines = SKNode()
        
        let l0 = SKSpriteNode(imageNamed: "cena-5/waterfall-line")
        l0.zPosition = CHARACTER_ZPOSITION - 1
        l0.position = CGPoint(x: -2 * l0.size.width, y: -212 * 2)
        
        let l1 = l0.copy() as! SKSpriteNode
        l1.position = CGPoint(x: -1 * l0.size.width, y: -106 * 2)
        
        let l2 = l0.copy() as! SKSpriteNode
        l2.alpha = hideMiddleLine ? 0 : 1
        l2.position = CGPoint(x: 0, y: 0)
        
        let l3 = l0.copy() as! SKSpriteNode
        l3.position = CGPoint(x: l0.size.width, y: 106 * 2)
        
        let l4 = l0.copy() as! SKSpriteNode
        l4.position = CGPoint(x: 2 * l0.size.width, y: 212 * 2)
        
        lines.addChild(l0)
        lines.addChild(l1)
        lines.addChild(l2)
        lines.addChild(l3)
        lines.addChild(l4)
        
        // lines.setScale(0.5) // will be added a node with setScale
        lines.zRotation = toRadians(5)
        
        return lines
    }
}
