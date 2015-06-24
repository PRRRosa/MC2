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
    var contentCreated = false
    
    var playerMouthAnimation : [SKTexture]!
    
    
//    
//    override init(size: CGSize){
//        super.init(size: size)
//    
//        let bgMusicURL = NSBundle.mainBundle().URLForResource("dubstep", withExtension: "mp3")
//        
//        backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: bgMusicURL, error: nil)
//        
//        backgroundMusicPlayer.numberOfLoops = -1
//        backgroundMusicPlayer.prepareToPlay()
//        backgroundMusicPlayer.play()
//        
//        
//        let backgroundImg = SKSpriteNode(imageNamed: "Fundo")
//        backgroundImg.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
//        self.addChild(backgroundImg)
//        
//        
//        player = SKSpriteNode(imageNamed: "AmoebaVermelha")
//        player.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/3)
//        self.addChild(player)
//        
//        //player.size.height/2 + 180
//        self.physicsWorld.gravity = CGVectorMake(0, 0)
//        
//        
//        
//        
//    
//    }
//    
//    required init?(coder aDecoder: NSCoder){
//        super.init(coder: aDecoder)
//    }
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        
        
        let playerAnimatedAtlas = SKTextureAtlas(named: "playerAnimation")
        var mouthFrames = [SKTexture]()
        
        let numImages = playerAnimatedAtlas.textureNames.count
        for (var i = 0; i < numImages; i++) {
            let nameA = "\(i)"
            println(nameA)
            mouthFrames.append(playerAnimatedAtlas.textureNamed(nameA))
            
        }
        
        playerMouthAnimation = mouthFrames
        
        
        if (!contentCreated){
            createContent()
            contentCreated = true
        }
    }
    
    func createContent(){
        let firstFrame = playerMouthAnimation[0]
        let bgMusicURL = NSBundle.mainBundle().URLForResource("dubstep", withExtension: "mp3")
        
        backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: bgMusicURL, error: nil)
        
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.prepareToPlay()
        //backgroundMusicPlayer.play()
        
        
        let backgroundImg = SKSpriteNode(imageNamed: "Fundo")
        backgroundImg.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        self.addChild(backgroundImg)
        
        
        player = SKSpriteNode(imageNamed: "AmoebaVermelha")
        player.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/3)
        self.addChild(player)
        
        //player.size.height/2 + 180
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        createEnemy()
}
    
    
    func createEnemy(){
        
        var enemy = SKSpriteNode(imageNamed: "AlienVermelho")
        enemy.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/1.5)
        self.addChild(enemy)
    }
    
    func mouthOpening() {
        player.runAction((
            SKAction.animateWithTextures(playerMouthAnimation,
                timePerFrame: 0.1,
                resize: false,
                restore: true)),
            withKey:"mouthOpening")
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            //self.addChild(sprite)
            
            
            
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
