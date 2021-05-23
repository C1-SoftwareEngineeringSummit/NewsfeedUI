# NewsfeedUI

This workshop covers building a Newsfeed app using SwiftUI, and it's meant to be used for Capital One's Software Engineering Summit. This workshop covers the basics of Swift, iOS, SwiftUI, and building apps with Xcode.

## Requirements

This project has been updated to work with Xcode 12.4, Swift 5.3, and iOS 14.4. Xcode 12.4 requires a Mac running macOS 10.15.4 or later.

* Download Xcode [here](https://developer.apple.com/xcode/)

## Content

In this repo, you'll find two versions of the NewsfeedUI App: a starter project and the completed project.

To get started, open the `Newsfeed-Starter.xcodeproj` file located in the `NewsfeedUI-Starter` directory. Please refer to the [Step By Step Instructions](./StepByStepInstructions.md) for detailed instructions on building this app. During the workshop you can use these instructions to follow along.

## Bonus Functionality

If you're feeling up to it, you can add more news categories to the home screen.

To do this, you will first need to create URLs for the additional news categories. Open `Constants.swift` and look at `enum Endpoint`. Here we have `static let` constants for each of the existing categories `general`, `sports`, `health`, and `entertainment`. First, take a look at the [News API's top headlines endpoint](https://newsapi.org/docs/endpoints/top-headlines) and choose a new category to add (`technology` for example). Then, add 1 new `static let` for each additional news category that you want to display.

Next, you need to use those URLs to add some more API calls to `Models.swift`. Open that file, and look at `func startLoadingNewsFeeds()`. That function contains multiple API calls to retrieve the General, Sports, Health, and Entertainment categories of news. You will need to add 1 new API call for each new category URL you added to `Constants.swift`. You can copy and paste one of the existing API requests and adjust it slightly to work with a different category. Don't forget to also add a `@Published var` to the `NewsFeed` class for each additional category.

Lastly, open `ContentView.swift` and add 1 new `CategoryRow` to the `List` for each additional news category you have added. This will look the same as all of the other `CategoryRows`, with some minor changes to use your new category. 

### App Design

SwiftUI allows you to customize any UI element in several ways. For example, text can be customized with different colors, fonts, backgrounds or rotation effects.

Learn more about customizing your application with the following resources:

* [Text](https://www.appcoda.com/learnswiftui/swiftui-text.html)
* [Navigation Bar](https://www.ioscreator.com/tutorials/swiftui-customize-navigation-bar-tutorial)
* [Custom Launch Screen](https://www.tutlane.com/tutorial/ios/ios-launch-screen-splash-screen)

## References

* [Swift Language Guide](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html)
* [Apple's SwiftUI Tutorials](https://developer.apple.com/tutorials/app-dev-training)
