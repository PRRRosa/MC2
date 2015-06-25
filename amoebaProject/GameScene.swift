//
//  GameScene.swift
//  amoebaProject
//
//  Created by Paulo Ricardo Ramos da Rosa on 6/17/15.
//  Copyright (c) 2015 Paulo Ricardo Ramos da Rosa. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let projectileCategoryName = "projectile"
    let playerCategoryName = "player"
    let enemyCategoryName = "enemy"
    let enemyCat:UInt32 = 0x1 << 1
    let amebaCat:UInt32 = 0x1 << 2
    var backgroundMusicPlayer = AVAudioPlayer()
    var gulpSound = AVAudioPlayer()
    var lastYieldTimeInterval:NSTimeInterval = NSTimeInterval()
    var lastUpdateTimerInterval:NSTimeInterval = NSTimeInterval()
    var player:SKSpriteNode = SKSpriteNode()
    var btnRed:SKSpriteNode = SKSpriteNode()
    var btnBlue:SKSpriteNode = SKSpriteNode()
    var btnYellow:SKSpriteNode = SKSpriteNode()
    var contentCreated = false
    
    var playerMouthAnimation : [SKTexture]!
    
    var playerPosition : NSInteger = 0
    var alien:SKSpriteNode = SKSpriteNode()
    
    
    
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
        
    }
    
    
    func createContent(){
        let firstFrame = playerMouthAnimation[0]
        let bgMusicURL = NSBundle.mainBundle().URLForResource("dubstep", withExtension: "mp3")
        
        backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: bgMusicURL, error: nil)
        
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.prepareToPlay()
        //backgroundMusicPlayer.play()
        
        let gulpEffect = NSBundle.mainBundle().URLForResource("gulp", withExtension: "m4a")
        gulpSound = AVAudioPlayer(contentsOfURL: gulpEffect, error: nil)
        
        gulpSound.numberOfLoops = 0
        gulpSound.prepareToPlay()
        
        let backgroundImg = SKSpriteNode(imageNamed: "Fundo")
        backgroundImg.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        
        self.addChild(backgroundImg)
        
        
        player = SKSpriteNode(imageNamed: "AmoebaVermelha")
        player.name = "red"
        player.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/3)
        playerPosition = 0
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)
        player.physicsBody!.dynamic = true
        player.physicsBody!.categoryBitMask = amebaCat
        player.physicsBody!.contactTestBitMask = enemyCat
        player.physicsBody!.collisionBitMask = 0
        player.xScale = 0.7
        player.yScale = 0.7
        self.addChild(player)
        
        
        btnBlue = SKSpriteNode(imageNamed: "Azul")
        btnBlue.name = "btnB"
        btnBlue.position = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height/2 * 0.3)
//        btnBlue.xScale = 1.3
//        btnBlue.yScale = 1.3
        self.addChild(btnBlue)
        
        btnRed = SKSpriteNode(imageNamed: "Vermelho")
        btnRed.name = "btnR"
        btnRed.position = CGPointMake(self.frame.size.width * 0.20, self.frame.size.height/2 * 0.3)
//        btnRed.xScale = 1.3
//        btnRed.yScale = 1.3
        self.addChild(btnRed)
        
        btnYellow = SKSpriteNode(imageNamed: "Amarelo")
        btnYellow.name = "btnY"
        btnYellow.position = CGPointMake(self.frame.size.width * 0.80, self.frame.size.height/2 * 0.3)
