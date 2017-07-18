//
//  TweetTableViewController.swift
//  Smashtag
//
//  Created by Kelvin Leung on 16/07/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewController: UITableViewController, UISearchBarDelegate {
    
    //  the "model"
    private var tweets = [Array<Twitter.Tweet>]() {
        didSet {
            //  debug check
//            print(tweets)
        }
    }
    
    var searchText: String? {
        didSet {
            searchTweets?.resignFirstResponder()
            //  change the model
            tweets.removeAll()
            tableView.reloadData()
            searchForTweets()
            title = "#\(searchText ?? "")"
        }
    }
    
    private func twitterRequest() -> Twitter.Request? {
        if let query = searchText, !query.isEmpty {
            return Twitter.Request(search: query, count: 100)
        }
        return nil
    }
    
    //  keep track of the last request, if new one comes back, skip the old
    private var lastTwitterRequest: Twitter.Request?
    
    func insertTweets(_ newTweets: [Twitter.Tweet]) {
        self.tweets.insert(newTweets, at: 0)
        self.tableView.insertSections([0], with: .fade)
    }
    
    private func searchForTweets() {
        if let request = twitterRequest() {
            lastTwitterRequest = request
            request.fetchTweets { [weak self] newTweets in
                //  UI operation must in main Q
                DispatchQueue.main.async {
                    if request == self?.lastTwitterRequest {
                        self?.insertTweets(newTweets)
                    }
                }
            }
        }
    }
    
    @IBOutlet weak var searchTweets: UISearchBar! {
        didSet {
            searchTweets.delegate = self
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar == searchTweets {
            searchText = searchBar.text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Twitter"
        //  make cell row adaptive
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
//        searchText = "#stanford"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return tweets.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return tweets[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //  "identifier" is set in SB
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tweet", for: indexPath)

        //  Configure the cell...
        //  the cell is set to be "Subtitle"
        let tweet: Twitter.Tweet = tweets[indexPath.section][indexPath.row]
//        cell.textLabel?.text = tweet.text
//        cell.detailTextLabel?.text = tweet.user.name
        if let tweetCell = cell as? TweetTableViewCell {
            tweetCell.tweet = tweet
        }

        return cell
    }
}
