# Displaying Featured Articles
Now, we'll create a view that can display multiple featured articles in a "carousel" (or page view). Users will be able to swipe left and right to view different featured articles, and a page control at the bottom will display the current page in the form of highlighted dots.

> ** INSERT IMAGE OR GIF HERE OF THE CAROUSEL **

## CarouselView
First, we'll build a `CarouselView`, which will display multiple pages of content and allow users to swipe left and right between different pages.

1. Create a new SwiftUI file in the `Views` folder called `CarouselView.swift`

2. Insert a `var` at the top of the `CarouselView` `struct` called `articles`
```swift
struct CarouselView: View {
    var articles: [NewsArticle]
```

* `articles` will store an array of `NewsArticle`s that should be displayed in the `CarouselView`.

3. Update the `PreviewProvider` to initialize the preview with a list of sample `NewsArticle`s
```swift
struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(articles: Array(NewsFeed.sampleData.prefix(3)))
    }
}
```

* This will retrieve the first 3 `NewsArticle`s in our `sampleData` and pass them to the `CarouselView` in the preview.

4. Replace the `Text` in the `body` with a `TabView` that contains the `title` of each article in the `articles` array
```swift
var body: some View {
    TabView() {
        ForEach(articles) { article in
            Text(article.title)
        }
    }
    .aspectRatio(3 / 2, contentMode: .fit)
    .tabViewStyle(PageTabViewStyle())
    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
}
```

* The `ForEach` loop goes through the `articles` array and creates a `Text` for each `article` in the array. For now, the `article`'s `title` is the only thing displayed in the `CarouselView`.
* A `TabView` is a `View` that can switch between different child views. In our case, the child views are the different article titles displayed by `Text(article.title)`. The `TabView` is the most important piece of our `CarouselView` since it's what allows us to swipe between different featured `NewsArticle`s.
* `.aspectRatio(3 / 2, contentMode: .fit)` sets the aspect ratio of our `TabView` to 3:2 (width:height). By setting `.contentMode` to `.fit` we tell the `TabView` to scale up or down so that it fits perfectly within a 3:2 frame.
* `.tabViewStyle(PageTabViewStyle())` sets our `TabView`'s style to `PageTabViewStyle`. This is what makes our `TabView` appear as a page view (or "carousel") with highlighted dots to track our tab position. Without this style, our `TabView` would appear with a full tab bar at the bottom of the screen, much like the iOS Music or Phone app.
* `.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))` is what causes the highlighted dots to appear at the bottom of our `TabView`. We are setting the page index (the highlighted dots) to be displayed with a background `.always`. We will actually remove this line later, but for now it allows us to view the highlighted dots on a white background.

> At this point, you can resume your Canvas preview to see how the `CarouselView` looks so far. You can also press the circular ▶️ button directly above the simulator in your Canvas. This will start a live preview of the `CarouselView`. You can use your cursor to swipe the pages left and right, and the highlighted dots at the bottom should update as well. Click the ⏹️ button to stop the live demo.

> ** INSERT IMAGE OR GIF HERE OF THE LIVE PREVIEW **

## FeatureView
Our `CarouselView` works okay for now, but it lacks visual appeal. To fix this, we're going to create a new `FeatureView` that will replace the `CarouselView`'s existing `Text(article.title)`. `FeatureView` will display an article's image with the title overlayed on top of it.

> ** INSERT IMAGE OR GIF HERE OF THE FEATURE VIEW **

1. Create a new SwiftUI file in the `Views` folder called `FeatureView.swift`

2. Insert a `var` at the top of the `FeatureView` `struct` called `article`
```swift
struct FeatureView: View {
    var article: NewsArticle
```

* This will contain the `NewsArticle` that this `FeatureView` will display.

3. Update the `PreviewProvider` to initialize the preview with a sample `NewsArticle`
```swift
struct FeatureView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureView(article: NewsFeed.sampleData[0])
    }
}
```

4. Replace the `Text` in the `body` with the `image` for the current `article`
```swift
var body: some View {
    article.image
        .resizable()
        .aspectRatio(contentMode: 3 / 2, contentMode: .fill)
        .clipped()
}
```

* `.resizable()` allows this `Image` to be resized.
* `.aspectRatio(contentMode: 3 / 2, contentMode: .fill)` sets the aspect ratio for the `image`, and causes it to scale up so that it fills the entire 3:2 frame.
* `.clipped()` means that any parts of the `image` outside of the 3:2 frame will not be visible.

5. Add a new `TextOverlay` `View` that will overlay the `NewsArticle`'s `title` on top of the `image`. This new `View` should go after the `FeatureView`, but before `FeatureView_Previews`.
```swift
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
            Rectangle().fill(gradient)
            Text(text)
                .font(.headline)
                .padding()
                .padding(.bottom, 25)
        }
        .foregroundColor(.white)
    }
}
```

