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
    var score:NSInteger = 0
    var scoreLabel: SKLabelNode = SKLabelNode()
    var playerPosition : NSInteger = 0
    var alien:SKSpriteNode = SKSpriteNode()
    var eat = 0
    var randomEnemyNumber = 0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        //self.addChild(myLabel)

        if (!contentCreated){
            createContent()
            contentCreated = true
        }
        
    }
    
    func setupHud(){
        scoreLabel = SKLabelNode(fontNamed: "Marker Felt")
        println(scoreLabel.fontName)
        scoreLabel.name = "scoreHud"
        scoreLabel.fontSize = 50
        scoreLabel.fontColor = UIColor.greenColor()
        scoreLabel.text =  String(format: "%05d", arguments: [score])
        scoreLabel.position = CGPointMake(self.frame.size.width/2, self.frame.size.height * 0.1)
        self.addChild(scoreLabel)
    }
    
    func adjustScore(){
        self.score = self.score + 100
        scoreLabel.text = String(format: "%05d", arguments: [score])
    }
    
    
    func createOrangeAnimation(){
        let amoebaLaranjaAtlas = SKTextureAtlas(named: "amoebaLaranja")
        var playerFrames = [SKTexture]()
        
        let numImages = amoebaLaranjaAtlas.textureNames.count
        for (var i = 0; i < numImages; i++) {
            let nameA = "amoebaL_\(i)@2x"
            playerFrames.append(amoebaLaranjaAtlas.textureNamed(nameA))
            
        }
        
        for (var i = numImages - 1; i >= 0; i--){
            let nameA = "amoebaL_\(i)@2x"
            playerFrames.append(amoebaLaranjaAtlas.textureNamed(nameA))
        }

        
        player.name = "orange"
        player.runAction( SKAction.repeatActionForever(SKAction.animateWithTextures(playerFrames, timePerFrame: 0.005, resize: true, restore: false)), withKey:"playerLaranja")
    }
    
    func createGreenAnimation(){
        let amoebaVerdeAtlas = SKTextureAtlas(named: "amoebaVerde")
        var playerFrames = [SKTexture]()
        
        let numImages = amoebaVerdeAtlas.textureNames.count
        for (var i = 0; i < numImages; i++) {
            let nameA = "amoebaVerde_\(i)@2x"
            playerFrames.append(amoebaVerdeAtlas.textureNamed(nameA))
            
        }
        
        for (var i = numImages - 1; i >= 0; i--){
            let nameA = "amoebaVerde_\(i)@2x"
            playerFrames.append(amoebaVerdeAtlas.textureNamed(nameA))
        }

        
        player.name = "green"
        player.runAction( SKAction.repeatActionForever(SKAction.animateWithTextures(playerFrames, timePerFrame: 0.005, resize: true, restore: false)), withKey:"playerVerde")
    }
    
    func createPurpleAnimation(){
        let amoebaVioletaAtlas = SKTextureAtlas(named: "amoebaVioleta")
        var playerFrames = [SKTexture]()
        
        let numImages = amoebaVioletaAtlas.textureNames.count
        for (var i = 0; i < numImages; i++) {
            let nameA = "amoebaV_\(i)@2x"
            playerFrames.append(amoebaVioletaAtlas.textureNamed(nameA))
            
        }
        
        for (var i = numImages - 1; i >= 0; i--){
            let nameA = "amoebaV_\(i)@2x"
            playerFrames.append(amoebaVioletaAtlas.textureNamed(nameA))
        }
        
        player.name = "purple"
        player.runAction( SKAction.repeatActionForever(SKAction.animateWithTextures(playerFrames, timePerFrame: 0.005, resize: true, restore: false)), withKey:"playerVioleta")
    }
    
    func createRedEnemyAnimation(){
        let amoebaFeiaVermelhaAtlas = SKTextureAtlas(named: "amoebaFeiaVermelha")
        var alienFrames = [SKTexture]()
        
        let numImages = amoebaFeiaVermelhaAtlas.textureNames.count
        for (var i = 0; i < numImages; i++) {
            let nameA = "amebafeiaVermelha_\(i)@2x"
            alienFrames.append(amoebaFeiaVermelhaAtlas.textureNamed(nameA))
            
        }
        
        for (var i = numImages - 1; i >= 0; i--) {
            let nameA = "amebafeiaVermelha_\(i)@2x"
            alienFrames.append(amoebaFeiaVermelhaAtlas.textureNamed(nameA))
            
        }
        
        alien.runAction( SKAction.repeatActionForever(SKAction.animateWithTextures(alienFrames, timePerFrame: 0.05, resize: true, restore: false)), withKey:"amoebafeiaVermelha")
    }
    
    func createBlueEnemyAnimation(){
        let amoebaFeiaAzulAtlas = SKTextureAtlas(named: "amoebaFeiaAzul")
        var alienFrames = [SKTexture]()
        
        let numImages = amoebaFeiaAzulAtlas.textureNames.count
        for (var i = 0; i < numImages; i++) {
            let nameA = "amebafeiaAzul_\(i)@2x"
            alienFrames.append(amoebaFeiaAzulAtlas.textureNamed(nameA))
            
        }
        
        for (var i = numImages - 1; i >= 0; i--) {
            let nameA = "amebafeiaAzul_\(i)@2x"
            alienFrames.append(amoebaFeiaAzulAtlas.textureNamed(nameA))
            
        }
        
        alien.runAction( SKAction.repeatActionForever(SKAction.animateWithTextures(alienFrames, timePerFrame: 0.05, resize: true, restore: false)), withKey:"amoebafeiaAzul")
    }
    
    func createYellowEnemyAnimation(){
        let amoebaFeiaAmarelaAtlas = SKTextureAtlas(named: "amoebaFeiaAmarela")
        var alienFrames = [SKTexture]()
        
        let numImages = amoebaFeiaAmarelaAtlas.textureNames.count
        for (var i = 0; i < numImages; i++) {
            let nameA = "amebafeiaAmarela_\(i)@2x"
            alienFrames.append(amoebaFeiaAmarelaAtlas.textureNamed(nameA))
            
        }
        
        for (var i = numImages - 1; i >= 0; i--) {
            let nameA = "amebafeiaAmarela_\(i)@2x"
            alienFrames.append(amoebaFeiaAmarelaAtlas.textureNamed(nameA))
            
            
        }
        
        alien.runAction( SKAction.repeatActionForever(SKAction.animateWithTextures(alienFrames, timePerFrame: 0.05, resize: true, restore: false)), withKey:"amoebafeiaAmarela")
    }

    
    func createPurpleMouthOpeningAnimation(){
        let playerAnimatedAtlas = SKTextureAtlas(named: "amoebaVioletaBoca")
        var mouthFrames = [SKTexture]()
        
        let numImages = playerAnimatedAtlas.textureNames.count
        for (var i = 0; i < numImages; i++) {
            let nameA = "amebaVioleta_\(i)"
            mouthFrames.append(playerAnimatedAtlas.textureNamed(nameA))
            
        }
        for (var i = numImages - 1; i >= 0; i--) {
            let nameA = "amebaVioleta_\(i)"
            mouthFrames.append(playerAnimatedAtlas.textureNamed(nameA))
            
        }
        
        //playerMouthAnimation = mouthFrames
        player.runAction((SKAction.animateWithTextures(mouthFrames, timePerFrame: 0.01, resize: true, restore: true)), withKey:"purpleMouthOpening")
    }
    
    func createGreenMouthOpeningAnimation(){
        let playerAnimatedAtlas = SKTextureAtlas(named: "amoebaVerdeBoca")
        var mouthFrames = [SKTexture]()
        
        let numImages = playerAnimatedAtlas.textureNames.count
        for (var i = 0; i < numImages; i++) {
            let nameA = "amebaVerde_\(i)"
            mouthFrames.append(playerAnimatedAtlas.textureNamed(nameA))
            
        }
        for (var i = numImages - 1; i >= 0; i--) {
            let nameA = "amebaVerde_\(i)"
            mouthFrames.append(playerAnimatedAtlas.textureNamed(nameA))
            
        }
        
        //playerMouthAnimation = mouthFrames
        player.runAction((SKAction.animateWithTextures(mouthFrames, timePerFrame: 0.01, resize: true, restore: true)), withKey:"greenMouthOpening")
    }
    
    func createOrangeMouthOpeningAnimation(){
        let playerAnimatedAtlas = SKTextureAtlas(named: "amoebaLaranjaBoca")
        var mouthFrames = [SKTexture]()
        
        let numImages = playerAnimatedAtlas.textureNames.count
        for (var i = 0; i < numImages; i++) {
            let nameA = "amebaLaranja_\(i)"
            mouthFrames.append(playerAnimatedAtlas.textureNamed(nameA))
            
        }
        for (var i = numImages - 1; i >= 0; i--) {
            let nameA = "amebaLaranja_\(i)"
            mouthFrames.append(playerAnimatedAtlas.textureNamed(nameA))
            
        }
        
        //playerMouthAnimation = mouthFrames
        player.runAction((SKAction.animateWithTextures(mouthFrames, timePerFrame: 0.01, resize: true, restore: true)), withKey:"orangeMouthOpening")
    }
    
    
    func createContent(){
        //let firstFrame: SKTexture = playerVermelhoAnimation[0]
        let bgMusicURL = NSBundle.mainBundle().URLForResource("dubstep", withExtension: "mp3")
        
        backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: bgMusicURL, error: nil)
        
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.prepareToPlay()
        //backgroundMusicPlayer.play()
        
        let gulpEffect = NSBundle.mainBundle().URLForResource("gulp", withExtension: "m4a")
        gulpSound = AVAudioPlayer(contentsOfURL: gulpEffect, error: nil)
        
        gulpSound.numberOfLoops = 0
        gulpSound.prepareToPlay()
        
        let backgroundImg = SKSpriteNode(imageNamed: "Fundo_Ipad")
        backgroundImg.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        backgroundImg.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        
        self.addChild(backgroundImg)
        
        
        player = SKSpriteNode(imageNamed: "AmoebaVermelha")
        //player = SKSpriteNode(texture: firstFrame)
        player.name = "purple"
        createPurpleAnimation()
        
        player.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/3.5)

        playerPosition = 0
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)
        player.physicsBody!.dynamic = true
        player.physicsBody!.categoryBitMask = amebaCat
        player.physicsBody!.contactTestBitMask = enemyCat
        player.physicsBody!.collisionBitMask = 0
        player.xScale = 0.4
        player.yScale = 0.4
        self.addChild(player)
        
        
        btnBlue = SKSpriteNode(imageNamed: "Azul")
        btnBlue.name = "btnB"
        btnBlue.position = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height/2 * 0.3)
