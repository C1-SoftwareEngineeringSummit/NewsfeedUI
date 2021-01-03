//
//  FeatureView.swift
//  NewsfeedUI
//
//  Created by Nelson, Connor on 12/23/20.
//

import SwiftUI

struct FeatureView: View {
    var article: NewsArticle

    var body: some View {
        RemoteImage(url: article.urlToImage)
            .aspectRatio(3 / 2, contentMode: .fit)
            .overlay(TextOverlay(text: article.title))
    }
}

struct TextOverlay: View {
    var text: String

    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color.black.opacity(0.8), Color.black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle()
                .fill(gradient)
            Text(text)
                .font(.headline)
                .padding()
                .padding(.bottom, 25)
        }
        .foregroundColor(.white)
    }
}

struct FeatureView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureView(article: NewsFeed.sampleData[0])
    }
}
