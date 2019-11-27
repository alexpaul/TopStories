//
//  ImageClient.swift
//  TopStories
//
//  Created by Alex Paul on 11/26/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

struct ImageClient {
  
  // takes in a url string uses a completion handler to capture
  // processed image from the url source e.g "https://.....jpg"
  
  // we cannot simply return an image from this function
  // why?
  // because URLSession performs an asynchronous network call,
  // which means the call relies on the network and is done on the background, not performed instantaneously
  static func fetchImage(for urlString: String,
                         completion: @escaping (Result<UIImage?, Error>) -> ()) {
    
    // validate it is a valid url
    guard let url = URL(string: urlString) else {
      print("bad url \(urlString)")
      // TODO: add enum error
      return
    }
    
    // create a data task using the URLSession() class
    let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      // check if an error exist
      if let error = error {
        print("error: \(error)")
        // TODO: add enum error
        return
      }
      
      // TODO: check for valid status code of 200...299
      
      // TODO: check for valid mime type of image/jpeg
      
      if let data = data {
        // use data to create an image
        let image = UIImage(data: data)
        
        // capture result of image
        completion(.success(image))
      }
    }
    dataTask.resume() // executes network request
    
  }
  
}
