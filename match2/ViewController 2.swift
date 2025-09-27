//
//  ViewController 2.swift
//  match2
//
//  Created by Allan Auezkhan on 04.09.2025.
//


import UIKit

class ViewController: UIViewController {
    
    // MARK: - Game Properties
    
    var images = ["1","2","3","4","5","6","7","8","1","2","3","4","5","6","7","8"]
    var state = [Int](repeating: 0, count: 16) // 0 = hidden, 1 = flipped, 2 = matched
    var isActive = false
    var firstFlippedIndex: Int?
    
    // MARK: - Timer
    
    var gameTimer: Timer?
    var secondsElapsed = 0
    
    @IBOutlet weak var timerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        images.shuffle()
        startGameTimer()
    }
    
    func startGameTimer() {
        gameTimer?.invalidate()
        secondsElapsed = 0
        timerLabel.text = "Time: 0s"
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(updateTimer),
                                         userInfo: nil,
                                         repeats: true)
    }
    
    @objc func updateTimer() {
        secondsElapsed += 1
        timerLabel.text = "Time: \(secondsElapsed)s"
    }
    
    // MARK: - Game Logic
    
    @IBAction func game(_ sender: UIButton) {
        let index = sender.tag - 1
        
        if state[index] != 0 || isActive {
            return
        }
        
        sender.setBackgroundImage(UIImage(named: images[index]), for: .normal)
        sender.backgroundColor = UIColor.clear
        state[index] = 1
        
        if firstFlippedIndex == nil {
            // First card flipped
            firstFlippedIndex = index
        } else {
            // Second card flipped
            isActive = true
            let secondFlippedIndex = index
            
            if images[firstFlippedIndex!] == images[secondFlippedIndex] {
                // Match found
                state[firstFlippedIndex!] = 2
                state[secondFlippedIndex] = 2
                isActive = false
                firstFlippedIndex = nil
                
                // Check if all matched
                if state.allSatisfy({ $0 == 2 }) {
                    gameTimer?.invalidate()
                    showGameOverAlert()
                }
            } else {
                // No match – flip back after delay
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                    self.state[self.firstFlippedIndex!] = 0
                    self.state[secondFlippedIndex] = 0
                    
                    if let button1 = self.view.viewWithTag(self.firstFlippedIndex! + 1) as? UIButton {
                        button1.setBackgroundImage(nil, for: .normal)
                        button1.backgroundColor = UIColor.systemBlue
                    }
                    
                    if let button2 = self.view.viewWithTag(secondFlippedIndex + 1) as? UIButton {
                        button2.setBackgroundImage(nil, for: .normal)
                        button2.backgroundColor = UIColor.systemBlue
                    }
                    
                    self.isActive = false
                    self.firstFlippedIndex = nil
                    
                    
                    
                }
            }
        }
    }
    
    // MARK: - Game Completion
    
    func showGameOverAlert() {
        let alert = UIAlertController(title: "Congratulations!",
                                      message: "You matched all the cards in \(secondsElapsed) seconds!",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { _ in
            self.restartGame()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func restartGame() {
        images.shuffle()
        state = [Int](repeating: 0, count: 16)
        firstFlippedIndex = nil
        isActive = false
        secondsElapsed = 0
        timerLabel.text = "Time: 0s"
        startGameTimer()
        
        for i in 1...16 {
            if let button = view.viewWithTag(i) as? UIButton {
                button.setBackgroundImage(nil, for: .normal)
                button.backgroundColor = UIColor.systemBlue // Or use a card back image
            }
        }
    }
}
