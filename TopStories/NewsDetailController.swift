//
//  NewsDetailController.swift
//  TopStories
//
//  Created by Alex Paul on 11/26/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class NewsDetailController: UIViewController {
  
  @IBOutlet weak var headlineImageView: UIImageView!
  @IBOutlet weak var headlineAbstractTextView: UITextView!
  @IBOutlet weak var bylineLabel: UILabel!
  
  var newsHeadline: NewsHeadline?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
  }
  
  func updateUI() {
    guard let headline = newsHeadline else {
      fatalError("newsHeadline is nil, verify prepare(for segue: )")
    }
    // TODO: set up image processing using URLSession() and DistpatchQueue.main.async{...}
    navigationItem.title = headline.title
    headlineAbstractTextView.text = headline.abstract
    bylineLabel.text = headline.byline
    
    // update image using superJumbo multimedia
    if let superJumboImage = headline.superJumbo {
      ImageClient.fetchImage(for: superJumboImage.url) { [unowned self] (result) in
        switch result {
        case .failure(let error):
          // TODO: use a UIAlertController() to indicate to the user something went wrong
          print("error: \(error)")
        case .success(let image):
          DispatchQueue.main.async {
            // TODO: UIActivityIndicator() .... shows the user an indicates as to
            // the progress of a download
            self.headlineImageView.image = image
          }
        }
      }
    }
  }
}
