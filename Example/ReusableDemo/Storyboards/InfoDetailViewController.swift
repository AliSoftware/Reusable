//
//  InfoDetailViewController.swift
//  ReusableDemo
//
//  Created by Olivier Halligon on 10/07/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import UIKit
import Reusable

final class InfoDetailViewController: UIViewController, StoryboardSceneBased {
  static let storyboard = UIStoryboard(name: "InfoViewController", bundle: nil)

  @IBOutlet private weak var detailsLabel: UILabel!
  private var detailsText: String?

  func setDetails(text: String) {
    detailsText = text
    detailsLabel?.text = text
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    detailsLabel.text = detailsText
  }

  @IBAction func closeAction(sender: UIButton) {
    self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
  }
}
