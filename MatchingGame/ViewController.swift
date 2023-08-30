//
//  ViewController.swift
//  MatchingGame
//
//  Created by Nuradil Serik on 28.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var count = 0
    var arrayImages:[String] = ["1", "2", "3", "4", "5", "6", "7", "8", "1", "2", "3", "4", "5", "6", "7", "8"]
    var winState:[[Int]] = []
    var state: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayImages.shuffle()
        winState.removeAll()
        for i in 0..<16{
            for j in 0..<16{
                if arrayImages[i] == arrayImages[j] && i != j{
                    winState.append([i,j])
                }
            }
        }
        
    }
    
    
    
    @IBAction func game(_ sender: UIButton) {
        
        print(winState)
        if state[sender.tag - 1] != 0 && count == 2 {
            return
        }
        
        count += 1
        
        print(state)
        
        var countToReset = 0
        var counter = 0
        
        state[sender.tag - 1] = 1
        print(state)
        
        sender.setBackgroundImage(UIImage(named: arrayImages[sender.tag - 1]), for: .normal)
        
        for i in 0..<16{
            if state[i] == 1 {
                countToReset += 1
            }
            if state[i] == 2{
                counter += 1
                print(counter)
            }
        }
        
        for winArray in winState{
            if state[winArray[0]] == 1 && state[winArray[1]] == 1{
                state[winArray[0]] = 2
                state[winArray[1]] = 2
            }
        }
        
        if countToReset == 2{
            _ = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false){
                timer in
                self.clear()
            }
            
        }
        
        if counter == 15{
            let alert = UIAlertController(title: "You won!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{
                UIAlertAction in
                self.clearAll()
            }))
            
            present(alert, animated: true, completion: nil)
            
        }
        
        
    }
    
    func clear(){
        for i in 0..<16{
            if state[i] == 1{
                let button = view.viewWithTag(i+1) as! UIButton
                button.setBackgroundImage(nil , for: .normal)
                state[i] = 0
                count = 0
            }
        }
    }
    
    func clearAll(){
        for i in 0..<16{
            let button = view.viewWithTag(i+1) as! UIButton
            button.setBackgroundImage(nil, for: .normal)
            state[i] = 0
        }
    }
    
}