* `var text` will contain the text that is displayed by this overlay. In our app, this will contain the article's `title`.
* `gradient` is a `LinearGradient` - this is a blend between two colors over a given distance. Here, we are transitioning from almost-opaque black at the bottom of the `gradient`, to clear in the center of the `gradient`. This gradient will darken the bottom half of our `image`, allowing the white `text` to stand out on top of any `image`.
* The `body` of the `TextOverlay` is a `ZStack` that places the `text` on top of the `gradient`. Both of these views are aligned using their `.bottomLeading` (bottom-left) corners.
* The `Text` has some standard `.padding()` applied to all edges, as well as 25 points of additional `.padding` on the `.bottom` edge. This creates enough space at the bottom so our `text` and the highlighted dots of our `CarouselView` don't overlap.
* `.foregroundColor(.white)` sets the color of our `text` to `.white`.

6. Add a `TextOverlay` to the `FeatureView`'s `image`
```swift
var body: some View {
    article.image
        .resizable()
        .aspectRatio(contentMode: 3 / 2, contentMode: .fill)
        .clipped()
        .overlay(TextOverlay(text: article.title))
}
```

> Resume the Canvas preview if you haven't already, and see what the `FeatureView` looks like now!

> ** INSERT IMAGE OR GIF HERE OF THE FEATURE VIEW **

Before we move on, your entire `FeatureView.swift` should look like this
```swift
import SwiftUI

struct FeatureView: View {
    var article: NewsArticle

    var body: some View {
        article.image
            .resizable()
            .aspectRatio(contentMode: 3 / 2, contentMode: .fill)
            .clipped()
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
            Rectangle().fill(gradient)
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
```

## Putting It Together
Now that we've created a nice `FeatureView`, we can use it within our `CarouselView`!

1. Open `CarouselView.swift` once more and replace the `Text` inside of the `ForEach` loop with a `FeatureView`. You can also remove the `.indexViewStyle` modifier. `CarouselView.swift` should now look like this.
```swift
import SwiftUI

struct CarouselView: View {
    var articles: [NewsArticle]

    var body: some View {
        TabView() {
            ForEach(articles) { article in
                FeatureView(article: article)
            }
        }
        .aspectRatio(3 / 2, contentMode: .fit)
        .tabViewStyle(PageTabViewStyle())
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(articles: Array(NewsFeed.sampleData.prefix(3)))
    }
}
```

> Resume the Canvas preview now to see the completed `CarouselView`! You can also start a live preview in the Canvas to make sure that you are still able to swipe left and right between different `FeatureView`s in the carousel.

> ** INSERT IMAGE OR GIF HERE OF THE CAROUSEL VIEW **

# Displaying Categories of Articles
In this section, we'll create the following view, which will allow us to display multiple article "cards" in a horizontal scroll view. One of these horizontal scroll views will contain all articles from a given category (technology, business, sports, music, etc.).

> ** INSERT IMAGE OR GIF HERE OF THE HORIZONTAL SCROLL VIEW **

## CategoryRow
First, we will build a horizontal scroll view to contain all of the articles in a single category. We'll call it `CategoryRow`.

1. Create a new SwiftUI file in the `Views` folder called `CategoryRow.swift`

2. Insert two `var`s at the top of the `CategoryRow` `struct` called `categoryName` and `articles`
```swift
struct CategoryRow: View {
	var categoryName: String
	var articles: [NewsArticle]
```

* `categoryName` is the name of this category ("Technology", "Business", "Sports", "Music", etc.).
* `articles` is an `Array` of `NewsArticle`s that belong to this category.

3. Update the `PreviewProvider` to initialize these two `var`s in the preview
```swift
struct CategoryRow_Previews: PreviewProvider {
    static var articles = NewsFeed.sampleData

    static var previews: some View {
        CategoryRow(categoryName: "Sports", articles: articles)
    }
}
```

4. Update the `Text` in the `body` to display the `categoryName` rather than the static `"Hello, World!"` text
```swift
var body: some View {
    Text(categoryName)
        .font(.title)
}
```

* We use `.font(.title)` to style this `Text` as a `.title`.

5. Add an `HStack` (horizontal stack) that will contain all of the articles in the given category
```swift
var body: some View {
    Text(categoryName)
        .font(.title)

    HStack(alignment: .top, spacing: 0) {
        ForEach(articles) { article in
            Text(article.title.prefix(10))
        }
    }
}
```

* When we create the `HStack`, we define the `alignment` to be `.top`, meaning that all of the items in the `HStack` will have their top edges aligned.
* The `ForEach` loop goes through the `articles` array and creates a `Text` for each `article` in the array. For now, the `Text` only displays the first 10 characters in the `article`'s `title`.

6. Group the category name and the horizontal stack together in a `VStack` (vertical stack)
```swift
var body: some View {
    VStack(alignment: .leading) {
        Text(categoryName)
            .font(.title)

        HStack(alignment: .top, spacing: 0) {
            ForEach(articles) { article in
                Text(article.title.prefix(10))
            }
        }
    }
}
```

* We use `.leading` alignment to align all of the vertically stacked content to the leading (left) edge.
* This `VStack` will place the category name directly above the horizontal stack of articles.
* If you try to resume the Canvas preview at this point, it will look pretty terrible! This is because our `HStack` doesn't scroll, and it tries to squish all of its content onto the screen at once.

