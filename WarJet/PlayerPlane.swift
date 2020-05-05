//
//  PlayerPlane.swift
//  WarJet
//
//  Created by Дмитрий on 30.04.2020.
//  Copyright © 2020 BioRobot. All rights reserved.
//

//Класс для управления самолётом пришельцев


import SpriteKit
import CoreMotion // Для доступа к акселерометру, чтобы с помощью него управлять кораблем

class PlayerPlane: SKSpriteNode {
    let motionManager = CMMotionManager() // Отслеживание поворотов
    var xAcceleration: CGFloat = 0 // Трансформация поворотов в скорость
    let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) // Для понимания размеров экрана
    // Массивы для анимации
    var lefTextureArrayAnimation = [SKTexture]() // Анимация влево
    var rightTextureArrayAnimation = [SKTexture]() // Анимация вправо
    var forwardTextureArrayAnimation = [SKTexture]() // Анимация прямо
    var moveDirection: TurnDirections = .none // Определение поворотов в которые мы летим
    var stillTurning = false // Булево значение определяющие, начался ли уже поворот
    let animationSpriteStrides = [(13, 1, -1), (13, 26, 1), (13, 13, 1)] // переписвыаем в кортеж циклы из метода planeAnimationFillArray для последующего его удаления
    
    static func populate(at point: CGPoint) -> PlayerPlane { // Создание самолёта
        
        let playerPlaneTexture = SKTexture(imageNamed: "WarJet_13")
        let playerPlane = PlayerPlane(texture: playerPlaneTexture)
        playerPlane.setScale(0.2)
        playerPlane.position = point
        playerPlane.zPosition = 20
        return playerPlane
    }
    
    
    
    fileprivate func movementDirectionCheck() { // Метод для задания направления анимации
        
        if xAcceleration > 0.02, moveDirection != .right, stillTurning == false {
            
            stillTurning = true
            moveDirection = .right
            turnPlane(direction: .right)
            
            
            
        }else if xAcceleration < -0.02, moveDirection != .left, stillTurning == false {
            
            stillTurning = true
            moveDirection = .left
            turnPlane(direction: .left)
            
        } else if stillTurning == false {
            turnPlane(direction: .none)
            
            
            
        }
        
        
        
    }
    fileprivate func turnPlane(direction: TurnDirections) { // Метод запускающий анимацию для каждого конкретного направления
        
        var array = [SKTexture]()
        
        if direction == .right {
            
            array = rightTextureArrayAnimation
        } else if direction == .left {
            array = lefTextureArrayAnimation
            
        } else {
            array = forwardTextureArrayAnimation
            
        }
        
        let forwardAction = SKAction.animate(with: array, timePerFrame: 0.05, resize: true, restore: false)
        let backwardAction = SKAction.animate(with: array.reversed(), timePerFrame: 0.05, resize: true, restore: false)
        let sequenceAction = SKAction.sequence([forwardAction, backwardAction])
        self.run(sequenceAction){ [unowned self] in
            self.stillTurning = false
        }
    }
    
    enum TurnDirections {
        case left
        case right
        case none
        
    }
    
    
    func performFly() {
        //planeAnimationFillArray() // Подгружаем текстуры
        preloadTextureArrays()
        motionManager.accelerometerUpdateInterval = 0.2 // Получаем данные с акеслерометра
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { [unowned self] (data, error) in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x * 0.7) + self.xAcceleration * 0.3
                
            }
        }
        let planeWaitAction = SKAction.wait(forDuration: 1.0)
        let planeDirectionCheckActions = SKAction.run { [unowned self] in
            self.movementDirectionCheck()
        }
        let planeSequence = SKAction.sequence([planeWaitAction, planeDirectionCheckActions])
        let planeSequenceForever = SKAction.repeatForever(planeSequence)
        self.run(planeSequenceForever)
    }
    
    
    
    func checkPosition() {
        self.position.x += xAcceleration * 50
        if self.position.x < -70 {
            self.position.x = screenSize.width + 70
        }else if self.position.x > screenSize.width + 70 {
            self.position.x = -70
        }
        
    }
    //Упрощаем код метода planeAnimationFillArray (усложняем для понимания, упрощаем для записи)
    
    fileprivate func preloadTextureArrays() {
        for i in 0...2{
            
            self.preloadArray(_stride: animationSpriteStrides[i], callback: { [unowned self] array in
                switch i {
                case 0: self.lefTextureArrayAnimation = array
                case 1: self.rightTextureArrayAnimation = array
                case 2: self.forwardTextureArrayAnimation = array
                default: break
                    
                }
            })
            
            
        }
        
    }
    fileprivate func preloadArray(_stride: (Int, Int, Int), callback: @escaping (_ array: [SKTexture]) -> ()){
        var array = [SKTexture]()
        for i in stride(from: _stride.0, through: _stride.1, by: _stride.2) {
            let number = String(format: "%02d", i)
            let texture = SKTexture(imageNamed: "WarJet_\(number)" )
            array.append(texture)
        }
        
        SKTexture.preload(array) {
            callback(array)
        }
        
        
        
    }
    
//    fileprivate func planeAnimationFillArray() { // Массивы для анимации из атласа
//
//        SKTextureAtlas.preloadTextureAtlases([SKTextureAtlas(named: "WarJetImg")]) {
//
//            self.lefTextureArrayAnimation = {
//
//                var array = [SKTexture]()
//                for i in stride(from: 13, through: 1, by: -1){
//
//                    let number = String(format: "%02d", i)
//                    let texture = SKTexture(imageNamed: "WarJet_\(number)" )
//                    array.append(texture)
//
//                }
//
//                SKTexture.preload(array, withCompletionHandler: {
//                    print("preload is done")
//                })
//                return array
//
//            }()
//
//            self.rightTextureArrayAnimation = {
//
//                var array = [SKTexture]()
//                for i in stride(from: 13, through: 25, by: 1){
//
//                    let number = String(format: "%02d", i)
//                    let texture = SKTexture(imageNamed: "WarJet_\(number)" )
//                    array.append(texture)
//
//                }
//
//                SKTexture.preload(array, withCompletionHandler: {
//                    print("preload is done")
//                })
//                return array
//
//            }()
//
//            self.forwardTextureArrayAnimation = {
//
//                var array = [SKTexture]()
//                for i in stride(from: 13, to: 13, by: 1){
//                    let number = String(format: "%02d", i)
//                    let texture = SKTexture(imageNamed: "WarJet_\(number)" )
//                    array.append(texture)
//                }
//
//
//
//
//
//                SKTexture.preload(array, withCompletionHandler: {
//                    print("preload is done")
//                })
//                return array
//
//            }()
//
//
//
//
//
//
//
//        }
//
//
//
//
//
//
//    }
    
    
}
