//
//  ImageTweetCell.swift
//  TweeterTags
//
//  Created by Roisin Bolt on 07/03/2021.
//  Copyright © 2021 COMP47390-41550. All rights reserved.
//

import Foundation
import UIKit

class ImageTweetCell: UITableViewCell {
    
    static let identifier = "tweetImageCell"
    
    @IBOutlet weak var tweetImage: UIImageView!
    
    var tweetImageCell: UIImage? {
        didSet {
            image()
        }
    }
    
    //MARK: - Image Format
    func image() {
        if let image = self.tweetImageCell {
            tweetImage.frame = CGRect(x: 0, y: 0, width: self.frame.width / 2.0, height: self.frame.height / 2.0)
            tweetImage.image = image
            tweetImage.contentMode = UIView.ContentMode.scaleAspectFit
        }
    }
}
