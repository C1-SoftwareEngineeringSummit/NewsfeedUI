//
//  DetailView.swift
//  NewsfeedUI
//
//  Created by Levine, Merlin on 12/29/20.
//

import SwiftUI

struct DetailView: View {
    var article: NewsArticle
    @State var showWebView = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(article.title)
                    .italic()
                    .font(.title)
                    .fontWeight(.semibold)

                RemoteImage(url: article.urlToImage)
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
                    Button("View Full Article") {
                        showWebView = true
                    }
                    .buttonStyle(FilledButtonStyle())
                    .sheet(isPresented: $showWebView, content: {
                        // modally present web view
                        WebView(url:URL(string: article.url)!)
                    })
                    Spacer()
                }
            }.padding()
        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct FilledButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.vertical, 10)
            .padding(.horizontal, 50)
            .font(.title3)
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color(red: 0.0, green: 0.3, blue: 0.8) : .blue)
            .cornerRadius(10)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(article: NewsFeed.sampleData[4])
    }
}
