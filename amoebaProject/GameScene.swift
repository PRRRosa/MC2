//
//  GameScene.swift
//  amoebaProject
//
//  Created by Paulo Ricardo Ramos da Rosa on 6/17/15.
//  Copyright (c) 2015 Paulo Ricardo Ramos da Rosa. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene {
    
    let projectileCategoryName = "projectile"
    let playerCategoryName = "player"
    let enemyCategoryName = "enemy"
    
    var backgroundMusicPlayer = AVAudioPlayer()
    
    var player:SKSpriteNode = SKSpriteNode()
    
    var playerPosition : NSInteger = 0
    
    
    override init(size: CGSize){
        super.init(size: size)
    
        let bgMusicURL = NSBundle.mainBundle().URLForResource("dubstep", withExtension: "mp3")
        
        backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: bgMusicURL, error: nil)
        
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.prepareToPlay()
        backgroundMusicPlayer.play()
        
        
        let backgroundImg = SKSpriteNode(imageNamed: "Fundo")
        backgroundImg.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        self.addChild(backgroundImg)
        
        
        player = SKSpriteNode(imageNamed: "AmoebaVermelha")
        player.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/3)
        playerPosition = 0
        self.addChild(player)
        
        //player.size.height/2 + 180
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
        
        
        
    
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
//    func swipedRight(sender:UISwipeGestureRecognizer){
//        switch playerPosition{
//        case 0:
//             player.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/3)
//             playerPosition = 1
//        case 1:
//             player.position = CGPointMake((self.frame.size.width/2)+(self.frame.size.width/2)/2, self.frame.size.height/3)
//             playerPosition = 2
//        default:
//            player.position = player.position
//        }
//        
//    }
//    
//    func swipedLeft(sender:UISwipeGestureRecognizer){
//        switch playerPosition{
//        case 2:
//            player.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/3)
//            playerPosition = 1
//        case 1:
//            player.position = CGPointMake((self.frame.size.width/2)/2, self.frame.size.height/3)
//            playerPosition = 0
//            
//        default:
//            player.position = player.position
//        }
//    }
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        //self.addChild(myLabel)
        
//        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedRight:"))
//        swipeRight.direction = .Right
//        view.addGestureRecognizer(swipeRight)
//        
//        
//        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedLeft:"))
//        swipeLeft.direction = .Left
//        view.addGestureRecognizer(swipeLeft)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            let sprite = player
            if((location.y >= self.frame.size.height/3 - 20) && (location.y <= self.frame.size.height/2)){
            
                if(location.x <= self.frame.size.width/2 - 10 ){
                    sprite.position = CGPointMake((self.frame.size.width/2)/2, self.frame.size.height/3)
                }
                if(location.x >= self.frame.size.width/2 + 10){
                    sprite.position = CGPointMake((self.frame.size.width/2)+(self.frame.size.width/2)/2, self.frame.size.height/3)
                }
            
                if((location.x > self.frame.size.width/2 - 10) && (location.x < self.frame.size.width/2 + 10)){
                    sprite.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/3)
                }
            }
            
            
            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
            //sprite.position = location
            
            
            
           // let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            //sprite.runAction(SKAction.repeatActionForever(action))
            
            //self.addChild(sprite)
            
            
            
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
