//
//  island.swift
//  WarJet
//
//  Created by Дмитрий on 30.04.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//

import SpriteKit
import GameplayKit


//  Класс для работы с облаками




final class Cloud: SKSpriteNode, GameBackGroundSpriteable {
    
    
    static func populate(at point: CGPoint?) -> Cloud{
        let cloudImagename = configureName()
        let cloud = Cloud(imageNamed: cloudImagename)
        cloud.setScale(randomScaleFactor)
        cloud.position = point ?? randomPoint()
        cloud.zPosition = 10
        cloud.name = "backgroundSprite"
        //cloud.run(rotateForRandomAngle())
        cloud.run(move(from: cloud.position))
        
        return cloud
        
    }
    
   fileprivate static func configureName() -> String { //    функция для рандомного выбора облака по имени
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 3)
        let randomNumber = distribution.nextInt()
        let imageName = "cl" + "\(randomNumber)"
        
        return imageName
    }
    fileprivate static var randomScaleFactor: CGFloat { //    функция для рандомного выбора размера облака
        let distribution = GKRandomDistribution(lowestValue: 5, highestValue: 15)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        return randomNumber
    }

//    static func rotateForRandomAngle() -> SKAction { //    функция для рандомного поворота острова
//        let distribution = GKRandomDistribution(lowestValue: 0, highestValue: 360)
//              let randomNumber = CGFloat(distribution.nextInt())
//        return SKAction.rotate(toAngle: randomNumber * CGFloat(Double.pi / 180), duration: 0) //    Перевод градусов в радианы
//
//    }
    
    fileprivate static func move(from point: CGPoint) -> SKAction { // Движение облаков
           
           let movepoint = CGPoint(x: point.x, y: -200)
           let moveDistance = point.y + 200
           let movementSpeed: CGFloat = 150.0
           let duration = moveDistance / movementSpeed
           return SKAction.move(to: movepoint, duration: TimeInterval(duration))
       }
}
