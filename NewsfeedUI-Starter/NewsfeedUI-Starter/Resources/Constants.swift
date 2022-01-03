//
//  Constants.swift
//  NewsfeedUI
//
//  Created by Fatima Arshad on 12/22/20.
//

import Foundation
import UIKit

enum Constants {
    // TODO: Replace the empty string with a string of your API key. If left empty, API responses will be mocked.
    static let APIKey: String = ""

    /// Determines whether api responses should be mocked based on the presense of an api key.
    static let useMockResponses = APIKey.isEmpty

    enum Endpoint {
        static let general = endpoint(for: "general")
        static let sports = endpoint(for: "sports")
        static let health = endpoint(for: "health")
        static let entertainment = endpoint(for: "entertainment")
        static let business = endpoint(for: "business")
        static let science = endpoint(for: "science")
        static let technology = endpoint(for: "technology")

        static func endpoint(for category: String) -> String {
            String(format: "https://newsapi.org/v2/top-headlines?country=us&category=%@&apiKey=%@", category, APIKey)
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
