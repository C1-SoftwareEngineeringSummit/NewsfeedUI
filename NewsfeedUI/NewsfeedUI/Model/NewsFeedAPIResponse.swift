//
//  NewsFeedAPIResponse.swift
//  NewsfeedUI
//
//  Created by Fatima Arshad on 12/22/20.
//

import Foundation

class NewsArticle: Codable, Identifiable {
    var uuid = UUID()
    var author: String?
    var title: String
    var description: String?
    var urlToImage: String?
    var url: String
    var publishedAt: String
    var content: String?
    
    enum CodingKeys: String, CodingKey {
        case author
        case title
        case description
        case urlToImage
        case url
        case publishedAt
        case content
    }
}

class NewsApiResponse: Codable {
    var status: String
    var totalResults: Int
    var articles: [NewsArticle]?
}
