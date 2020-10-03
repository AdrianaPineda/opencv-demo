//
//  ViewController.swift
//  OpenCVDemo
//
//  Created by Adriana Pineda on 03/10/2020.
//  Copyright © 2020 Adriana Pineda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var openCVVersionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        openCVVersionLabel.text = OpenCVWrapper.openCVVersionString()
    }

    @IBAction func startButtonClicked(_: Any) {}
}
