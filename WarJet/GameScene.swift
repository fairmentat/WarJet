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
        player.performFly()
        
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
   
        enumerateChildNodes(withName: "backgroundSprite") { (node, stop) in // Задаём имя удаляемых нод
            if node.position.y < -100 {
                
                node.removeFromParent()
            }
        }
        
    }
        
    }
    
    
    
    
    

