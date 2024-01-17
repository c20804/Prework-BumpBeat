//
//  ViewController.swift
//  BumpBeat
//
//  Created by Jean Chu on 1/16/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var kickButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    var count = 0
    var timer: Timer?
    var elapsedTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        kickButton.isEnabled = false
        messageLabel.isHidden = true
    }

    @IBAction func startPressed(_ sender: UIButton) {

        if sender.titleLabel?.text == "Start" || sender.titleLabel?.text == "Restart"{
            count = 0
            elapsedTime = 0
            updateTimerLabel()
            countLabel.text = "Count: \(count)"
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
            sender.setTitle("Stop", for: .normal)
            kickButton.isEnabled = true
            messageLabel.isHidden = true
            self.view.backgroundColor = #colorLiteral(red: 0.5781865716, green: 0.7258599997, blue: 0.8131495118, alpha: 1)
        } else if sender.titleLabel?.text == "Stop" {
            timer?.invalidate()
            sender.setTitle("Restart", for: .normal)
            kickButton.isEnabled = false
            
            if count > 10{
                let message = "Great! Baby is active!"
                showMessage(with: message)
                self.view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            } else {
                let message = "Observation is suggested.\nAim for at least 10 kicks\nwithin a 2-hour period."
                showMessage(with: message)
                self.view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
            }
            
        }
    }
    @objc func updateTimer(){
        elapsedTime += 1
        updateTimerLabel()
    }
    
    func showMessage(with message: String){
        messageLabel.text = message
        messageLabel.isHidden = false
    }
    
    func updateTimerLabel() {
        let seconds = elapsedTime % 60
        let minutes = (elapsedTime / 60) % 60
        let hours = elapsedTime / 3600
        timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    @IBAction func kickPressed(_ sender: UIButton) {
        count += 1
        countLabel.text = "Count: \(count)"
    }
}

