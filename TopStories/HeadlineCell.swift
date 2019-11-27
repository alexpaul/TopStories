//
//  HeadlineCell.swift
//  TopStories
//
//  Created by Alex Paul on 11/25/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class HeadlineCell: UITableViewCell {


  @IBOutlet weak var headlineImageView: UIImageView!
  @IBOutlet weak var headlineTitleLabel: UILabel!
  @IBOutlet weak var bylineLabel: UILabel!
  
  // add a corner radius on a view we need to access the layer.cornerRadius property
  // override the layoutSubviews() method
  // layoutSubviews() gets called when the constraints and the view is getting presents in its superview
  override func layoutSubviews() {
    super.layoutSubviews() // implements any parents setup code
    
    // change the cornerRadius of the imageView's layer
    headlineImageView.layer.cornerRadius = 4 // CGFloat
  }
  
  func configureCell(for headline: NewsHeadline) {
    headlineTitleLabel.text = headline.title
    bylineLabel.text = headline.byline
    
    // let's get image
    if let thumbImage = headline.thumbImage {
      
      // memory mangement (ARC) - we need to handle retain cycles here
      // we can archieve this by using a capture list
      // e.g [unowned self] or [weak self]....more on this later....more on this later
      
      //=========================================================
      // *******weak vs unowned - big topic at interviews*******
      //=========================================================
      
      ImageClient.fetchImage(for: thumbImage.url) { [unowned self] (result) in
        switch result {
        case .success(let image):
          // UPDATE ANY UI ELEMENTS ON THE MAIN THREAD
          DispatchQueue.main.async {
            // UI updates go here
            self.headlineImageView.image = image
          }
          
        case .failure(let error):
          print("configureCell image error - \(error)")
        }
      }
      
    }
    
  }

}
