//
//  InfoDetailViewController.swift
//  ReusableDemo
//
//  Created by Olivier Halligon on 10/07/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import Reusable
import UIKit

final class InfoDetailViewController: UIViewController, StoryboardSceneBased {
  static let sceneStoryboard = UIStoryboard(name: "InfoViewController", bundle: nil)

  @IBOutlet private var detailsLabel: UILabel!
  private var detailsText: String?

  func setDetails(_ text: String) {
    detailsText = text
    detailsLabel?.text = text
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    detailsLabel.text = detailsText
  }

  @IBAction func openNibBasedVC(_: Any) {
    let viewController = MyNibBasedViewController.instantiate()
    present(viewController, animated: true)
  }

  @IBAction func closeAction(_: UIButton) {
    presentingViewController?.dismiss(animated: true, completion: nil)
  }
}
