//
//  NewsHeadlne.swift
//  TopStories
//
//  Created by Alex Paul on 11/25/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

// top level JSON - HeadlineData.self because top level JSON is
// a dictionary
struct HeadlinesData: Codable {
  let results: [NewsHeadline] // "results" represents the JSON array of stories
}

struct NewsHeadline: Codable {
  let title: String
  let abstract: String
  let byline: String
}

extension HeadlinesData {
  // parse the "topStoriesTechnology.json" into an
  // [NewsHeadline] objects
  static func getHeadlines() -> [NewsHeadline] {
    var headlines = [NewsHeadline]()
    
    // The app Bundle() allows to access (read) our app resources and files, e.g mp3 file or in our case the topStoriesTechnology.json
    
    // get the url to the intended resource
    // here we need the url to the topStoriesTechnology.json file
    guard let fileURL = Bundle.main.url(forResource: "topStoriesTechnology", withExtension: "json") else {
      fatalError("could not locate json file")
    }
    // get the data from the contents of the fileURL
    do {
      let data = try Data(contentsOf: fileURL)
      
      // Parse data to our Swift [NewHeadline]
      
      let headlinesData = try JSONDecoder().decode(HeadlinesData.self, from: data)
      headlines = headlinesData.results // [NewsHeadline]
      
    } catch {
      fatalError("failed to load contents \(error)")
    }
    return headlines
  }
  
}
