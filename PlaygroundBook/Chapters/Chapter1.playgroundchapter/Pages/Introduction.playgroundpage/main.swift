/*: Introduction
 
 # Naipi and Tarobá
 **Legend of Iguazu Falls**

 This is a brazilian indiginous story, from kaingang tribe.
 It is teached in schools in Paraná, but it is not so known even in this state.

 > The kaingang tribe is more numerous in the south part of Brazil.

 For this reason, this playgroundbook brings an interactive
 animation telling about the story to spread brazilian culture.

 ## How this playground works
 When the hand shows up, click on it to interact.

 When the page starts flipping, click on it to go to the next page.


 ## Enjoy the story
 
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

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: width, height: height))

var scene = Introduction(size: CGSize(width: width, height: height))
scene.scaleMode = .aspectFit
sceneView.presentScene(scene)

PlaygroundPage.current.liveView = sceneView
PlaygroundPage.current.needsIndefiniteExecution = true

//#-end-hidden-code
