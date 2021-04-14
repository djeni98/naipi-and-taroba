/*: Page five
 
 Mboi couldn’t reach Naipi and Tarobá, so he cracked the earth to stop them, creating the Falls.
 
 Naipi and Tarobá fell inside it and were never seen anymore.
 
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

var scene = Scene5(size: CGSize(width: width, height: height))
scene.scaleMode = .aspectFit
sceneView.presentScene(scene)

PlaygroundPage.current.wantsFullScreenLiveView = true

PlaygroundPage.current.liveView = sceneView
PlaygroundPage.current.needsIndefiniteExecution = true

//#-end-hidden-code
