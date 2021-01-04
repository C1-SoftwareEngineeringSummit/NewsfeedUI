//
//  APIResponse.swift
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

    lazy var datePublished: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current

        if let date = dateFormatter.date(from: publishedAt) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "MMM. d, yyyy h:mm a zzz"
            return displayFormatter.string(from: date)
        }
        return publishedAt
    }()
    
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
