//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit

public class AllScenes: SKScene {
    
    let CHARACTER_ZPOSITION: CGFloat = 10
    let FOREGROUNG_ZPOSITION: CGFloat = 20
    
    var timerCounter = 0
    var timer = SKLabelNode(text: "--")
    
    override public func didMove(to view: SKView) {
        self.backgroundColor = .white
        setupTimer()
        
        setupTake1()
        // setupTake4()
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
    
    func setupTake1() {
        // No specific time required
        let background = setupBackground()
        background.position = CGPoint(x: 0, y: 0)
        
        let trees = setupTrees()
        trees.position = CGPoint(x: 110, y: 350)
        
        let houses = setupHouses()
        houses.position = CGPoint(x: 250, y: 150)
        
        let indians = setupIndians()
        indians.position = CGPoint(x: 250, y: 150)
        
        let take1 = SKNode()
    
        take1.addChild(background)
        // take1.addChild(trees)
        // take1.addChild(houses)
        // take1.addChild(indians)
        
        self.addChild(take1)
    }
    
    func setupBackground() -> SKNode {
        let background = SKNode()
        
        let river = SKSpriteNode(imageNamed: "take-1/river")
        river.position = CGPoint(x: 600, y: 0)
        river.zPosition = 1
        background.addChild(river)
        
        let earth = SKSpriteNode(imageNamed: "take-1/earth")
        earth.position = CGPoint(x: -250, y: 50)
        earth.zPosition = 2
        background.addChild(earth)
        
        background.setScale(0.5)
        return background
    }
    
    func setupTrees() -> SKNode {
        let trees = SKNode()
        
        let t0 = SKSpriteNode(imageNamed: "take-1/tree-0")
        t0.position = CGPoint(x: -100, y: -44)
        t0.zPosition = 5
        
        let t1 = SKSpriteNode(imageNamed: "take-1/tree-1")
        t1.position = CGPoint(x: -30, y: 64)
        t1.zPosition = 4
        
        let t2 = SKSpriteNode(imageNamed: "take-1/tree-2")
        t2.position = CGPoint(x: 42, y: -92)
        t2.zPosition = 6
        
        let t3 = SKSpriteNode(imageNamed: "take-1/tree-0")
        t3.position = CGPoint(x: 100, y: 10)
        t3.zPosition = 5
        
        trees.addChild(t0)
        trees.addChild(t1)
        trees.addChild(t2)
        trees.addChild(t3)
        
        trees.setScale(0.5)
        return trees
    }
    
    func setupHouses() -> SKNode {
        let houses = SKNode()
        
        let h0 = SKSpriteNode(imageNamed: "take-1/house-0")
        h0.position = CGPoint(x: -330, y: 50)
        h0.zPosition = 10
        
        let h1 = SKSpriteNode(imageNamed: "take-1/house-1")
        h1.position = CGPoint(x: 55, y: 125)
        h1.zPosition = 10
        
        let h2 = SKSpriteNode(imageNamed: "take-1/house-2")
        h2.position = CGPoint(x: 330, y: -10)
        h2.zPosition = 10
        
        let h3 = SKSpriteNode(imageNamed: "take-1/house-3")
        h3.position = CGPoint(x: 120, y: -160)
        h3.zPosition = 10
        
        let h4 = SKSpriteNode(imageNamed: "take-1/house-3")
        h4.position = CGPoint(x: -270, y: -110)
        h4.zPosition = 10
        
        
        houses.addChild(h0)
        houses.addChild(h1)
        houses.addChild(h2)
        houses.addChild(h3)
        houses.addChild(h4)
        
        houses.setScale(0.5)
        
        return houses
    }
    
    func moveIndian(indian: String, positions: [CGPoint], duration: TimeInterval) -> SKAction {
        let frontTexture = SKTexture(imageNamed: "take-1/indian-\(indian)")
        let setFront = SKAction.setTexture(frontTexture, resize: true)
        
        let backTexture = SKTexture(imageNamed: "take-1/indian-\(indian)-b")
        let setBack = SKAction.setTexture(backTexture, resize: true)
        
        let moveForward = SKAction.move(to: positions[1], duration: duration)
        let moveBackward = SKAction.move(to: positions[0], duration: duration)
        
        return SKAction.sequence([setFront, moveForward, setBack, moveBackward])
    }
    
    func setupIndians() -> SKNode {
        let indians = SKNode()
        
        let i0 = SKSpriteNode(imageNamed: "take-1/indian-0")
        let i0_positions = [CGPoint(x: -200, y: 30),  CGPoint(x: -80, y: -30)]
        i0.position = i0_positions[0]
        i0.zPosition = 11
        
        let i1 = SKSpriteNode(imageNamed: "take-1/indian-1")
        let i1_positions = [CGPoint(x: 70, y: 100), CGPoint(x: 160, y: 40)]
        i1.position = i1_positions[0]
        i1.zPosition = 12
        
        let i2 = SKSpriteNode(imageNamed: "take-1/indian-2")
        let i2_positions = [CGPoint(x: 80, y: -30), CGPoint(x: 290, y: -30)]
        i2.position = i2_positions[0]
        i2.zPosition = 13
        
        i0.run(.repeatForever(self.moveIndian(indian: "0", positions: i0_positions, duration: 1.9)))
        i1.run(.repeatForever(self.moveIndian(indian: "1", positions: i1_positions, duration: 2)))
        i2.run(.repeatForever(self.moveIndian(indian: "2", positions: i2_positions, duration: 3.1)))
        
        let rotateLeft = SKAction.rotate(byAngle: 0.1, duration: 0.2)
        let rotateRight = SKAction.rotate(byAngle: -0.1, duration: 0.2)
        
        i0.run(.repeatForever(.sequence([rotateLeft, rotateRight])))
        i1.run(.repeatForever(.sequence([rotateLeft, rotateRight])))
        i2.run(.repeatForever(.sequence([rotateLeft, rotateRight])))
        
        indians.addChild(i0)
        indians.addChild(i1)
        indians.addChild(i2)
        
        indians.setScale(0.5)
        
        return indians
    }
    
    func setupTake4() {
        // 20 seconds
        let fullCanoe = SKNode()
        
        let taroba = setupCharacterTake0(prefix: "t")
        taroba.name = "taroba"
        taroba.position = CGPoint(x: 350, y: 250)
        fullCanoe.addChild(taroba)

        let naipi = setupCharacterTake0(prefix: "n")
        naipi.position = CGPoint(x: 200, y: 250)
        naipi.name = "naipi"
        fullCanoe.addChild(naipi)
        
        let canoe = setupCanoe()
        canoe.position = CGPoint(x: 300, y: 250)
        fullCanoe.addChild(canoe)
        
        let river = setupRiverBackground()
        river.position = CGPoint(x: 300, y: 50)
        
        let riverForeground = setupRiverForeground(prefix: "character-river")
        riverForeground.position = CGPoint(x: 300, y: 150)
        
        let naipiAndTaroba = SKNode()
        naipiAndTaroba.addChild(fullCanoe)
        naipiAndTaroba.addChild(riverForeground)
        
        naipiAndTaroba.position = CGPoint(x: -700, y: 0)
        
        let moveCharacters = SKAction.move(to: CGPoint(x: 700, y: 0), duration: 15)
        naipiAndTaroba.run(moveCharacters)
        
        let mboi = setupMboi()
        mboi.position = CGPoint(x: 0, y: 250)
        
        let mboiRiverForeground = setupRiverForeground(prefix: "mboi-river")
        mboiRiverForeground.position = CGPoint(x: 50, y: 50)
        
        let mboiCharacter = SKNode()
        mboiCharacter.addChild(mboi)
        mboiCharacter.addChild(mboiRiverForeground)
        
        mboiCharacter.position = CGPoint(x: -800,  y: 0)

        let moveMboi = SKAction.move(to: CGPoint(x: 900, y: 0), duration: 20)
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
        
        let mboi = SKSpriteNode(imageNamed: "take-4/mboi-curve-0")
        mboi.zPosition = 5 + CHARACTER_ZPOSITION

        var animationMboi = [SKTexture]()
        
        animationMboi.append(SKTexture(imageNamed: "take-4/mboi-curve-0"))
        animationMboi.append(SKTexture(imageNamed: "take-4/mboi-curve-1"))
        animationMboi.append(SKTexture(imageNamed: "take-4/mboi-curve-2"))

        let animateMboi = SKAction.animate(with: animationMboi, timePerFrame: 0.2, resize: true, restore: true)
        
        mboi.run(.repeatForever(animateMboi))
        
        mboiNode.addChild(mboi)
        // mboiNode.setScale(0.5) // It doesn't work. Why??
        
        mboi.setScale(0.5)
        
        return mboi
    }
    
    func setupCanoe() -> SKNode {
        let front = SKSpriteNode(imageNamed: "take-4/canoe-front")
        front.position = CGPoint(x: 0, y: -107)
        front.zPosition = 5 + CHARACTER_ZPOSITION
        
        let back = SKSpriteNode(imageNamed: "take-4/canoe-back")
        back.position = CGPoint(x: -20, y: -64)
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
        
        let back = SKSpriteNode(imageNamed: "take-4/river")
        back.zPosition = 3
        
        let move = SKAction.sequence([.move(to: CGPoint(x: 100, y: 10), duration: 2), .move(to: CGPoint(x: 0, y: 0), duration: 2)])
        back.run(.repeatForever(move))
        
        river.addChild(back)
        
        river.setScale(0.5)
        
        return river
    }
    
    func setupRiverForeground(prefix: String) -> SKNode {
        let river = SKNode()
        
        let front = SKSpriteNode(imageNamed: "take-4/\(prefix)-0")
        front.zPosition = FOREGROUNG_ZPOSITION
        
        let animationList = [SKTexture(imageNamed: "take-4/\(prefix)-0"), SKTexture(imageNamed: "take-4/\(prefix)-1")]
        let animateRiver = SKAction.animate(with: animationList, timePerFrame: 1, resize: true, restore: true)
        front.run(.repeatForever(animateRiver))
        
        river.addChild(front)
        
        river.setScale(0.5)
        
        return river
    }
    
    func setupCharacterTake0(prefix: String) -> SKNode {
        if prefix != "t" && prefix != "n" { return SKNode() }
        
        let character = SKNode()
        
        let rightArm = SKSpriteNode(imageNamed: "take-4/right-arm")
        rightArm.anchorPoint = CGPoint(x: 0.2, y: 0.8)
        rightArm.position = CGPoint(x: 40, y: -60)
        rightArm.zPosition = 2 + CHARACTER_ZPOSITION
        
        let body = SKSpriteNode(imageNamed: "take-4/\(prefix)-0")
        body.position = CGPoint.zero
        body.zPosition = 4 + CHARACTER_ZPOSITION
        
        let leftArm = SKSpriteNode(imageNamed: "take-4/left-arm")
        leftArm.anchorPoint = CGPoint(x: 0.5, y: 1)
        leftArm.position = CGPoint(x: -9, y: -49)
        leftArm.zPosition = 6 + CHARACTER_ZPOSITION
        
        if prefix == "n" {
            rightArm.position = CGPoint(x: 36, y: -60)
            leftArm.position = CGPoint(x: -16, y: -52)
            
            let hair = SKSpriteNode(imageNamed: "take-4/n-hair")
            hair.position = CGPoint.zero
            hair.zPosition = 1 + CHARACTER_ZPOSITION
            
            character.addChild(hair)
        }
        
        character.addChild(rightArm)
        character.addChild(body)
        character.addChild(leftArm)
        
        var faceAnimationList = [SKTexture]()
        
        faceAnimationList.append(SKTexture(imageNamed: "take-4/\(prefix)-0"))
        faceAnimationList.append(SKTexture(imageNamed: "take-4/\(prefix)-0"))
        faceAnimationList.append(SKTexture(imageNamed: "take-4/\(prefix)-1"))
        faceAnimationList.append(SKTexture(imageNamed: "take-4/\(prefix)-2"))
        faceAnimationList.append(SKTexture(imageNamed: "take-4/\(prefix)-1"))
        
        let animateFace = SKAction.animate(with: faceAnimationList, timePerFrame: 0.2, resize: true, restore: true)
        let rotate80degrees = SKAction.sequence([.rotate(byAngle: 1.39, duration: 0.5), .rotate(byAngle: -1.39, duration: 0.5)])
        let rotate40degrees = SKAction.sequence([.rotate(byAngle: 0.69, duration: 0.5), .rotate(byAngle: -0.69, duration: 0.5)])
        
        body.run(.repeatForever(animateFace))
        rightArm.run(.repeatForever(rotate80degrees))
        leftArm.run(.repeatForever(rotate40degrees))
        
        character.setScale(0.5)
        
        return character
    }

}
