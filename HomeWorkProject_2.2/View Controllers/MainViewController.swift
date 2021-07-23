//
//  ColorViewController.swift
//  HomeWorkProject_2.2
//
//  Created by Максим on 23.07.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewColor(for color: UIColor)
}

class MainViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC =
                segue.destination as? SettingsViewController else { return }
        settingsVC.color = view.backgroundColor
        settingsVC.delegate = self
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func setNewColor(for color: UIColor) {
        view.backgroundColor = color
    }
}

