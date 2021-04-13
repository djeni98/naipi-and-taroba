//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//
//#-end-hidden-code

import PlaygroundSupport
import SpriteKit
import UIKit
import BookCore

//public func toRadians(_ degrees: Double) -> CGFloat {
//    return CGFloat(degrees * .pi / 180)
//}

public class Scenes: SKScene {
    
    let CHARACTER_ZPOSITION: CGFloat = 10
    let FOREGROUNG_ZPOSITION: CGFloat = 20
    
    var timerCounter = 0
    var timer = SKLabelNode(text: "--")
    
    override public func didMove(to view: SKView) {
        self.backgroundColor = .white
        setupTimer()
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
}

let width = 700 * 2
let height = 600 * 2

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: width, height: height))

var scene = Scene5(size: CGSize(width: width, height: height))
scene.scaleMode = .aspectFit
sceneView.presentScene(scene)

PlaygroundPage.current.liveView = sceneView
PlaygroundPage.current.needsIndefiniteExecution = true
