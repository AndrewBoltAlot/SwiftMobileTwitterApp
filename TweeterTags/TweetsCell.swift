//
//  TweetsCell.swift
//  TweeterTags
//
//  Created by Roisin Bolt on 04/03/2021.
//  Copyright © 2021 COMP47390-41550. All rights reserved.
//

import Foundation
import UIKit

class TweetsCell : UITableViewCell {
    
    static let identifier = "tweetsCell"
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!
    
    var tweet : TwitterTweet? {
        didSet {
            updateCell()
        }
    }
    //MARK: - Tweet logic
    private func updateCell(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        self.userName?.text = tweet?.user.screenName
        if tweet?.created != nil {
            self.createdAt?.text = dateFormatter.string(from: tweet!.created as Date)
        }
        if let imageURL = tweet?.user.profileImageURL {
            if let imageData = try? Data(contentsOf: imageURL) {
                self.userAvatar.image = UIImage(data: imageData)
            }
        }
        //let tweet allows the [TwitterMentions] to conform to sequence, so the for in loop can occur
        if let tweet = self.tweet {
            if tweetText?.text != nil  {
                let attributedString = NSMutableAttributedString(string: tweet.text)
                for mention in tweet.userMentions {
                    let range = mention.nsrange
                    attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: range)
                }
                for hashtag in tweet.hashtags {
                    let range = hashtag.nsrange
                    attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range)
                }
                for url in tweet.urls {
                    let range = url.nsrange
                    attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range)
                }
                tweetText?.attributedText = attributedString
            }
        }
    }
}