//        btnBlue.xScale = 1.3
//        btnBlue.yScale = 1.3
//        self.addChild(btnBlue)
        
        btnRed = SKSpriteNode(imageNamed: "Vermelho")
        btnRed.name = "btnR"
        btnRed.position = CGPointMake(self.frame.size.width * 0.20, self.frame.size.height/2 * 0.3)
//        btnRed.xScale = 1.3
//        btnRed.yScale = 1.3
//        self.addChild(btnRed)
        
        btnYellow = SKSpriteNode(imageNamed: "Amarelo")
        btnYellow.name = "btnY"
        btnYellow.position = CGPointMake(self.frame.size.width * 0.80, self.frame.size.height/2 * 0.3)
//        btnYellow.xScale = 1.3
//        btnYellow.yScale = 1.3
//        self.addChild(btnYellow)
        
        
        //player.size.height/2 + 180
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
        setupHud()
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
        
        if(projectile.name! == "purple" && (monster.name! == "blue" || monster.name! == "red")){
            createPurpleMouthOpeningAnimation()
            
            gulpSound.play()
            monster.removeFromParent()
            adjustScore()
            eatCount()
        }
        else if(projectile.name! == "green" && (monster.name! == "blue" || monster.name! == "yellow")){
            createGreenMouthOpeningAnimation()
            
            gulpSound.play()
            monster.removeFromParent()
            adjustScore()
            eatCount()
        }else if(projectile.name! == "orange" && (monster.name! == "red" || monster.name! == "yellow")){
            createOrangeMouthOpeningAnimation()
            
            gulpSound.play()
            monster.removeFromParent()
            adjustScore()
            eatCount()
        }else {
            //monster.removeAllActions()
            self.gameOver()
            
            
        }
        
        
    }
    
    func eatCount(){
        eat++
        if eat == 3{
            eat = 0
            randomisePlayer()
        }
    }
    
    func randomiseEnemy() -> SKSpriteNode{
        let enemyColor: SKSpriteNode
        randomEnemyNumber = Int(arc4random_uniform(3))
        if (randomEnemyNumber == 0){
            enemyColor = SKSpriteNode(imageNamed: "AlienVermelho" as String)
            enemyColor.name = "red"
        }else if (randomEnemyNumber == 1){
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
        if (randomEnemyNumber == 0){
            createRedEnemyAnimation()
        }else if (randomEnemyNumber == 1){
            createBlueEnemyAnimation()
        } else{
            createYellowEnemyAnimation()
        }
        alien.physicsBody = SKPhysicsBody(rectangleOfSize: alien.size)
        alien.physicsBody!.dynamic = true
        alien.physicsBody!.categoryBitMask = enemyCat
        alien.physicsBody!.contactTestBitMask = amebaCat
        alien.physicsBody!.collisionBitMask = 0
        alien.xScale = 0.3
        alien.yScale = 0.3
        
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
        
        actionArray.addObject(SKAction.moveTo(CGPointMake(position, -alien.size.height), duration: NSTimeInterval(4)))
        
        
        
//        actionArray.addObject(SKAction.runBlock({
//            var transition:SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
//            //var gameOverScene:SKScene = GameOverScene(size: self.size, won: false)
//            //self.view!.presentScene(gameOverScene, transition: transition)
//        }))
//        
//        actionArray.addObject(SKAction.removeFromParent())
//        
//        alien.runAction(SKAction.sequence(actionArray as [AnyObject]))
        
        let loseAction = SKAction.runBlock() {
            let reveal = SKTransition.flipVerticalWithDuration(0.5)
            let gameOverScene = GameOverScene(size: self.size)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }
        
        //actionArray.addObject(loseAction)
        alien.runAction(SKAction.sequence(actionArray as [AnyObject]))
        
        
        
        
    }
    
    
    func updateWithTimeSinceLastUpdate(timeSinceLastUpdate:CFTimeInterval){
        
        lastYieldTimeInterval += timeSinceLastUpdate
        if (lastYieldTimeInterval > 1.5){
            lastYieldTimeInterval = 0
            addMonster()
            
            //randomisePlayer()
        }
        
        
    }
    
    func randomisePlayer(){
        let random = Int(arc4random_uniform(3))
        if (random == 0){
            createPurpleAnimation()
        }else if (random == 1){
            createGreenAnimation()
        } else {
            createOrangeAnimation()
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        var timeSinceLastUpdate = currentTime - lastUpdateTimerInterval
        lastUpdateTimerInterval = currentTime
        
        if (timeSinceLastUpdate > 1.5){
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
                    sprite.position = CGPointMake((self.frame.size.width/2)/2 - 10, self.frame.size.height/3.5)
                }
                if(location.x >= self.frame.size.width/2 + 10){
                    sprite.position = CGPointMake((self.frame.size.width/2)+(self.frame.size.width/2)/2 - 10, self.frame.size.height/3.5)
                }
                
                if((location.x > self.frame.size.width/2 - 30) && (location.x < self.frame.size.width/2 + 30)){
                    sprite.position = CGPointMake(self.frame.size.width/2 - 10, self.frame.size.height/3.5)
                }
                
            }else{
                
                
                if let name = nodeColor.name{
                    if(name == "btnY"){
                        //player = SKSpriteNode(imageNamed: "AlienAmarelo" as String)
                        player.name = "yellow"
                        player.texture = SKTexture(imageNamed: "AmoebaAmarelo")
                        println(nodeColor.name!)
                        println(player.name!)
                        //createYellowAnimation()
                    }
                    
                    if(name == "btnR"){
                        //player = SKSpriteNode(imageNamed: "AlienVermelho" as String)
                        player.name = "red"
                        player.texture = SKTexture(imageNamed: "AmoebaVermelha")
                        println(nodeColor.name!)
                        println(player.name!)
                        //createRedAnimation()
                    }
                    
                    if(name == "btnB"){
                        //player = SKSpriteNode(imageNamed: "AlienAzul" as String)
                        player.name = "blue"
                        player.texture = SKTexture(imageNamed: "AmoebaAzul")
                        println(nodeColor.name!)
                        println(player.name!)
                        //createBlueAnimation()
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
    
    
    func gameOver(){
        
        if let savedScore: Int = NSUserDefaults.standardUserDefaults().objectForKey("HighestScore") as? Int{
        println(savedScore)
            if savedScore < score{
                NSUserDefaults.standardUserDefaults().setObject(savedScore, forKey:"HighestScore")
                NSUserDefaults.standardUserDefaults().synchronize()
                //inserir score no gameCenter
            }
        }else{
            var highestScore:Int = score
                    NSUserDefaults.standardUserDefaults().setObject(highestScore, forKey:"HighestScore")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    //inserir score no gameCenter
        }
        let reveal = SKTransition.flipVerticalWithDuration(0.5)
        let gameOverScene = GameOverScene(size: self.size)
        self.view?.presentScene(gameOverScene, transition: reveal)
    }
}
