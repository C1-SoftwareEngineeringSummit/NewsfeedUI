//
//  NewsFeedConstants.swift
//  NewsfeedUI
//
//  Created by Fatima Arshad on 12/22/20.
//

import Foundation
import UIKit

enum NewsFeedConstants {
    // Provide your API key here
    static let APIKey = ""
    
    /// News Feeds' URLs
    static let endpointURL = String(format: "https://newsapi.org/v2/everything?q=everything&apiKey=%@&language=en&page=", APIKey)
    
    enum Endpoint {
        static var everything: String = String(format: "https://newsapi.org/v2/everything?q=everything&apiKey=%@&language=en&page=", APIKey)
        static var apple: String =
            String(format: "https://newsapi.org/v2/everything?q=apple&apiKey=%@&language=en&page=", APIKey)
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
