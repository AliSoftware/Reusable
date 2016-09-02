//
//  InfoViewController.swift
//  ReusableDemo
//
//  Created by Olivier Halligon on 10/07/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import UIKit
import Reusable

final class InfoViewController: UIViewController, StoryboardBased {
  @IBOutlet private weak var infoLabel: UILabel!
  private var infoText: String?

  func setInfo(text: String) {
    infoText = text
    infoLabel?.text = text
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    infoLabel.text = infoText
  }

  @IBAction func closeAction(sender: UIButton) {
    self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
  }
}
