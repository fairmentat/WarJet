//
//  GameScene.swift
//  WarJet
//
//  Created by Дмитрий on 30.04.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
    
    var player: PlayerPlane!
    
    
    override func didMove(to view: SKView) {
        
        configureStartScene()
        spawnClouds()
        spawnIslands()
        let deadLine = DispatchTime.now() + .nanoseconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadLine) { [unowned self] in
            
            self.player.performFly()
        }
        
        spawnPowerUp()
        //spawnEnemy(count: 5)
        spawnEnemies()
        
        
        
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
        playerFire()
    }
    
}






