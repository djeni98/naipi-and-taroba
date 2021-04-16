//
//  File.swift
//  PlaygroundBook
//
//  Created by Djenifer Renata Pereira on 15/04/21.
//

import Foundation
import SpriteKit
import PlaygroundSupport

enum State {
    case first
    case second
    case third
}

public class Introduction: SKScene {
    var handButton: SKNode!
    var nextPage: SKSpriteNode!

    let mainNode = SKNode()

    var state = State.first

    override public func didMove(to view: SKView) {
        self.backgroundColor = .darkGray

        let node = self.mainNode
        node.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(node)

        // Text 1
        let howItWorks = SKLabelNode(fontNamed: "herculanum")
        howItWorks.zPosition = 1
        howItWorks.text = "How this playground works"
        howItWorks.position.y = self.size.height / 2 - 100
        howItWorks.alpha = 0
        howItWorks.run(.sequence([.wait(forDuration: 0.5), .fadeIn(withDuration: 1)]))

        node.addChild(howItWorks)

        // Text 2
        let handRule = SKLabelNode(fontNamed: "Skia")
        handRule.zPosition = 2
        handRule.text = "When the hand shows up, click on it to interact."
        handRule.position.y = self.size.height / 2 - 250
        handRule.alpha = 0
        handRule.fontSize = 25
        handRule.run(.sequence([.wait(forDuration: 2), .fadeIn(withDuration: 1)]))

        node.addChild(handRule)

        // Hand and Circle
        let handNode = SKNode()
        let circle = SKShapeNode(circleOfRadius: 400)
        circle.zPosition = 3
        circle.position = CGPoint(x: -50, y: 200)
        circle.fillColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        circle.lineWidth = 2
        circle.alpha = 1

        handNode.addChild(circle)

        let hand = SKSpriteNode(imageNamed: "images/click-hand")
        hand.zPosition = 4
        let animate = SKAction.sequence([
            .scale(to: 1.2, duration: 0.5),
            .scale(to: 1, duration: 0.5),
        ])
        hand.run(.repeatForever(animate))

        handNode.addChild(hand)

        handNode.setScale(0.25)
        self.handButton = handNode

        handNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        handNode.alpha = 1

        node.run(.sequence([
            .wait(forDuration: 3),
            .run {
                self.addChild(handNode)
            }
        ]))
    }

    func touchDown(atPoint pos : CGPoint) {}

    func touchMoved(toPoint pos : CGPoint) {}

    func touchUp(atPoint pos : CGPoint) {
        let node = self.mainNode

        if state == .first && handButton.contains(pos) {
            self.state = .second

            let wellDone = SKLabelNode(fontNamed: "herculanum")
            wellDone.text = "Well done!"
            wellDone.position = CGPoint(x: 225, y: 50)
            wellDone.run(.fadeIn(withDuration: 1))

            node.addChild(wellDone)

            let pageRule1 = SKLabelNode(fontNamed: "Skia")
            pageRule1.text = "When the page starts flipping,"
            pageRule1.position.y = 15
            pageRule1.fontSize = 25

            let pageRule2 = SKLabelNode(fontNamed: "Skia")
            pageRule2.text = "click on it to go to the next page."
            pageRule2.position.y = -15
            pageRule2.fontSize = 25

            let pageRuleNode = SKNode()
            pageRuleNode.position.y = self.size.height / -2 + 300
            pageRuleNode.alpha = 0
            pageRuleNode.run(.sequence([.wait(forDuration: 1), .fadeIn(withDuration: 1)]))

            pageRuleNode.addChild(pageRule1)
            pageRuleNode.addChild(pageRule2)
            node.addChild(pageRuleNode)

            let nextButton = SKSpriteNode(imageNamed: "images/next-page-2")
            nextButton.anchorPoint = CGPoint(x: 1, y: 0)
            nextButton.position = CGPoint(x: self.size.width + 25, y: -25)
            nextButton.setScale(0.1)

            let scaleUp = SKAction.scale(to: 0.2, duration: 1)
            scaleUp.timingMode = .easeOut
            let scaleDown = SKAction.scale(to: 0.1, duration: 1)
            scaleDown.timingMode = .easeIn
            let scale = SKAction.sequence([scaleUp, scaleDown])

            nextButton.alpha = 0
            nextButton.run(.sequence([.wait(forDuration: 2), .fadeIn(withDuration: 0.5), .repeatForever(scale)]))

            self.addChild(nextButton)
            self.nextPage = nextButton
        } else if state == .second && nextPage.contains(pos) {
            self.state = .third

            let letsGo = SKLabelNode(fontNamed: "herculanum")
            letsGo.text = "Ok! Let's go to the story"
            letsGo.alpha = 0
            letsGo.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
            letsGo.run(.sequence([.wait(forDuration: 0.5), .fadeIn(withDuration: 1)]))

            node.run(.fadeOut(withDuration: 0.5))
            handButton.run(.fadeOut(withDuration: 0.5))
            nextPage.run(.sequence([
                .fadeOut(withDuration: 0.5),
                .wait(forDuration: 2),
                .fadeIn(withDuration: 0.5),
            ]))

            self.addChild(letsGo)
        } else if state == .third && nextPage.contains(pos) {
            PlaygroundPage.current.navigateTo(page: .next)
        }
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }

    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
}
