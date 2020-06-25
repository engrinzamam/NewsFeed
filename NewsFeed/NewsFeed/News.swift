//
//  News.swift
//  NewsFeed
//
//  Created by Sixlogics on 19/06/2020.
//  Copyright © 2020 Inzamam ul haq. All rights reserved.
//

import Foundation
import SwiftyJSON

class News {
    var author = ""
    var title = ""
    var description = ""
    var url = ""
    var urlToImage = ""
    var publishedAt = ""
    var content = ""
    var source: Source?
    
    init() { }
    
    init(json: JSON) {
        if let author = json["author"].string {
            self.author = author
        }
        if let title = json["title"].string {
            self.title = title
        }
        if let description = json["description"].string {
            self.description = description
        }
        if let url = json["url"].string {
            self.url = url
        }
        if let urlToImage = json["urlToImage"].string {
            self.urlToImage = urlToImage
        }
        if let publishedAt = json["publishedAt"].string {
            self.publishedAt = publishedAt
        }
        if let content = json["content"].string {
            self.content = content
        }
        if let source = json["source"].dictionary {
            let json = JSON(source)
            self.source = Source(json: json)
        }
    }
}

class Source {
    var id: String?
    var name: String?
    
    init(json: JSON) {
        if let id = json["id"].string {
            self.id = id
        }
        if let name = json["name"].string {
            self.name = name
        }
    }
}
