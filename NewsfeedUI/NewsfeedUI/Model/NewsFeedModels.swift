//
//  NewsFeedModels.swift
//  NewsfeedUI
//
//  Created by Fatima Arshad on 12/22/20.
//

import Foundation

class NewsFeed: ObservableObject {

//            Step 2: Uncomment Following Code lines to visualize api content
//class NewsFeed: ObservableObject, RandomAccessCollection {
    @Published var news = [NewsArticle]()
    init() {
        // Hitting Actual Endpoint
        startLoadingNewsFeeds()
        
        // Reading From JSON
//        startLoadingFromJSON()
    }
    
//            Step 3: Uncomment Following Code lines to visualize api content
//    var startIndex: Int { news.startIndex }
//    var endIndex: Int { news.endIndex }
//    subscript(position: Int) -> NewsArticle {
//        return news[position]
//    }
}

// MARK: - Make API Call by hitting NewsAPI Endpoint
extension NewsFeed {
    /// Make API Call to fetch news feeds
    func startLoadingNewsFeeds() {
        /// Hitting NewsFeeds - Everything API Call
        // Only fetching first page of API response
        let page = "1"
        let urlString = "\(NewsFeedConstants.Endpoint.everything)\(page)"
        
        guard let feedsURL = URL(string: urlString) else { return }
        let networkTask = URLSession.shared.dataTask(with: feedsURL,
                                              completionHandler: parseAPIResponse(data:response:error:))
        networkTask.resume()
    }
    
    // MARK :- Parse API Response
    func parseAPIResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            return
        }
        guard let data = data else {
            print("No data found to be displayed.")
            return
        }
        
        parseJSONData(data)
    }
}

// MARK: - Read from JSON File
extension NewsFeed {
    /// Load API Response from JSON File
    func startLoadingFromJSON() {
        guard let jsonData = readJsonFromFile(resourceName: NewsFeedConstants.ResponsePayload.everything) else { return }
        parseJSONData(jsonData)
    }
    
    func readJsonFromFile(resourceName: String) -> Data? {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: resourceName, ofType: "json") else {
            return nil
        }
        guard let jsonString = try? NSString(contentsOfFile: pathString, encoding: String.Encoding.utf8.rawValue) else {
            return nil
        }
        guard let jsonData = jsonString.data(using: String.Encoding.utf8.rawValue) else {
            return nil
        }
        return jsonData
    }
}

// MARK:- Helper Method | Parse JSON Data
extension NewsFeed {
    private func parseJSONData(_ data: Data) {
        var response: NewsApiResponse
        do {
            response = try JSONDecoder().decode(NewsApiResponse.self, from: data)
        } catch {
            print("Error parsing the API response: \(error)")
            return
        }
        
        if response.status != NewsFeedConstants.APIResponse.statusOK {
            print("API response status is not OK: \(response.status)")
            return
        }
        
        // [SwiftUI] Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
        let feeds =  response.articles ?? []
        DispatchQueue.main.async {
            self.news.append(contentsOf: feeds)
        }
    }
}

