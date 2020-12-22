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
            Text("List Should be displayed here.\n Uncomment Code lines given in Step 1, Step 2 and Step 3 to visualize api content.")
                .padding(10)
//            Step 1: Uncomment Following Code lines to visualize api content
//            List(newsFeed) { (article: NewsArticle) in
//                Text(article.title + "\n")
//            }
        .navigationBarTitle("iOS SES 2021")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
