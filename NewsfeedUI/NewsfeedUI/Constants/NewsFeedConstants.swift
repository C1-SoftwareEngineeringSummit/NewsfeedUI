//
//  NewsFeedConstants.swift
//  NewsfeedUI
//
//  Created by Fatima Arshad on 12/22/20.
//

import Foundation
import UIKit

enum NewsFeedConstants {
    /// News Feeds' URLs
    enum Endpoint {
        static let everthing: String = "https://newsapi.org/v2/everything?q=everything&apiKey=36ce277d0b73433998e928a526a10e05&language=en&page="
        
        static let apple: String =
            "https://newsapi.org/v2/everything?q=apple&apiKey=36ce277d0b73433998e928a526a10e05&language=en&page="
    }
    
    /// API Response Statuses
    enum APIResponse {
        static let statusOK: String = "ok"
    }
    
    /// JSON Response Payloads
    enum ResponsePayload {
        static let everything: String = "ResponsePayload"
    }
}
