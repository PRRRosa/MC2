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
    let enemyCat:UInt32 = 0x1 << 1
    var backgroundMusicPlayer = AVAudioPlayer()
    var lastYieldTimeInterval:NSTimeInterval = NSTimeInterval()
    var lastUpdateTimerInterval:NSTimeInterval = NSTimeInterval()
    var player:SKSpriteNode = SKSpriteNode()
    var contentCreated = false
    
    var playerMouthAnimation : [SKTexture]!

    var playerPosition : NSInteger = 0

    
    
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
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        //self.addChild(myLabel)

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
        
//        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedRight:"))
//        swipeRight.direction = .Right
//        view.addGestureRecognizer(swipeRight)
//
//
//        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedLeft:"))
//        swipeLeft.direction = .Left
//        view.addGestureRecognizer(swipeLeft)
        
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
        playerPosition = 0
        self.addChild(player)
        
        //player.size.height/2 + 180
        self.physicsWorld.gravity = CGVectorMake(0, 0)
}
    
    
    func mouthOpening() {
        player.runAction((
            SKAction.animateWithTextures(playerMouthAnimation,
                timePerFrame: 0.1,
                resize: false,
                restore: true)),
            withKey:"mouthOpening")
    }

    func randomiseEnemy() -> NSString{
        var enemyColor: NSString?
        let randomNumber = Int(arc4random_uniform(3))
        if (randomNumber == 0){
            enemyColor = "AlienVermelho"
        }else if (randomNumber == 1){
            enemyColor = "AlienAzul"
        } else {
            enemyColor = "AlienAmarelo"
        }
        return enemyColor!
    }
    
    func addMonster(){
        
        var alien:SKSpriteNode = SKSpriteNode(imageNamed: randomiseEnemy() as String)
        alien.physicsBody = SKPhysicsBody(rectangleOfSize: alien.size)
        alien.physicsBody!.dynamic = true
        alien.physicsBody!.categoryBitMask = enemyCat
        //alien.physicsBody!.contactTestBitMask = photonTorpedoCategory
        alien.physicsBody!.collisionBitMask = 0
        alien.xScale = 0.5
        alien.yScale = 0.5
        
        let minX = alien.size.width/2
        let maxX = self.frame.size.width - alien.size.width/2
        let rangeX = maxX - minX
        let position:CGFloat = CGFloat(arc4random()) % CGFloat(rangeX) + CGFloat(minX)
        
        alien.position = CGPointMake(position, self.frame.size.height+alien.size.height)
        
        self.addChild(alien)
        
        let minDuration = 2
        let maxDuration = 4
        let rangeDuration = maxDuration - minDuration
        let duration = Int(arc4random()) % Int(rangeDuration) + Int(minDuration)
        
        var actionArray:NSMutableArray = NSMutableArray()
        
        actionArray.addObject(SKAction.moveTo(CGPointMake(position, -alien.size.height), duration: NSTimeInterval(duration)))
        actionArray.addObject(SKAction.runBlock({
            var transition:SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
            //var gameOverScene:SKScene = GameOverScene(size: self.size, won: false)
            //self.view!.presentScene(gameOverScene, transition: transition)
        }))
        
        actionArray.addObject(SKAction.removeFromParent())
        
        alien.runAction(SKAction.sequence(actionArray as [AnyObject]))
        
        
        
        
    }
    
    
    func updateWithTimeSinceLastUpdate(timeSinceLastUpdate:CFTimeInterval){
        
        lastYieldTimeInterval += timeSinceLastUpdate
        if (lastYieldTimeInterval > 1){
            lastYieldTimeInterval = 0
            addMonster()
        }
        
    }

    
    override func update(currentTime: CFTimeInterval) {
        
        var timeSinceLastUpdate = currentTime - lastUpdateTimerInterval
        lastUpdateTimerInterval = currentTime
        
        if (timeSinceLastUpdate > 1){
            timeSinceLastUpdate = 1/60
            lastUpdateTimerInterval = currentTime
        }
        
        updateWithTimeSinceLastUpdate(timeSinceLastUpdate)
        
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
}
