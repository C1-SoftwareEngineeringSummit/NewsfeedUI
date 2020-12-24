//
//  Constants.swift
//  NewsfeedUI
//
//  Created by Fatima Arshad on 12/22/20.
//

import Foundation
import UIKit

enum Constants {
    // TODO: Provide your API key here
    static let APIKey = ""

    enum Endpoint {
        static let general = endpoint(for: "general")
        static let sports = endpoint(for: "sports")
        static let health = endpoint(for: "health")
        static let entertainment = endpoint(for: "entertainment")
        // TODO: Add more categories here

        static func endpoint(for category: String) -> String {
            return String(format: "https://newsapi.org/v2/top-headlines?country=us&category=%@&apiKey=%@", category, APIKey)
        }
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
