//
//  ContentView.swift
//  NewsfeedUI
//
//  Created by Longe, Chris on 12/21/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var newsFeed = NewsFeed()
    
    var body: some View {
        NavigationView {
            List {
                if !newsFeed.general.isEmpty {
                    CarouselView(articles: Array(newsFeed.general.prefix(5)))
                        .listRowInsets(EdgeInsets())
                }

                if !newsFeed.sports.isEmpty {
                    CategoryRow(categoryName: "Sports", articles: newsFeed.sports)
                        .listRowInsets(EdgeInsets())
                }

                if !newsFeed.health.isEmpty {
                    CategoryRow(categoryName: "Health", articles: newsFeed.health)
                        .listRowInsets(EdgeInsets())
                }

                if !newsFeed.entertainment.isEmpty {
                    CategoryRow(categoryName: "Entertainment", articles: newsFeed.entertainment)
                        .listRowInsets(EdgeInsets())
                }

                if !newsFeed.business.isEmpty {
                    CategoryRow(categoryName: "Business", articles: newsFeed.business)
                        .listRowInsets(EdgeInsets())
                }

                if !newsFeed.science.isEmpty {
                    CategoryRow(categoryName: "Science", articles: newsFeed.science)
                        .listRowInsets(EdgeInsets())
                }

                if !newsFeed.technology.isEmpty {
                    CategoryRow(categoryName: "Technology", articles: newsFeed.technology)
                        .listRowInsets(EdgeInsets())
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Newsfeed")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
