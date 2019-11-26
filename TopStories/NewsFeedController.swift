//
//  ViewController.swift
//  TopStories
//
//  Created by Alex Paul on 11/25/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class NewsFeedController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  // data for table view
  var headlines = [NewsHeadline]() {
    didSet {
      tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self // NewsFeedController is the dataSource object for the table view
    tableView.delegate = self
    loadData()
  }
  
  func loadData() {
    headlines = HeadlinesData.getHeadlines() // [NewsHeadline]
  }
}

extension NewsFeedController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return headlines.count // ~39 headlines
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "headlineCell", for: indexPath) as? HeadlineCell else {
      fatalError("couldn't dequeue a HeadlineCell")
    }
    
    // get object (headline) at the current indexPath
    let headline = headlines[indexPath.row]
    
    cell.configureCell(for: headline)
    
    return cell
  }
}


extension NewsFeedController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 180
  }
}
