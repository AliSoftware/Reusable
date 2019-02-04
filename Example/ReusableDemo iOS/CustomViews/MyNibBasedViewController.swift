//
//  MyNibBasedViewController.swift
//  ReusableDemo iOS
//
//  Created by Bastian Kusserow on 03.02.19.
//  Copyright © 2019 AliSoftware. All rights reserved.
//

import Reusable
import UIKit

class MyNibBasedViewController: UIViewController, NibLoadable {
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }

  @IBAction func dismiss(_: Any) {
    presentingViewController?.dismiss(animated: true)
  }
}
