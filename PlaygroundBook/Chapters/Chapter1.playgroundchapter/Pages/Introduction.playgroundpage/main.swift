/*: Introduction
 
 # Naipi e Tarobá
 **Lenda das Cataratas do Iguaçu**

 Essa é uma história indígena brasileira, da tribo Kaingang.
 Ela é ensinada nas escolas do Paraná, um estado do sul do Brasil, mas não é bem conhecida mesma nessa região.

 > A tribo Kaingang é mais numerosa na parte sul do Brasil.

 A fim de espalhar a cultura brasileira e seu folclore,
 esse livro playground traz uma animação interativa contanto essa história.

 ## Como este playground funciona

 Quando a mão aparecer, clique nela para interagir.

 Quando a página começar a virar, clique nela para ir para a próxima página.

 ## Aproveite a história

 > Este playground tem efeitos sonoros, então aumente o som do seu dispositiov para uma melhor experiência.
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
