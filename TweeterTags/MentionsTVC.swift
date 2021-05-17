//
//  MentionsTVC.swift
//  TweeterTags
//
//  Created by Roisin Bolt on 07/03/2021.
//  Copyright © 2021 COMP47390-41550. All rights reserved.
//

import Foundation
import UIKit

class MentionsTVC: UITableViewController {
    var sections: [Section] = []
    var tweet: TwitterTweet! 
    
    //MARK: -- Section Array Appending function
    func sectionTweets() {
        if !tweet.media.isEmpty {
            sections.append(Section(header: "Images", mentions: tweet.media))
        }
        if !tweet.urls.isEmpty {
            sections.append(Section(header: "URLs", mentions: tweet.urls))
        }
        if !tweet.hashtags.isEmpty{
            sections.append(Section(header: "Hashtags", mentions: tweet.hashtags))
        }
        if !tweet.userMentions.isEmpty {
            sections.append(Section(header: "Users", mentions: tweet.userMentions))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sectionTweets()
    }
    
    //MARK: -- Delegate Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].mentions.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].header
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        
        if section.header == "Images" {
            let imageCell = tableView.dequeueReusableCell(withIdentifier: ImageTweetCell.identifier, for: indexPath) as! ImageTweetCell
            let media = section.mentions[indexPath.row] as! TwitterMedia
            let imageURL = media.url
            if let imageData = try? Data(contentsOf: imageURL) {
                imageCell.tweetImageCell = UIImage(data: imageData)
            }
            return imageCell
        }
        else {
            let sectionCell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath)
            let mentions = section.mentions[indexPath.row] as! TwitterMention
            sectionCell.textLabel?.text = mentions.keyword
            return sectionCell
        }
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
            let photo = tweet.media[indexPath.row]
            if (segue.identifier == "bigImageView") {
                let imageVC = segue.destination as! ImageVC
                imageVC.imageURL = photo as? URL
            }
      }
    }
    
}
