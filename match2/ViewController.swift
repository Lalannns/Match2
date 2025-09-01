//
//  ViewController.swift
//  match2
//
//  Created by Allan Auezkhan on 08.06.2025.
//

import UIKit

class ViewController: UIViewController {
    
    var images = ["1","2","3","4","5","6","7","8","1","2","3","4","5","6","7","8"]
    
    var state = [Int](repeating: 0, count: 16)
    
    var WinState = [[0,8], [1,9], [2,10], [3,11], [4,12], [5,13], [6,14], [7,15]]
    
    var isActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGameTimer()
    }
    var gameTimer: Timer?
    var secondsElapsed = 0
    @IBOutlet weak var timerLabel: UILabel!
    
    
    @objc func updateTimer() {
        secondsElapsed += 1
        timerLabel.text = "Time: \(secondsElapsed)s"
    }
    
    func startGameTimer() {
        gameTimer?.invalidate() // stop previous timer if any
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    var firstFlippedIndex: Int?
    
    
    
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
}

