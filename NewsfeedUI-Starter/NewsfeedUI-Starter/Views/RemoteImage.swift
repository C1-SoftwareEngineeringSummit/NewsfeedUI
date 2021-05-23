//
//  RemoteImage.swift
//  NewsfeedUI
//
//  Created by Nelson, Connor on 12/24/20.
//

import SwiftUI

// https://www.hackingwithswift.com/forums/swiftui/loading-images/3292
struct RemoteImage: View {
    private enum LoadState {
        case loading, success, failure
    }

    private class Loader: ObservableObject {
        var data = Data()
        var state = LoadState.loading

        init(url: String, mockRequest: Bool = Constants.useMockResponses) {
            guard !mockRequest else { return }
            guard let parsedURL = URL(string: url) else {
                fatalError("Invalid URL: \(url)")
            }

            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                if let data = data, data.count > 0 {
                    self.data = data
                    self.state = .success
                } else {
                    self.state = .failure
                }

                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }

    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image
    var mockRequest: Bool

    var body: some View {
        if mockRequest {
            Image("image\(Int.random(in: 1...13))")
                .resizable()
        } else {
            selectImage()
                .resizable()
        }
    }

    init(url: String?, loading: Image = Image(systemName: "photo"),
         failure: Image = Image(systemName: "multiply.circle"),
         mockRequest: Bool = Constants.useMockResponses) {
        if let unwrappedUrl = url {
            self.mockRequest = mockRequest
            _loader = StateObject(wrappedValue: Loader(url: unwrappedUrl, mockRequest: mockRequest))
        } else {
            self.mockRequest = true
            _loader = StateObject(wrappedValue: Loader(url: "", mockRequest: true))
        }

        self.loading = loading
        self.failure = failure
    }

    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
}
