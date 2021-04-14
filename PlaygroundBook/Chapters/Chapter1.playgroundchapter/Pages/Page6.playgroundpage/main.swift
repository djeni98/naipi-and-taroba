/*: Page six
 
 The legend tells that Naipi became a rock in the middle of the Falls and Tarobá became a palm.
 
 In this way, they are fated to see each other without being able to be together again.
 
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

var scene = Scene6(size: CGSize(width: width, height: height))
scene.scaleMode = .aspectFit
sceneView.presentScene(scene)

PlaygroundPage.current.wantsFullScreenLiveView = true

PlaygroundPage.current.liveView = sceneView
PlaygroundPage.current.needsIndefiniteExecution = true

//#-end-hidden-code
