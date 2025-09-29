//
//  ViewController.swift
//  Match2
//
//  Created by Allan Auezkhan on 29.09.2025.
//

import UIKit

class ViewController: UIViewController {

    var images = ["1", "2", "3", "4", "5", "6", "7", "8", "1", "2", "3", "4", "5", "6", "7", "8"]
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func game(_ sender: UIButton) {
        
        print(sender.tag)
        
        sender.setBackgroundImage(UIImage(named: images[sender.tag - 1]), for: .normal)
        
        sender.backgroundColor = UIColor.white
        
    }
    
}

