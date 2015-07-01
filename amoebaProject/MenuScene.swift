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
        
        //Criando a view
        self.menuView = SKView(frame: CGRectMake(self.frame.size.width/4, self.frame.size.height/4,
            self.frame.size.width/2, self.frame.size.height/2))
        
        //let menuV = SKScene(size: self.frame.size.width/2, self.frame.size.height/2))
        
        //self.menuView!.presentScene(MenuScene);
        
        let leftMargin = view.bounds.width/4
        let topMargin = view.bounds.height/4
        
        let backgroundImg = SKSpriteNode(imageNamed: "Initial")
        backgroundImg.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        self.addChild(backgroundImg)
        
        //Opcoes do menu
        
        playButton = SKSpriteNode(imageNamed:"playbutton")
        playButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:540.0);
        self.addChild(playButton)
        
        scoreButton = SKSpriteNode(imageNamed:"scorebutton")
        scoreButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:460.0);
        self.addChild(scoreButton)
        
        howButton = SKSpriteNode(imageNamed:"howbutton")
        howButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:380.0);
        self.addChild(howButton)
        
    }
    
    
    //tocar nos botoes
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        // Loop over all the touches in this event
        for touch: AnyObject in touches
        {
            // Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            // Check if the location of the touch is within the button's bounds
            
            //PLAY BUTTON
            
            if playButton.containsPoint(location)
            {
                let skView = mainView as! SKView
                
                let gameScene = GameScene(size: skView.bounds.size)
                gameScene.scaleMode = SKSceneScaleMode.AspectFill
                
                skView.presentScene(gameScene)
                
                self.removeFromParent()
            }
                
            //SCORE BUTTON
                
            else if scoreButton.containsPoint(location)
            {
                var game: GameViewController = self.view?.window?.rootViewController as! GameViewController
                game.showLeaderboard()
//                let skView = mainView as! SKView
//                
//                let gameScene = ScoreScene(size: skView.bounds.size)
//                gameScene.registerView(mainView!)
//                gameScene.scaleMode = SKSceneScaleMode.AspectFill
//                skView.presentScene(gameScene)
//                
//                self.removeFromParent()
            }
                
            //HOW TO PLAY BUTTON
                
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
    
    //registro que salva a view principal para ter onde criar a proxima scene
    
    func registerView(view:UIView)
    {
        mainView = view
    }
    
}
