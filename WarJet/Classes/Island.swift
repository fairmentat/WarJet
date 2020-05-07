//
//  island.swift
//  WarJet
//
//  Created by Дмитрий on 30.04.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//

import SpriteKit
import GameplayKit


//  Класс для работы с островами


final class Island: SKSpriteNode, GameBackGroundSpriteable{
    
    static func populate(at point: CGPoint?) -> Island{
        let islandImagename = configureName()
        let island = Island(imageNamed: islandImagename)
        island.setScale(randomScaleFactor)
        island.position = point ?? randomPoint()
        island.zPosition = 1
        island.name = "sprite"
        island.run(rotateForRandomAngle())
        island.run(move(from: island.position))
        
        return island
        
    }
    
    fileprivate static func configureName() -> String { //    функция для рандомного выбора острова по имени
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 4)
        let randomNumber = distribution.nextInt()
        let imageName = "is" + "\(randomNumber)"
        
        return imageName
    }
    fileprivate static var randomScaleFactor: CGFloat { //    функция для рандомного выбора размера острова
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 7)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        return randomNumber
    }
    
    fileprivate static func rotateForRandomAngle() -> SKAction { //    функция для рандомного поворота острова
        let distribution = GKRandomDistribution(lowestValue: 0, highestValue: 360)
        let randomNumber = CGFloat(distribution.nextInt())
        return SKAction.rotate(toAngle: randomNumber * CGFloat(Double.pi / 180), duration: 0) //    Перевод градусов в радианы
        
    }
    
    fileprivate static func move(from point: CGPoint) -> SKAction { // Движение островов
        
        let movepoint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 100.0
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movepoint, duration: TimeInterval(duration))
    }
    
}
