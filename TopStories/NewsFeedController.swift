//
//  ViewController.swift
//  TopStories
//
//  Created by Alex Paul on 11/25/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

enum SearchScope {
  case title // title of headline
  case abstract // a summary of the headline
}

class NewsFeedController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  // data for table view
  var headlines = [NewsHeadline]() {
    didSet { // property observer, observes changes on headlines and updates the table view
      tableView.reloadData()
    }
  }
  
   // default value is 0 "Title" scope
  var currentScope = SearchScope.title {
    didSet {
      filterResults(for: searchBar.text ?? "")
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self // NewsFeedController is the dataSource object for the table view
    tableView.delegate = self
    searchBar.delegate = self
    filterResults(for: "")
    navigationItem.title = "Top Stories - \(headlines.first?.section ?? "")"
  }
  
  func filterResults(for searchQuery: String) {
    guard !searchQuery.isEmpty else {
      headlines = HeadlinesData.getHeadlines()
      return
    }
    switch currentScope {
    case .title:
      headlines = HeadlinesData.getHeadlines().filter { $0.title.lowercased().contains(searchQuery.lowercased()) }
    case .abstract:
      headlines = HeadlinesData.getHeadlines().filter { $0.abstract.lowercased().contains(searchQuery.lowercased()) }
    }
  }
  
  func filterHeadlines(for searchText: String) {
    // guarding against and empty search query
    // return here simpty does nothing, just exits the method
    guard !searchText.isEmpty else { return }
    headlines = HeadlinesData.getHeadlines().filter { $0.title.lowercased().contains(searchText.lowercased()) }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // 1. get destination view controller
    // 2. we need the indexPath the user selected from the table view
    guard let newsDetailController = segue.destination as? NewsDetailController,
      let indexPath = tableView.indexPathForSelectedRow else {
      fatalError("verify class name in the \"identity inspector\" ")
    }
    
    // 3. get the selected headline
    let headline = headlines[indexPath.row]
    
    // 4. set the newsDetailController newsHeadline
    newsDetailController.newsHeadline = headline
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

extension NewsFeedController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    // dismiss the keyboard
    searchBar.resignFirstResponder()
  }
    
  // real time searching as the user types
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    guard !searchText.isEmpty else {
      // searchText is empty here so we get back all the original headlines
      // using our loadData() method
      filterResults(for: "")
      return
    }
    filterResults(for: searchText)
  }
  
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    switch selectedScope {
    case 0:
      currentScope = .title
    case 1:
      currentScope = .abstract
    default:
      print("not a valid search scope")
    }
  }
}
