//
//  DetailView.swift
//  NewsfeedUI
//
//  Created by Levine, Merlin on 12/29/20.
//

import SwiftUI

struct DetailView: View {
    var article: NewsArticle
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(article.title)
                    .italic()
                    .font(.title)
                    .fontWeight(.semibold)

                RemoteImage(url: article.urlToImage, mockRequest: true)
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom)

                Text("By " + (article.author ?? "Author"))
                    .bold()
                Text(article.datePublished)
                    .font(.subheadline)
                    .padding(.bottom)

                Text(article.description ?? "Description")
                    .font(.body)
                    .padding(.bottom)

                HStack {
                    Spacer()
                    NavigationLink(destination: WebView()) {
                        Text("View Full Article")
                    }.buttonStyle(FilledButtonStyle())
                    Spacer()
                }
            }.padding()
        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct FilledButtonStyle: ButtonStyle {
    var backgroundColor: Color = .blue
    var foregroundColor: Color = .white

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.vertical, 10)
            .padding(.horizontal, 50)
            .background(backgroundColor)
            .cornerRadius(10)
            .font(.title3)
            .foregroundColor(configuration.isPressed ? foregroundColor.opacity(0.5) : foregroundColor)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(article: NewsFeed.sampleData[4])
    }
}
