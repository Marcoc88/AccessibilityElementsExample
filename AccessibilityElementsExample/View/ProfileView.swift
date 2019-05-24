//
//  ProfileView.swift
//  AccessibilityElementsExample
//
//  Created by Marco Contino on 4/14/19.
//  Copyright © 2019 Marco Contino. All rights reserved.
//

import UIKit

/**
  This view is a combination of labels and a button that make up a user's profile
*/
class ProfileView: UIView {
  
  /// The user's profile. When the profile is set each label text gets set
  var profile: Profile? {
    didSet {
      name.text = profile?.name
      job.text = profile?.job
      location.text = profile?.location
      favoriteShow.text = profile?.favoriteShow
      favoriteFood.text = profile?.favoriteFood
      
      // Reset our cached elements to nil when we change the model so that accessibilityElements are recomputed
      cachedAccessiblityElements = nil
    }
  }
  
  @IBOutlet private weak var name: UILabel!
  @IBOutlet private weak var locationTitle: UILabel!
  @IBOutlet private weak var location: UILabel!
  @IBOutlet private weak var jobTitle: UILabel!
  @IBOutlet private weak var job: UILabel!
  @IBOutlet private weak var favoriteShowTitle: UILabel!
  @IBOutlet private weak var favoriteShow: UILabel!
  @IBOutlet private weak var favoriteFoodTitle: UILabel!
  @IBOutlet private weak var favoriteFood: UILabel!
  @IBOutlet private weak var viewProfileButton: UIButton!
  
  @IBAction private func viewProfile(_ sender: UIButton) {
    // show profile picture when tapped
  }
  
  // MARK: - Accessibility Logic
  
  /*
   VoiceOver reads out the array of objects returned from accessibilityElements when a user swipes through the app.
   We cache our array of computed accessibilityElements and reset the cached array whenever the profile gets set so that accessibility elements can be recomputed.
   */
  
  /// The cached array of computed accessibility elements
  private var cachedAccessiblityElements: [Any]?
  override var accessibilityElements: [Any]? {
    set {
      cachedAccessiblityElements = newValue
    }
    get {
      // Return the acessibility elements if we've already created them
      if let cachedAccessiblityElements = cachedAccessiblityElements {
        return cachedAccessiblityElements
      }
      var elements = [UIAccessibilityElement]()
      
      /*
       Create a custom accessibility element for name and update the accessiblityLabel so that it is more clear to the
       user that the user is viewing a profile
       */
      if let name = name.text {
        let nameAccessibilityElement = UIAccessibilityElement(accessibilityContainer: self)
        nameAccessibilityElement.accessibilityLabel = "\(name)'s Profile"
        
        /*
         This tells VoiceOver where the object should be onscreen. As the user
         touches around with their finger, we can determine if an element is below
         their finger
         */
        nameAccessibilityElement.accessibilityFrameInContainerSpace = self.name.frame
        elements.append(nameAccessibilityElement)
      }
      
      /*
       create a custom accessiblity element composed of the title and content label so that VoiceOver reads them as a unified element.
       This ensures that the content is not read by VoiceOver without the context of the label
       */
      if let locationTitle = locationTitle.text, let location = location.text {
        let locationAccessibilityElement = UIAccessibilityElement(accessibilityContainer: self)
        locationAccessibilityElement.accessibilityLabel = locationTitle + " " + location
        locationAccessibilityElement.accessibilityFrameInContainerSpace = self.locationTitle.frame.union(self.location.frame)
        elements.append(locationAccessibilityElement)
      }
      
      if let jobTitle = jobTitle.text, let job = job.text {
        let jobAccessiblityElement = UIAccessibilityElement(accessibilityContainer: self)
        jobAccessiblityElement.accessibilityLabel = jobTitle + " " + job
        jobAccessiblityElement.accessibilityFrameInContainerSpace = self.jobTitle.frame.union(self.job.frame)
        elements.append(jobAccessiblityElement)
      }
      
      if let favoriteShowTitle = favoriteShowTitle.text, let favoriteShow = favoriteShow.text {
        let favoriteShowAccessibilityElement = UIAccessibilityElement(accessibilityContainer: self)
        favoriteShowAccessibilityElement.accessibilityLabel = favoriteShowTitle + favoriteShow
        favoriteShowAccessibilityElement.accessibilityFrameInContainerSpace = self.favoriteShowTitle.frame.union(self.favoriteShow.frame)
        elements.append(favoriteShowAccessibilityElement)
      }
      
      if let favoriteFoodTitle = favoriteFoodTitle.text, let favoriteFood = favoriteFood.text {
        let favoriteFoodAccessibilityElement = UIAccessibilityElement(accessibilityContainer: self)
        favoriteFoodAccessibilityElement.accessibilityLabel = favoriteFoodTitle + favoriteFood
        favoriteFoodAccessibilityElement.accessibilityFrameInContainerSpace = self.favoriteFoodTitle.frame.union(self.favoriteFood.frame)
        elements.append(favoriteFoodAccessibilityElement)
      }
      
      /*
       Create a custom accessiblity element for the button. Set the accessibilityTrait to button so that VoiceOver speaks "button"
       after reading the accessiblityLabel. Also set the acessibilityHint to remind the user to double tap to view the profile picture
       */
      let viewProfileButtonAccessibilityElement = UIAccessibilityElement(accessibilityContainer: self)
      viewProfileButtonAccessibilityElement.accessibilityLabel = "View Profile Picture"
      viewProfileButtonAccessibilityElement.accessibilityTraits = UIAccessibilityTraits.button
      viewProfileButtonAccessibilityElement.accessibilityHint = "Double tap to view"
      viewProfileButtonAccessibilityElement.accessibilityFrameInContainerSpace = self.viewProfileButton.frame
      elements.append(viewProfileButtonAccessibilityElement)
      
      cachedAccessiblityElements = elements
      return cachedAccessiblityElements
    }
  }
}
