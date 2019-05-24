//
//  AccessibilityTutorialViewController.swift
//  AccessibilityElementsExample
//
//  Created by Marco Contino on 4/14/19.
//  Copyright © 2019 Marco Contino. All rights reserved.
//

import UIKit

/**
 This view controller manages the displayed view and sets the profile data in our profileView
 */
class AccessibilityElementsExampleViewController: UIViewController {
  
  /// The profile view which contains our labels and button
  @IBOutlet private weak var profileView: ProfileView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadProfileData()
  }
  
  private func loadProfileData() {
    let profile = Profile.init(name: "Marco", job: "iOS Developer", location: "Philadelphia", favoriteShow: "The Office", favoriteFood: "Pizza")
    profileView.profile = profile
  }
}
