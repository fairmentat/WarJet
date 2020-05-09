//
//  GameScene.swift
//  WarJet
//
//  Created by Дмитрий on 30.04.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: ParrentScene  {
    
    var backgroundMusic: SKAudioNode!
    
    //let sceneManager = SceneManager.shared
    fileprivate var player: PlayerPlane!
    fileprivate let hud = HUD()
    fileprivate let screenSize = UIScreen.main.bounds.size
    fileprivate var lives = 3 {
        didSet {
            switch lives {
            case 3:
                hud.life1.isHidden = false
                hud.life2.isHidden = false
                hud.life3.isHidden = false
            case 2:
                hud.life2.isHidden = true
                hud.life2.isHidden = false
                hud.life3.isHidden = false
            case 1:
                hud.life2.isHidden = true
                hud.life2.isHidden = true
                hud.life3.isHidden = false
            default:
                break
            }
            
        }
    }
    
    
    
    
    
    
    override func didMove(to view: SKView) {
        
        if let musicURL = Bundle.main.url(forResource: "WarJet", withExtension: "mp3") {
            
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
            
        }
        
        // Проверяем существование сцены
        guard sceneManager.gameScene == nil else {return}
        
        sceneManager.gameScene = self
        
        physicsWorld.contactDelegate = self  // Протокол предоставляющий метод для регистрации столкновений
        physicsWorld.gravity = CGVector.zero // Сила гравитации равна нулю
        
        configureStartScene()
        spawnClouds()
        spawnIslands()
        //        let deadLine = DispatchTime.now() + .nanoseconds(1)
        //        DispatchQueue.main.asyncAfter(deadline: deadLine) { [unowned self] in
        
        self.player.performFly()
        
        
        spawnPowerUp()
        //spawnEnemy(count: 5)
        spawnEnemies()
        
        //configureUI()
        createHUD()
        
        
        
    }
    
    
    
    fileprivate func createHUD() {
        
        addChild(hud)
        
        hud.configureUI(screenSize: screenSize)
        
        
        
        
        
        
    }
    
    
    
    
    fileprivate func spawnEnemies(){
        
        
        let waitAction = SKAction.wait(forDuration: 3.0)
        let spawnSpiralAction =  SKAction.run { [unowned self] in
            self.spawnSpiralOfEnemies()
        }
        self.run(SKAction.repeatForever(SKAction.sequence([waitAction, spawnSpiralAction])))// Запускаем несколько вложенных экшенов
        
        
        
        
        
    }
    fileprivate func spawnPowerUp() { // Метод определяющий появление паверапов
        
        //        let powerUp = GreenPowerUp()
        //        powerUp.startMovement()
        //        powerUp.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        
        let spawnAction = SKAction.run {
            let randomNumber = Int(arc4random_uniform(2))
            
            let powerUp = randomNumber == 1 ? BluePowerUp() : GreenPowerUp()
            let randomPositionX = arc4random_uniform(UInt32(self.size.width - 30))
            powerUp.position = CGPoint(x: CGFloat(randomPositionX), y: self.size.height + 100)
            powerUp.startMovement()
            self.addChild(powerUp)
        }
        let randomTimeSpawn = Double(arc4random_uniform(11) + 10)
        let waitAction = SKAction.wait(forDuration: randomTimeSpawn)
        self.run(SKAction.repeatForever(SKAction.sequence([spawnAction, waitAction])))
        
        
        
    }
    fileprivate func spawnSpiralOfEnemies() {
        let enemyTextureAtlas1 = Assets.shared.enemyAtlas  //SKTextureAtlas(named: "Enemy")
        let enemyTextureAtlas2 = Assets.shared.enemyKUAtlas    //SKTextureAtlas(named: "EnemyKU")
        SKTextureAtlas.preloadTextureAtlases([enemyTextureAtlas1, enemyTextureAtlas2]) { [unowned self] in
            //Enemy.textureAtlas = enemyTextureAtlas1
            let randomNumber = Int(arc4random_uniform(2))
            
            let arrayOfAtlases = [enemyTextureAtlas1, enemyTextureAtlas2]
            let textureAtlas = arrayOfAtlases[randomNumber]
            
            let waitActions = SKAction.wait(forDuration: 1.0)
            let spawnEnemy = SKAction.run ({ [unowned self] in
                let textureNames = textureAtlas.textureNames.sorted()
                let texture = textureAtlas.textureNamed(textureAtlas.textureNames[0])
                let enemy = Enemy(enemyTexture: texture)
                enemy.position = CGPoint(x: self.size.width / 2, y: self.size.height + 110)
                self.addChild(enemy)
                enemy.flySpiral()
            })
            
            let spawnAction = SKAction.sequence([waitActions, spawnEnemy])
            let repeatActions = SKAction.repeat(spawnAction, count: 3)
            self.run(repeatActions)
            
        }
    }
    
    
    fileprivate func spawnClouds() { // Генератор бесконечных облаков
        let spawnCloudWait = SKAction.wait(forDuration: 1)
        
        let spawnCloudAction = SKAction.run {
            let cloud = Cloud.populate(at: nil)
            self.addChild(cloud)
        }
        let spawnCloudSequence = SKAction.sequence([spawnCloudWait, spawnCloudAction])
        let spawnCloudForever = SKAction.repeatForever(spawnCloudSequence)
        run(spawnCloudForever)
        
    }
    
    fileprivate func spawnIslands() { // Генератор бесконечных облаков
        let spawnIslandWait = SKAction.wait(forDuration: 1)
        
        let spawnIslandAction = SKAction.run {
            let island = Island.populate(at: nil)
            self.addChild(island)
            
        }
        let spawnIslandSequence = SKAction.sequence([spawnIslandWait, spawnIslandAction])
        let spawnIslandForever = SKAction.repeatForever(spawnIslandSequence)
        run(spawnIslandForever)
        
    }
    
    
    
    fileprivate func configureStartScene() {
        
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        
        let background = Background.populateBackground(at: screenCenterPoint) // Запускаем бэкграунд
        self.addChild(background)
        background.zPosition = 0
        
        let screen = UIScreen.main.bounds // Запускаем острова
        for _ in 1...5 {
            
            
            
            
            let island1 = Island.populate(at: CGPoint(x: 100, y: 200)) //ручной старт позиции облаков
            
            self.addChild(island1)
            let island2 = Island.populate(at: CGPoint(x: self.size.width - 100, y: self.size.height - 200))
            
            self.addChild(island2)
            
            
            
            
            
            //let cloud = Cloud.populateSprite(at: CGPoint(x: x, y: y))
            // self.addChild(cloud)
            
            
        }
        
        player = PlayerPlane.populate(at: CGPoint(x: screen.size.width / 2, y: 100))
        self.addChild(player)
        
        
        
    }
    
    
    
    
    
    
    override func didSimulatePhysics() {
        //super.didSimulatePhysics()
        player.checkPosition()
        
        enumerateChildNodes(withName: "sprite") { (node, stop) in // Задаём имя удаляемых нод
            if node.position.y <= -100 {
                
                node.removeFromParent()
            }
        }
        
        
        enumerateChildNodes(withName: "shotSprite") { (node, stop) in // Задаём имя удаляемых нод
            if node.position.y >= self.size.height + 100 {
                
                node.removeFromParent()
            }
        }
        
        
    }
    
    fileprivate func playerFire() {
        
        let shot = YellowShot()
        shot.position = self.player.position
        shot.startMovement()
        self.addChild(shot)
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        if node.name == "pause" {
            let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.0)
            let pauseScene = PauseScene(size: self.size)
            pauseScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(pauseScene, transition: transition)
        } else {
            
            playerFire()
            
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
}
extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) { // Делаем столкновения с объектами более реалистичными
        
        let explosion = SKEmitterNode(fileNamed: "EnemyExplosion") // Добавили эмиттер из папки Particals в качестве анимации взрыва
        let contactPoint = contact.contactPoint
        explosion?.position = contactPoint
        explosion?.zPosition = 25
        let waitForExplosion = SKAction.wait(forDuration: 1.0)
        
        //
        let contactCategory: BitMaskCategory = [contact.bodyA.category, contact.bodyB.category]
        switch contactCategory {
        case [.enemy, .player]: print("enemy vs player")
        if contact.bodyA.node?.name == "sprite" {
            if contact.bodyA.node?.parent != nil {
                contact.bodyA.node?.removeFromParent()
                lives -= 1
            }
            
        } else {
            if contact.bodyB.node?.parent != nil {
                contact.bodyB.node?.removeFromParent()
                lives -= 1
            }
            
        }
        addChild(explosion!)
        self.run(waitForExplosion) {
            explosion?.removeFromParent()
            
        }
        if lives == 0 {
            
            let gameOverScene = GameOverScene(size: self.size)
            //gameOverScene.backScene = self
            gameOverScene.scaleMode = .aspectFill
            let transition = SKTransition.doorsCloseVertical(withDuration: 1.0)
            self.scene!.view?.presentScene(gameOverScene, transition: transition)
            
            }
            
        case [.powerUp, .player]: print("powerUp vs player")
        case [.enemy, .shot]: print("enemy vs shot")
        self.run(SKAction.playSoundFileNamed("hitSound", waitForCompletion: false))
        hud.score += 1
        
        contact.bodyA.node?.removeFromParent()
        contact.bodyB.node?.removeFromParent()
        
        addChild(explosion!)
        self.run(waitForExplosion) {
            explosion?.removeFromParent()
            
            }
            
        default:
            preconditionFailure("dead")
        }
        
        
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
    
}




/* Старый код, рабочий, но слишком объёмный
 let bodyA = contact.bodyA.contactTestBitMask
 let bodyB = contact.bodyB.contactTestBitMask
 
 let player = BitMaskCategory.player
 let enemy = BitMaskCategory.enemy
 let shot = BitMaskCategory.shot
 let powerUp = BitMaskCategory.powerUp
 
 if bodyA == player && bodyB ==  enemy || bodyB == player && bodyA ==  enemy {
 print("enemy vs player")
 } else if bodyA == player && bodyB == powerUp || bodyB == player && bodyA == powerUp {
 print("powerUp vs player")
 } else if bodyA == shot && bodyB == enemy || bodyB == shot && bodyA == enemy {
 print("enemy vs shot")
 }*/

