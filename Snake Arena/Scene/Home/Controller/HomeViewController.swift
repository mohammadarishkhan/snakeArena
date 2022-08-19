//
//  HomeViewController.swift
//  Snake Arena
//
//  Created by Arish Khan on 08/04/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var collections: [UIView]!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    
    enum Direction: Int {
        case left
        case top
        case right
        case bottom
    }
    
    var startPoint: Int = 5
    var size: Int = 5
    let stackWidth = 39
    let stackHeight = 40
    let stackLastElement = 1560
    var currentPreyPosition: Int = 100
    var speed = 0.5
    var timer: Timer?
    var turningPoint: Int = 0
    private var direction: Direction = .right
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        restartButton.isHidden = true
        genratePreyPosition()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: speed, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func moveSnake() {
        let tail = direction == .right ? startPoint - size :
        direction == .bottom ? startPoint - (stackWidth * size) :
        direction == .left ? startPoint + size : startPoint + (stackWidth * (size - 1))
        
        
        switch direction {
        case .left:
            var currentValue = startPoint
            while currentValue < tail && currentValue >= 0 && currentValue <= stackLastElement {
                collections[currentValue].backgroundColor = .black
                currentValue += 1
            }
        case .top:
            var currentValue = startPoint - 1
            while currentValue <= tail && currentValue >= 0 && currentValue <= stackLastElement {
                collections[currentValue].backgroundColor = .black
                currentValue = currentValue + stackWidth
            }
        case .right:
            var currentValue = startPoint - 1
            while currentValue >= tail && currentValue >= 0 && currentValue <= stackLastElement {
                collections[currentValue].backgroundColor = .black
                currentValue -= 1
            }
        case .bottom:
            var currentValue = startPoint - 1
            while currentValue >= tail && currentValue >= 0 && currentValue <= stackLastElement {
                collections[currentValue].backgroundColor = .black
                currentValue = currentValue - stackWidth
            }
        }
    }
    
    @objc func timerAction() {
        clearAll()
        switch direction {
        case .left:
            startPoint -= 1
        case .top:
            startPoint -= stackWidth
        case .right:
            startPoint += 1
        case .bottom:
            startPoint += stackWidth
        }
        
        moveSnake()
        
        if startPoint == (currentPreyPosition + 1) {
            self.size += 1
            if size == 10 {
                speed = 0.4
            }else if size == 10 {
                speed = 0.3
            }else if size == 15{
                speed = 0.2
            }else if size == 20{
                speed = 0.1
            }
            genratePreyPosition()
        }
        guard !isBorderTouched() else { return }
        
    }
    
    func clearAll() {
        for collectionInfo in collections.enumerated() {
            if collectionInfo.offset != currentPreyPosition {
                collectionInfo.element.backgroundColor = .white
            }
        }
    }
    
    func isBorderTouched() -> Bool {
        if startPoint == stackWidth + 1
            || startPoint == (stackWidth * 2) + 1
            || startPoint == (stackWidth * 3) + 1
            || startPoint == (stackWidth * 4) + 1
            || startPoint == (stackWidth * 5) + 1
            || startPoint == (stackWidth * 6) + 1
            || startPoint == (stackWidth * 7) + 1
            || startPoint == (stackWidth * 8) + 1
            || startPoint == (stackWidth * 9) + 1
            || startPoint == (stackWidth * 10) + 1
            || startPoint == (stackWidth * 11) + 1
            || startPoint == (stackWidth * 12) + 1
            || startPoint == (stackWidth * 13) + 1
            || startPoint == (stackWidth * 14) + 1
            || startPoint == (stackWidth * 15) + 1
            || startPoint == (stackWidth * 16) + 1
            || startPoint == (stackWidth * 17) + 1
            || startPoint == (stackWidth * 18) + 1
            || startPoint == (stackWidth * 19) + 1
            || startPoint == (stackWidth * 20) + 1
            || startPoint == (stackWidth * 21) + 1
            || startPoint == (stackWidth * 22) + 1
            || startPoint == (stackWidth * 23) + 1
            || startPoint == (stackWidth * 24) + 1
            || startPoint == (stackWidth * 25) + 1
            || startPoint == (stackWidth * 26) + 1
            || startPoint == (stackWidth * 27) + 1
            || startPoint == (stackWidth * 28) + 1
            || startPoint == (stackWidth * 29) + 1
            || startPoint == (stackWidth * 30) + 1
            || startPoint == (stackWidth * 31) + 1
            || startPoint == (stackWidth * 32) + 1
            || startPoint == (stackWidth * 33) + 1
            || startPoint == (stackWidth * 34) + 1
            || startPoint == (stackWidth * 35) + 1
            || startPoint == (stackWidth * 36) + 1
            || startPoint == (stackWidth * 37) + 1
            || startPoint == (stackWidth * 38) + 1
            || startPoint == (stackWidth * 39) + 1
            || startPoint == (stackWidth * 40) + 1
            || startPoint > stackLastElement
            || startPoint < 0 {
            stopTimer()
            showAlert("Game Over")
            self.topButton.isHidden = true
            self.rightButton.isHidden = true
            self.leftButton.isHidden = true
            self.bottomButton.isHidden = true
            self.restartButton.isHidden = false
            currentPreyPosition = -1
            clearAll()
            return true
        }
        
        return false
    }
    
    func restart() {
        self.startPoint = 5
        self.size = 5
        self.turningPoint = 0
        self.direction = .right
        genratePreyPosition()
        startTimer()
        
    }
    
    func genratePreyPosition() {
        self.currentPreyPosition = Int.random(in: 0..<stackLastElement)
        collections[currentPreyPosition].backgroundColor = .red
    }
}

private extension HomeViewController {
    @IBAction func leftButtonAction () {
        guard self.direction == .top || self.direction == .bottom else { return }
        stopTimer()
        turningPoint = startPoint
        self.direction = .left
        startTimer()
        
    }
    @IBAction func topButtonAction () {
        guard self.direction == .left || self.direction == .right else { return }
        stopTimer()
        turningPoint = startPoint
        self.direction = .top
        startTimer()
        
    }
    @IBAction func rightButtonAction () {
        guard self.direction == .top || self.direction == .bottom else { return }
        stopTimer()
        turningPoint = startPoint
        self.direction = .right
        startTimer()
    }
    @IBAction func bottomButtonAction () {
        guard self.direction == .left || self.direction == .right else { return }
        stopTimer()
        turningPoint = startPoint
        self.direction = .bottom
        startTimer()
    }
    @IBAction func restartButtonAction () {
        restart()
        self.restartButton.isHidden = true
        self.topButton.isHidden = false
        self.rightButton.isHidden = false
        self.leftButton.isHidden = false
        self.bottomButton.isHidden = false
        
    }
    
}
