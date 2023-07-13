//
//  ViewController.swift
//  Bools-Eye
//
//  Created by Aren Musayelyan on 13.07.23.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var sliderButtonAndLabelView: UIView!
    @IBOutlet weak var buttonsAndLabelsView: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    // MARK: - Properties
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = lroundf(slider.value)
        setupUI()
        startNewRound()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        [backgroundView, sliderButtonAndLabelView, buttonsAndLabelsView].forEach { view in
            view.layer.masksToBounds = true
            view.layer.cornerRadius = 10
        }
        
        buttonsAndLabelsView.layer.cornerRadius = buttonsAndLabelsView.frame.height / 2
    }
    
    // MARK: - Game Logic
    
    private func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabel()
    }
    
    private func updateLabel() {
        targetLabel.text = "Put the Bullseye as Close as You Can to: \(targetValue)"
        scoreLabel.text = "Score: \(score)"
        roundLabel.text = "Round: \(round)"
    }
    
    // MARK: - Actions
    
    @IBAction func startNewGameAction(_ sender: Any) {
        score = 0
        round = 0
        startNewRound()
    }
    
    @IBAction func sliderMovedAction(_ sender: Any) {
        print("The value of the slider now is: \(slider.value)")
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func hitMeAction(_ sender: Any) {
        let difference = abs(currentValue - targetValue)
        var points = 0
        var title = ""
        
        if difference == 0 {
            title = "Perfect!"
            points = 100
        } else if difference < 5 {
            title = "Almost there!"
            points = 50
        } else {
            title = "Try HARDER!"
        }
        
        score += points
        
        let message = "You have scored \(points) points, difference: \(difference) points."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Awesome", style: .default) { [weak self] _ in
            self?.startNewRound()
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @IBAction func infoButtonAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Info", message: "This is an informational alert.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        
        present(alertController, animated: true)
    }
}
