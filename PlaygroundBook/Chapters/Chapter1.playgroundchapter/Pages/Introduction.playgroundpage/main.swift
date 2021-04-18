/*: Introduction
 
 # Naipi and Tarobá
 **Legend of Iguazu Falls**

 This is a Brazilian indigenous story, from the Kaingang tribe.
 It is taught in schools in Paraná, a state of southern Brazil, but it is not well-known even in this region.

 > The Kaingang tribe is more numerous in the southern part of Brazil.

 In order to spread Brazilian culture and its folklore,
 this playground book brings an interactive animation telling this story.

 ## How this playground works
 When the hand shows up, click on it to interact.

 When the page starts flipping, click on it to go to the next page.

 ## Enjoy the story

 > This playground book has sound effects, so increase your device volume for a better experience.
 */

//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//

import PlaygroundSupport
import SpriteKit
import UIKit
import BookCore

let introWidth = 683
let introHeight = 1024

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: introWidth, height: introHeight))

var scene = Introduction(size: CGSize(width: introWidth, height: introHeight))
scene.scaleMode = .aspectFit
sceneView.presentScene(scene)

PlaygroundPage.current.liveView = sceneView
PlaygroundPage.current.needsIndefiniteExecution = true

//#-end-hidden-code
