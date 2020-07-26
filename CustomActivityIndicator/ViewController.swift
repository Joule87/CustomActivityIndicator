//
//  ViewController.swift
//  CustomActivityIndicator
//
//  Created by jucollado on 6/19/20.
//  Copyright © 2020 jucollado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var spinner: GradientSpinner!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))

    }
    
    @objc func viewTapped() {
        spinner.toggleSpinner()
    }
    
}