//        btnYellow.xScale = 1.3
//        btnYellow.yScale = 1.3
        self.addChild(btnYellow)
        
        
        //player.size.height/2 + 180
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
    }
    
    func didBeginContact(contact: SKPhysicsContact)
    {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        firstBody = contact.bodyA
        secondBody = contact.bodyB
        
        
        if ((firstBody.categoryBitMask & amebaCat != 0) && (secondBody.categoryBitMask & enemyCat != 0)) {
            projectileDidCollideWithMonster(firstBody.node as! SKSpriteNode, monster: secondBody.node as! SKSpriteNode)
        }
    }
    
    
    func projectileDidCollideWithMonster(projectile:SKSpriteNode, monster:SKSpriteNode) {
        println("Hit")
        println(monster.name!)
        println(projectile.name!)
        
        if(projectile.name! == monster.name!){
            mouthOpening()
            gulpSound.play()
            monster.removeFromParent()
        }
        else{
            //monster.removeAllActions()
        }
        
        
    }
    
    
    
    func mouthOpening() {
        player.runAction((
            SKAction.animateWithTextures(playerMouthAnimation,
                timePerFrame: 0.01,
                resize: false,
                restore: true)),
            withKey:"mouthOpening")
    }
    
    func randomiseEnemy() -> SKSpriteNode{
        let enemyColor: SKSpriteNode
        let randomNumber = Int(arc4random_uniform(3))
        if (randomNumber == 0){
            enemyColor = SKSpriteNode(imageNamed: "AlienVermelho" as String)
            enemyColor.name = "red"
        }else if (randomNumber == 1){
            enemyColor = SKSpriteNode(imageNamed: "AlienAzul"  as String)
            enemyColor.name = "blue"
        } else {
            enemyColor = SKSpriteNode(imageNamed: "AlienAmarelo"  as String)
            enemyColor.name = "yellow"
        }
        return enemyColor
    }
    
    func randomEnemyPosition() -> CGFloat{
        var enemyPositionX: CGFloat?
        let randomNumber = Int(arc4random_uniform(3))
        switch randomNumber{
        case 0:
            enemyPositionX = (self.frame.size.width/2)/2 - 30
        case 1:
            enemyPositionX = (self.frame.size.width/2)
        case 2:
            enemyPositionX = (self.frame.size.width/2) + (self.frame.size.width/2)/2
        default:
            println()
        }
        return enemyPositionX!
    }
    
    func addMonster(){
        
        alien = randomiseEnemy() as SKSpriteNode
        alien.physicsBody = SKPhysicsBody(rectangleOfSize: alien.size)
        alien.physicsBody!.dynamic = true
        alien.physicsBody!.categoryBitMask = enemyCat
        alien.physicsBody!.contactTestBitMask = amebaCat
        alien.physicsBody!.collisionBitMask = 0
        alien.xScale = 0.5
        alien.yScale = 0.5
        
        let minX = alien.size.width/2
        let maxX = self.frame.size.width - alien.size.width/2
        let rangeX = maxX - minX
        //let position:CGFloat = CGFloat(arc4random()) % CGFloat(rangeX) + CGFloat(minX)
        let position:CGFloat = randomEnemyPosition()
        
        alien.position = CGPointMake(position, self.frame.size.height+alien.size.height)
        
        self.addChild(alien)
        
        //duração de queda aleatória
//        let minDuration = 2
//        let maxDuration = 4
//        let rangeDuration = maxDuration - minDuration
//        let duration = Int(arc4random()) % Int(rangeDuration) + Int(minDuration)
        
        var actionArray:NSMutableArray = NSMutableArray()
        
        actionArray.addObject(SKAction.moveTo(CGPointMake(position, -alien.size.height), duration: NSTimeInterval(2.5)))
        
        
        
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
            let nodeColor = self.nodeAtPoint(location)
            if((location.y >= self.frame.size.height/3 - 20) && (location.y <= self.frame.size.height/2)){
                
                if(location.x <= self.frame.size.width/2 - 10 ){
                    sprite.position = CGPointMake((self.frame.size.width/2)/2 - 10, self.frame.size.height/3)
                }
                if(location.x >= self.frame.size.width/2 + 10){
                    sprite.position = CGPointMake((self.frame.size.width/2)+(self.frame.size.width/2)/2 - 10, self.frame.size.height/3)
                }
                
                if((location.x > self.frame.size.width/2 - 30) && (location.x < self.frame.size.width/2 + 30)){
                    sprite.position = CGPointMake(self.frame.size.width/2 - 10, self.frame.size.height/3)
                }
                
            }else{
                
                
                if let name = nodeColor.name{
                    if(name == "btnY"){
                        //player = SKSpriteNode(imageNamed: "AlienAmarelo" as String)
                        player.name = "yellow"
                        println(nodeColor.name!)
                        println(player.name!)
                    }
                    
                    if(name == "btnR"){
                        //player = SKSpriteNode(imageNamed: "AlienVermelho" as String)
                        player.name = "red"
                        println(nodeColor.name!)
                        println(player.name!)
                    }
                    
                    if(name == "btnB"){
                        //player = SKSpriteNode(imageNamed: "AlienAzul" as String)
                        player.name = "blue"
                        println(nodeColor.name!)
                        println(player.name!)
                    }
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