7. Add some padding to the category name, and wrap the `HStack` in a `ScrollView`
```swift
var body: some View {
    VStack(alignment: .leading) {
        Text(categoryName)
            .font(.title)
            .padding(.leading, 15)
            .padding(.top, 5)

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(articles) { article in
                    Text(article.title.prefix(10))
                }
            }
        }
    }
}
```

* The padding will give our `categoryName` some breathing room on the `.top` and `.leading` (left) edges.
* Wrapping the `HStack` in a `ScrollView` allows the content in the `HStack` to stretch out and take up as much space as it needs! Now the article titles aren't squished together.
* Our `ScrollView` specifies `.horizontal`, meaning it only scrolls horizontally. 
* `showsIndicators: false` means that the `ScrollView` won't show scroll indicators (like you would typically see on the right side of a web page).

> At this point, press the circular ▶️ button to start a live preview of the `CategoryRow` in your Canvas. You can use your cursor to swipe the `ScrollView` and see it in action! Again, click the ⏹️ button to stop the live demo.

> ** INSERT IMAGE OR GIF HERE OF THE HORIZONTAL SCROLL VIEW **

## CategoryItem
Next, we'll build a `CategoryItem` view that will display a single news article as a thumbnail and a title. Multiple `CategoryItem`s will go inside our `CategoryRow`'s horizontal `ScrollView` to display an entire category of news articles.

1. Create a new SwiftUI file in the `Views` folder called `CategoryItem.swift`

2. Add a `var` called `article` that will contain the specific `NewsArticle` to display on this card
```swift
struct CategoryItem: View {
    var article: NewsArticle
```

* When we initialize a new `CategoryItem` we will provide the specific `NewsArticle` to display in the card.

3. Update the `PreviewProvider` to initialize the `CategoryItem` with a sample `NewsArticle`
```swift
struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(article: NewsFeed.sampleData[0])
```

4. Replace the `body` of your view with the following code.
```swift
var body: some View {
    VStack(alignment: .leading) {
        article.image
            .frame(width: 155, height: 155)
            .resizable()
            .scaledToFill()
            .clipped()
            .cornerRadius(5)

        Text(article.title)
        	.lineLimit(5)
            .font(.headline)
    }
    .frame(width: 155)
    .padding(.leading, 15)
}
```
* This `VStack` is just like the one we used in `CategoryRow`. It contains an image and some `Text`. The image displays the thumbnail for the `article`, and the `Text` displays the `article`'s `title`.
* `.frame(width: 155, height: 155)` will give our image a square frame of 155 points.
* Our image is `.resizable()`, meaning it can be scaled up and down.
* `.scaledToFill()` means that the image will scale to fill the entire 155pt x 155pt frame, and `.clipped()` means that any parts of the image outside of the frame will not be visible.
* `.cornerRadius(5)` will round the corners of our image with a 5pt radius.
* On our `Text`, `.lineLimit(5)` prevents the `title` from extending beyond 5 lines. Any text beyond the 5 line limit will be truncated with a trailing `...`.
* We also specify `.frame(width: 155)` for the entire `VStack`. This restricts the entire `VStack` to a width of 155pt, so that none of the `article`'s `title` will extend beyond the edge of the image. Instead, it will wrap around. You can see this in the Canvas if you resume the preview.
* We also added `.padding` to the `.leading` (left) edge of the `VStack`. When the `CategoryItem`s are lined up horizontally, this padding will provide 15 points of space between each item, and it will also provide 15 points of space between the first card and the left edge of our phone screen. 

> Make sure to open the Canvas and resume the preview to visualize an individual `CategoryItem`!

Before we move on, your entire `CategoryItem.swift` should look like this
```swift
import SwiftUI

struct CategoryItem: View {
    var article: NewsArticle

    var body: some View {
        VStack(alignment: .leading) {
            article.image
                .frame(width: 155, height: 155)
                .resizable()
                .scaledToFill()
                .clipped()
                .cornerRadius(5)

            Text(article.title)
                .lineLimit(5)
                .font(.headline)
        }
        .frame(width: 155)
        .padding(.leading, 15)
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(article: NewsFeed.sampleData[0])
    }
}
```

## Putting It Together
At this point, we have everything we need to create a complete `CategoryRow`, so lets integrate the `CategoryItem` into the horizontal `ScrollView`.

1. Open `CategoryRow.swift`, and replace `Text(article.title.prefix(10))` with a `CategoryItem` that displays the current `article`. Your `CategoryRow.swift` should now look like this.
```swift
import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var articles: [NewsArticle]

    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.title)
                .padding(.leading, 15)
                .padding(.top, 5)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(articles) { article in
                        CategoryItem(article: article)
                    }
                }
            }
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var articles = NewsFeed.sampleData

    static var previews: some View {
        CategoryRow(categoryName: "Sports", articles: articles)
    }
}
```

> If you start another live preview in the Canvas, you should be able to see your completed `CategoryRow`! Each article should have a "card" displaying a thumbnail and a title, and the whole category of articles should scroll horizontally.

> ** INSERT IMAGE OR GIF HERE OF THE HORIZONTAL SCROLL VIEW **