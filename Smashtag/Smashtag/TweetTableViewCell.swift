//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Kelvin Leung on 16/07/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    @IBOutlet weak var tweetUserLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet: Twitter.Tweet? { didSet { updateUI() } }
    
    private func updateUI() {
        tweetUserLabel?.text = tweet?.user.name
        tweetTextLabel?.text = tweet?.text
    }
}
