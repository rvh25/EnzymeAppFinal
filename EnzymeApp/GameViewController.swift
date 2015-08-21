//
//  GameViewController.swift
//  EnzymeApp
//
//  Created by admin on 2/22/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController : UIViewController {
    var scene : GameScene!
    var level: Level!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.AllButUpsideDown
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        level = Level()
        scene.level = level
        scene.swipeHandler = handleSwipe
        
        skView.presentScene(scene)
        
        beginGame()
    }
    
    func beginGame() {
        shuffle()
    }
    
    func shuffle() {
        //scene.removeAllComponentSprites()
        let newComponents = level.shuffle()
        scene.addSpritesForComponents(newComponents)
    }
    
    // Swipe handler
    func handleSwipe(swap:Swap) {
        // User cannot interact with the screen as swaps are being performed
        view.userInteractionEnabled = false
        
        if level.isPossibleSwap(swap) {
            level.performSwap(swap)

            scene.animateSwap(swap, completion:
                {self.view.userInteractionEnabled = true})
        }
    }
    
}