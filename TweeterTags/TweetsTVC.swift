//
//  TweetsTVC.swift
//  TweeterTags
//
//  Created by Roisin Bolt on 04/03/2021.
//  Copyright © 2021 COMP47390-41550. All rights reserved.
//
import Foundation
import UIKit


class TweetsTVC : UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var twitterQueryTextField: UITextField!
    //MARK: - DATA Model
    var tweets = [[TwitterTweet]]()
    
    var twitterQueryText: String {
        set {
                twitterQueryTextField?.text = newValue
                tweets.removeAll()
                refresh()
        
        }
        get {
            return twitterQueryTextField?.text ?? ""
        }
   
    }
    //MARK: - Twitter Request
    private func refresh() {
        let request = TwitterRequest(search: twitterQueryText)

        request.fetchTweets {
            (tweets) -> Void in DispatchQueue.main.async {
                () -> Void in
                print("\(request) \(tweets.count)")
                if tweets.count > 0 {
                    //private var to check if refreseh table occured
                    self.tweets .insert(tweets, at: 0)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.twitterQueryTextField.delegate = self
        refresh()
    }
    //MARK: - Delegate Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tweets.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return UITableView.automaticDimension
      }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tweetCell = tableView.dequeueReusableCell(withIdentifier: TweetsCell.identifier, for: indexPath) as! TweetsCell
        
    
        tweetCell.tweet = tweets[indexPath.section][indexPath.row]
        
        return tweetCell
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        twitterQueryText = textField.text ?? ""
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = tableView.indexPathForSelectedRow!
        let tweetCell = tableView.cellForRow(at: index) as! TweetsCell
        if(segue.identifier == "TweetMentions") {
            let mentionsTVC = segue.destination as! MentionsTVC
            mentionsTVC.tweet = tweetCell.tweet
        }
    }
    
}
