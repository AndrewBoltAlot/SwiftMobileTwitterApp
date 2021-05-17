//
//  Sections.swift
//  TweeterTags
//
//  Created by Roisin Bolt on 07/03/2021.
//  Copyright © 2021 COMP47390-41550. All rights reserved.
//

import Foundation

class Section {
    var header : String
    var mentions : [CustomStringConvertible]
    
    init(header: String, mentions : [CustomStringConvertible]) {
        self.header = header
        self.mentions = mentions
    }
}
