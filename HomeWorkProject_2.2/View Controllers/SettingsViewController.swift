//
//  ViewController.swift
//  HomeWorkProject_2.2
//
//  Created by Максим on 09.07.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    
    var color: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    let toolBar = UIToolbar()
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.backgroundColor = color
        colorView.layer.cornerRadius = colorView.frame.height / 10
        changingInterfaceProperties(with: color)
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        keyboardBarSettings()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
        redTextField.text = redValueLabel.text
        greenTextField.text = greenValueLabel.text
        blueTextField.text = blueValueLabel.text
    }
    
    // MARK: - IB Actions
    
    @IBAction func coloringViewWithSlider(_ sender: UISlider) {
        switch sender {
        case redSlider:
            redValueLabel.text = string(from: redSlider)
            redTextField.text = redValueLabel.text
        case greenSlider:
            greenValueLabel.text = string(from: greenSlider)
            greenTextField.text = greenValueLabel.text
        default:
            blueValueLabel.text = string(from: blueSlider)
            blueTextField.text = blueValueLabel.text
        }
        coloringView()
    }
    
    @IBAction func setNewColorWithDoneButton() {
        delegate.setNewColor(for: colorView.backgroundColor!)
        dismiss(animated: true)
    }
    // MARK: - Private methods
    
    private func coloringView() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func string(from slider: CGFloat) -> String {
        String(format: "%.2f", slider)
    }
    
    private func gettingColor(for color: UIColor) -> [CGFloat] {
        var colors: [CGFloat] = []
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        colors.append(red)
        colors.append(green)
        colors.append(blue)
        colors.append(alpha)
        
        return colors
    }
    
    private func changingInterfaceProperties(with color: UIColor) {
        let colors = gettingColor(for: color)
        
        redSlider.value = Float(colors[0])
        greenSlider.value = Float(colors[1])
        blueSlider.value = Float(colors[2])
        
        redValueLabel.text = string(from: colors[0])
        greenValueLabel.text = string(from: colors[1])
        blueValueLabel.text = string(from: colors[2])
        
        redTextField.text = redValueLabel.text
        greenTextField.text = greenValueLabel.text
        blueTextField.text = blueValueLabel.text
    }
    
    private func keyboardBarSettings() {
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .done, target: self, action: .none)
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        redTextField.inputAccessoryView = toolBar
        greenTextField.inputAccessoryView = toolBar
        blueTextField.inputAccessoryView = toolBar
        
        coloringView()
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        switch textField {
        case redTextField:
            guard let redValue = Float(text) else { return }
            redSlider.value = redValue
            redValueLabel.text = string(from: redSlider)
        case greenTextField:
            guard let greenValue = Float(text) else { return }
            greenSlider.value = greenValue
            greenValueLabel.text = string(from: greenSlider)
        default:
            guard let blueValue = Float(text) else { return }
            blueSlider.value = blueValue
            blueValueLabel.text = string(from: blueSlider)
        }
        coloringView()
    }
}



