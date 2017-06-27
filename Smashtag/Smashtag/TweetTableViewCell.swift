//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by C4Q  on 6/23/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    @IBOutlet weak var tweetUserLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet: Twitter.Tweet? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        guard let tweet = tweet else {
            return
        }
        let tweetString = NSMutableAttributedString(string: tweet.text, attributes: [:])
        tweet.userMentions.forEach{
            tweetString.addAttribute(NSForegroundColorAttributeName, value: UIColor.green, range: $0.nsrange)
        }
        tweet.urls.forEach {
            tweetString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: $0.nsrange)
        }
        tweet.hashtags.forEach {
            tweetString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: $0.nsrange)
        }
        tweetTextLabel?.attributedText = tweetString
        tweetUserLabel?.text = tweet.user.description
        
        if let profileImageURL = tweet.user.profileImageURL {
            DispatchQueue.main.async { [weak self] in
                if let imageData = try? Data(contentsOf: profileImageURL) {
                    self?.tweetProfileImageView?.image = UIImage(data: imageData)
                }
            }
        } else {
            tweetProfileImageView?.image = nil
        }
        let created = tweet.created
        let formatter = DateFormatter()
        if Date().timeIntervalSince(created) > 24 * 60 * 60 {
            formatter.dateStyle = .short
        } else {
            formatter.timeStyle = .short
        }
        tweetCreatedLabel?.text = formatter.string(from: created)
    }
}

