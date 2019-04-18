//
//  CustomViewController.swift
//  ReusableDemo iOS
//
//  This code is under the MIT License (MIT)
//
//  Created by Felipe Silva on 18/04/19.
//  Copyright © 2019 AliSoftware. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  @IBAction func present(_ sender: UIButton) {
    let viewController = SimpleViewController.instantiate()
    present(viewController, animated: true, completion: nil)
  }
  

}
