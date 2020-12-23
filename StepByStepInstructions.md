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

> At this point, press the circular ▶️ button directly above the simulator in your Canvas. This will start a live preview of the `CategoryRow` in your Canvas. You can use your cursor to swipe the `ScrollView` and see it in action! Click the ⏹️ button to stop the live demo.

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
