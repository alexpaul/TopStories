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
  }

}
