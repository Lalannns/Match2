//
//  ViewController.swift
//  Match2
//
//  Created by Allan Auezkhan on 29.09.2025.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var moveLabel: UILabel!
    
    @IBOutlet weak var restartButton: UIButton!
    
    
    
    var images = ["1", "2", "3", "4", "5", "6", "7", "8", "1", "2", "3", "4", "5", "6", "7", "8"]
    
    var state = [Int](repeating: 0, count: 16)
    
    var winState = [[0,8], [1,9], [2,10], [3,11], [4,12], [5,13], [6,14], [7,15]]
    
    
    
    var isActive = false
    var moves = 0
    var timer: Timer?
    var seconds = 0
    var matchedPairs = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func game(_ sender: UIButton) {
        
        if state[sender.tag - 1] != 0 || isActive { return
        }

        sender.setBackgroundImage(UIImage(named:images[sender.tag - 1]), for: .normal)
        sender.backgroundColor = UIColor.white
        state[sender.tag - 1] = 1

        let selectedIndices = state.enumerated().filter { $0.element == 1 }.map { $0.offset }

        if selectedIndices.count == 2 {
            isActive = true
            moves += 1
            moveLabel.text = "Moves: \(moves)"

            let first = selectedIndices[0]
            let second = selectedIndices[1]

            if images[first] == images[second] {
                state[first] = 2
                state[second] = 2
                matchedPairs += 1
                isActive = false

                checkGameFinished()
            }

            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(clear), userInfo: nil, repeats: false)
        }
    }
        
        
        
    @objc func clear() {
        for i in 0...15 {
            if state[i] == 1 {
                state[i] = 0
                let button = view.viewWithTag(i + 1) as? UIButton
                button?.setBackgroundImage(nil, for: .normal)
                button?.backgroundColor = UIColor.systemMint
                
            }
            
        }
            isActive = false
        }
    
    func checkGameFinished() {
            if matchedPairs == 8 {
                timer?.invalidate()
                let timeString = formatTime(seconds)
                let alert = UIAlertController(
                    title: "Congratulations!",
                    message: "You completed the game in \(timeString) with \(moves) moves!",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "Play Again", style: .default) { _ in
                    self.startNewGame()
                })
                present(alert, animated: true)
            }
        }

    
    func startTimer() {
           timer?.invalidate()
           seconds = 0
           timerLabel.text = "Time: 00:00"
           timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
       }

       @objc func updateTimer() {
           seconds += 1
           timerLabel.text = "Time: \(formatTime(seconds))"
       }

       func formatTime(_ seconds: Int) -> String {
           let minutes = seconds / 60
           let secs = seconds % 60
           return String(format: "%02d:%02d", minutes, secs)
       }

       // MARK: - Restart

    @IBAction func restartGame(_ sender: Any) {
        startNewGame()
    }
    

       func startNewGame() {
           // Shuffle the cards
           images.shuffle()
           state = [Int](repeating: 0, count: 16)
           matchedPairs = 0
           moves = 0
           moveLabel.text = "Moves: 0"

           // Reset buttons
           for i in 1...16 {
               if let button = view.viewWithTag(i) as? UIButton {
                   button.setBackgroundImage(nil, for: .normal)
                   button.backgroundColor = UIColor.systemMint
               }
           }

           // Start timer
           startTimer()
       }
        
        
    }
    

