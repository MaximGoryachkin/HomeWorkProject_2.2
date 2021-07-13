//
//  ViewController.swift
//  HomeWorkProject_2.2
//
//  Created by Максим on 09.07.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = colorView.frame.height / 10
        
        coloringView()
    }
    
    // MARK: - IB Actions
    
    @IBAction func someAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            redValueLabel.text = String(format: "%.2f",
                                        redSlider.value)
        case greenSlider:
            greenValueLabel.text = String(format: "%.2f",
                                          greenSlider.value)
        default:
            blueValueLabel.text = String(format: "%.2f",
                                         blueSlider.value)
        }
        coloringView()
    }
    
    // MARK: - Private methods
    
    private func coloringView() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel:
                label.text = string(from: redSlider)
            case greenValueLabel:
                label.text = string(from: greenSlider)
            default:
                label.text = string(from: blueSlider)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}
