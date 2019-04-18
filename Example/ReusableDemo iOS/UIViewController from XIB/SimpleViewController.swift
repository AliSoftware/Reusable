//
//  SimpleViewController.swift
//  ReusableDemo iOS
//
//  Created by Vortigo Soluções em Mobilidade on 18/04/19.
//  Copyright © 2019 AliSoftware. All rights reserved.
//

import UIKit
import Reusable

final class SimpleViewController: UIViewController, NibBased {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func close(_ sender: UIButton) {
      self.dismiss(animated: true, completion: nil)
    }
    
}
