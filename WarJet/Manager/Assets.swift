//
//  Assets.swift
//  WarJet
//
//  Created by Дмитрий on 06.05.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//

// Специальный класс для предварительной загрузки атласов

import SpriteKit

class Assets {
    static let shared = Assets()
    var isLoaded = false
    let bluePowerUpAtlas = SKTextureAtlas(named: "BluePowerUp")
    let enemyKUAtlas = SKTextureAtlas(named: "EnemyKU")
    let flameAtlas = SKTextureAtlas(named: "Flame")
    let enemyAtlas = SKTextureAtlas(named: "Enemy")
    let greenPowerUpAtlas = SKTextureAtlas(named: "GreenPowerUp")
    let warJetImgAtlas = SKTextureAtlas(named: "WarJetImg")
    
    
    func preloadAssets() {
        bluePowerUpAtlas.preload {
            print("Atlas bluePowerUp ready to go")
            
        }
        enemyKUAtlas.preload {
            print("Atlas enemyKU ready to go")
            
        }
        
        flameAtlas.preload {
            print("Atlas flame ready to go")
            
        }
        
        enemyAtlas.preload {
            print("Atlas enemy ready to go")
            
        }
        
        greenPowerUpAtlas.preload {
            print("Atlas greenPowerUp ready to go")
            
        }
        
        warJetImgAtlas.preload {
            print("Atlas warJetImg ready to go")
            
        }
        
       
        
    
        
    }
    
    
    
    
    
}
