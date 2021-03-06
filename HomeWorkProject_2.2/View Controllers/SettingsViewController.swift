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
    
    // MARK: - Publick properties
    
    var color: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = colorView.frame.height / 10
        changingInterfaceProperties(with: color)
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IB Actions
    
    @IBAction func coloringViewWithSlider(_ sender: UISlider) {
        switch sender {
        case redSlider:
            redValueLabel.text = string(from: sender)
            redTextField.text = string(from: sender)
        case greenSlider:
            greenValueLabel.text = string(from: sender)
            greenTextField.text = string(from: sender)
        default:
            blueValueLabel.text = string(from: sender)
            blueTextField.text = string(from: sender)
        }
        coloringView()
    }
    
    @IBAction func setNewColorWithDoneButton() {
        delegate.setNewColor(for: colorView.backgroundColor!)
        dismiss(animated: true)
    }
    
    // MARK: - Private methods
    
    private func changingInterfaceProperties(with color: UIColor) {
        let colors = CIColor(color: color)
        
        redSlider.value = Float(colors.red)
        greenSlider.value = Float(colors.green)
        blueSlider.value = Float(colors.blue)
        
        redValueLabel.text = string(from: colors.red)
        greenValueLabel.text = string(from: colors.green)
        blueValueLabel.text = string(from: colors.blue)
        
        getValueForTextFields()
        
        coloringView()
    }
    
    private func getValueForTextFields() {
        redTextField.text = string(from: redSlider)
        greenTextField.text = string(from: greenSlider)
        blueTextField.text = string(from: blueSlider)
    }
    
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
    
    private func getValue(for textField: UITextField) {
        switch textField {
        case redTextField:
            textField.text = string(from: redSlider)
        case greenTextField:
            textField.text = string(from: greenSlider)
        default:
            textField.text = string(from: blueSlider)
        }
    }
    
    @objc private func doneButtonPressed() {
        view.endEditing(true)
        getValueForTextFields()
    }
}

// MARK: - Extentions

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(doneButtonPressed))
        
        toolBar.setItems([flexSpace, doneButton], animated: false)
        textField.inputAccessoryView = toolBar
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if let number = Float(text) {
            if number >= 0 && number <= 1 {
                switch textField {
                case redTextField:
                    redSlider.setValue(number, animated: true)
                    redValueLabel.text = string(from: redSlider)
                case greenTextField:
                    greenSlider.setValue(number, animated: true)
                    greenValueLabel.text = string(from: greenSlider)
                default:
                    blueSlider.setValue(number, animated: true)
                    blueValueLabel.text = string(from: blueSlider)
                }
                coloringView()
            } else {
                showAlert(title: "Oops", massage: "Enter value from 0 to 1")
            }
        } else if text != "" {
            showAlert(title: "Oops", massage: "Enter numbers of type 0.00")
        }
        getValue(for: textField)
    }
}

extension SettingsViewController {
    private func showAlert(title: String, massage: String) {
        let alert = UIAlertController(title: title,
                                      message: massage,
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true)
    }
}

