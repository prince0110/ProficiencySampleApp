//
//  APIModel.swift
//  Proficiency_iOS
//
//  Created by Prince Gupta on 17/02/20.
//  Copyright © 2020 Prince Gupta. All rights reserved.
//

import Foundation

struct ResponseModel: Codable {
    
    var mainTitle: String?
    var items: [ItemDict]?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mainTitle = try values.decode(String?.self, forKey: .mainTitle)
        items = try values.decode([ItemDict]?.self, forKey: .items)
    }
    
    enum CodingKeys: String, CodingKey {
        case mainTitle = "title"
        case items = "rows"
    }
}

struct ItemDict: Codable {
    
    var title: String?
    var desc: String?
    var imageUrl: String?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String?.self, forKey: .title)
        desc = try values.decode(String?.self, forKey: .desc)
        imageUrl = try values.decode(String?.self, forKey: .imageUrl)
    }
       
    enum CodingKeys: String, CodingKey {
        case desc = "description"
        case imageUrl = "imageHref"
        case title
    }
}
