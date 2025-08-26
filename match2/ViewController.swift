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
   


    
    @IBAction func game(_ sender: UIButton) {
        print(sender.tag)
        
        if state[sender.tag - 1] != 0 || isActive {
            return
        }
        
        sender.setBackgroundImage(UIImage(named: images[sender.tag - 1]), for: .normal)
        
        sender.backgroundColor = UIColor.clear
        
        state[sender.tag - 1] = 1
        
        var count = 0
        
        for item in state {
            if item == 1 {
                count += 1
            }
        }
        if count == 2 {
            isActive = true
            for WinArray in WinState {
            if state[WinArray[0]] == state[WinArray[1]]&&state[WinArray[1]] == 1{
                    state[WinArray[0]] == 2
                    state[WinArray[1]] == 2
                isActive = false 
                }
            }
            if isActive {
                Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(clear), userInfo: nil, repeats: false)
            }
        }
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        state = [Int](repeating: 0, count: 16)
        images.shuffle()
        for i in 1...16 {
            if let button = view.viewWithTag(i) as? UIButton {
                button.setBackgroundImage(nil, for: .normal)
                button.backgroundColor = UIColor.systemBlue
            }
        }
        isActive = false
        secondsElapsed = 0
        timerLabel.text = "Time: 0s"
        startGameTimer()
    }
    
  
   @objc func clear(){
       for i in 0..<16 {
           if state[i] == 1 {
        state[i] = 0
    if let button = view.viewWithTag(i + 1) as? UIButton {
        button.setBackgroundImage(nil, for: .normal)
        button.backgroundColor = UIColor.systemBlue
    }
        }
            }
           isActive = false
       }

}

