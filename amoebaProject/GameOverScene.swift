//
//  GameOverScene.swift
//  amoebaProject
//
//  Created by Camilla Schmidt on 25/06/15.
//  Copyright (c) 2015 Paulo Ricardo Ramos da Rosa. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    var againButton: SKNode! = nil
    
    override init(size: CGSize) {
        
        super.init(size: size)
        
        // 1
        backgroundColor = SKColor.whiteColor()
        
        // 2
        
        
        // 3
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "Game Over"
        label.fontSize = 40
        label.fontColor = SKColor.blackColor()
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        self.addChild(label)
        
        let backgroundImg = SKSpriteNode(imageNamed: "Fundo_Ipad")
        backgroundImg.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        backgroundImg.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        
        let gameOverImg = SKSpriteNode(imageNamed: "gameoverBack")
        gameOverImg.position = CGPointMake(self.frame.size.width/2, self.frame.size.height * 0.7)
        
        
        let retryImg = SKSpriteNode(imageNamed: "againButton")
        retryImg.position = CGPointMake(self.frame.size.width/2, self.frame.size.height * 0.4)
        retryImg.name = "retry"

        
        againButton = SKSpriteNode(imageNamed:"againButton")
        againButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.size.height/2);
        
        self.addChild(backgroundImg)
        
        self.addChild(gameOverImg)
        self.addChild(retryImg)
        
        self.addChild(againButton)
    
        
        // 4
        //runAction(SKAction.sequence([
        //    SKAction.waitForDuration(3.0),
        //    SKAction.runBlock() {
        //        // 5
        //        let reveal = SKTransition.flipHorizontalWithDuration(0.5)
        //        let scene = GameScene(size: size)
        //        self.view?.presentScene(scene, transition:reveal)
        //    }
        //    ]))

        
        let rotate = SKAction.rotateByAngle(-3.2, duration: 3)
        let repeat = SKAction.repeatActionForever(rotate)
        retryImg.runAction(repeat)
       
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            let nodeColor = self.nodeAtPoint(location)
            
                if let name = nodeColor.name{
                    if(name == "retry"){
                        let reveal = SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 0.5)
                        let scene = GameScene(size: size)
                        self.view?.presentScene(scene, transition:reveal)

                      
                    }
                    
                    
                }
            }
    }
    
    // 6
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        // Loop over all the touches in this event
        for touch: AnyObject in touches
        {
            // Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            // Check if the location of the touch is within the button's bounds
            if againButton.containsPoint(location)
            {
                let reveal = SKTransition.flipHorizontalWithDuration(0.5)
                let scene = GameScene(size: size)
                self.view?.presentScene(scene, transition:reveal)
            }
        }
    }
}