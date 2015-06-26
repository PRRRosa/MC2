//
//  MenuScene.swift
//  amoebaProject
//
//  Created by Camilla Schmidt on 25/06/15.
//  Copyright (c) 2015 Paulo Ricardo Ramos da Rosa. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene
{
    var menuView: SKView?
    var mainView: UIView?
    
    var playButton: SKNode! = nil
    var scoreButton: SKNode! = nil
    var howButton: SKNode! = nil
    
    
    override func didMoveToView(view: SKView)
    {
        
        self.menuView = SKView(frame: CGRectMake(self.frame.size.width/4, self.frame.size.height/4,
            self.frame.size.width/2, self.frame.size.height/2))
        
        //let menuV = SKScene(size: self.frame.size.width/2, self.frame.size.height/2))
        
        //self.menuView!.presentScene(MenuScene);
        
        let leftMargin = view.bounds.width/4
        let topMargin = view.bounds.height/4
        
        let backgroundImg = SKSpriteNode(imageNamed: "fundoMenu")
        backgroundImg.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        self.addChild(backgroundImg)
        
        playButton = SKSpriteNode(imageNamed:"buttonPlay")
        playButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:540.0);
        self.addChild(playButton)
        
        scoreButton = SKSpriteNode(imageNamed:"buttonScore")
        scoreButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:460.0);
        self.addChild(scoreButton)
        
        howButton = SKSpriteNode(imageNamed:"buttonHow")
        howButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:380.0);
        self.addChild(howButton)
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        // Loop over all the touches in this event
        for touch: AnyObject in touches
        {
            // Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            // Check if the location of the touch is within the button's bounds
            if playButton.containsPoint(location)
            {
                let skView = mainView as! SKView
                
                let gameScene = GameScene(size: skView.bounds.size)
                gameScene.scaleMode = SKSceneScaleMode.AspectFill
                
                skView.presentScene(gameScene)
                
                self.removeFromParent()
            }
            else if scoreButton.containsPoint(location)
            {
                let skView = mainView as! SKView
                
                let gameScene = ScoreScene(size: skView.bounds.size)
                gameScene.registerView(mainView!)
                gameScene.scaleMode = SKSceneScaleMode.AspectFill
                skView.presentScene(gameScene)
                
                self.removeFromParent()
            }
            else if howButton.containsPoint(location)
            {
                let skView = mainView as! SKView
                
                let gameScene = HowToPlayScene(size: skView.bounds.size)
                gameScene.registerView(mainView!)
                gameScene.scaleMode = SKSceneScaleMode.AspectFill
                skView.presentScene(gameScene)
                
                self.removeFromParent()
            }
        }
    }
    
    func registerView(view:UIView)
    {
        mainView = view
    }
    
}
