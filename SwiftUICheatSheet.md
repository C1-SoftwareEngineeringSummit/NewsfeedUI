_Most things taken from [SimpleBoilerplates](https://github.com/SimpleBoilerplates/SwiftUI-Cheat-Sheet#view), [**\*\*\***swiftui.com](https://fuckingswiftui.com/#swiftui-views-and-controls), and Apple's [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/views-and-controls)._

_Order matters when applying view modifiers! If you aren't getting the results that you want, try applying the modifiers in a different order._

# View

A type that represents part of your app’s user interface and provides modifiers that you use to configure views. This is a protocol, so there is no concrete `View` type. Instead, most visible pieces of your app will be a `View`. For example, `Text`, `Image`, and even `Color` are a type of `View`. Any modifiers in this section can be applied to any `View` in your app.

## Modifiers

### Layout

Use [`frame(width:height:alignment:)`](<https://developer.apple.com/documentation/swiftui/view/frame(width:height:alignment:)>) to specify a fixed size for a view's width, height, or both. Alignment can also be provided, but it will default to `.center` if not specified. Other alignments can be found [here](https://developer.apple.com/documentation/swiftui/alignment).

```swift
Color.red
    .frame(width: 200, height: 100, alignment: .center)
```

Use [`.padding(_:_:)`](<https://developer.apple.com/documentation/swiftui/view/padding(_:_:)>) to add padding inside of the specified edges. The first parameter is an `Edge.Set`, which contains the edges that you want to pad. The second parameter is the amount of padding to apply. Some built-in values of `Edge.Set` are available [here](https://developer.apple.com/documentation/swiftui/edge/set).

```swift
Text("Hello world")
    .padding([.bottom, .top, .trailing], 20)
```

### Borders

Add a border around a view using the [`border(_:width:)`](<https://developer.apple.com/documentation/swiftui/view/border(_:width:)>) modifier. The first parameter in this modifier is a [`ShapeStyle`](https://developer.apple.com/documentation/swiftui/shapestyle), but it's easiest to provide a Color for this parameter. See all available colors [here](https://developer.apple.com/documentation/swiftui/color).

```swift
Text("Hello world")
    .border(Color.purple, width: 4)
```

### Overlays and Backgrounds

Use [`overlay(alignment:content:)`](<https://developer.apple.com/documentation/swiftui/view/overlay(alignment:content:)>) to layer views on top of each other. The views that you provide inside of the overlay function will be placed on top of the view on which you call the overlay function. For example, this code block produces a blue square with a black circle on top of it. If you don't specify an alignment, it defaults to `.center`. Other alignments can be found [here](https://developer.apple.com/documentation/swiftui/alignment).

```swift
Color.blue
    .frame(width: 200, height: 200)
    .overlay {
        Circle()
            .frame(width: 100, height: 100)
    }
```

Use [`background(alignment:content:)`](<https://developer.apple.com/documentation/swiftui/view/background(alignment:content:)>) to layer views behind the view on which you call this function. For example, this code block produces a green background behind some text. Again, the alignment defaults to `.center`, and other alignments can be found [here](https://developer.apple.com/documentation/swiftui/alignment).

```swift
Text("Hello world")
    .background(alignment: .center) {
        Color.green
    }
```

### Color

Set the foreground color of a view using the [`foregroundColor(_:)`](<https://developer.apple.com/documentation/swiftui/view/foregroundcolor(_:)>) modifier. Passing in `nil` will remove any custom foreground color that was previously applied. See all available colors [here](https://developer.apple.com/documentation/swiftui/color).

```swift
Text("Hello world")
    .foregroundColor(.cyan)
```

You can also change a view to grayscale using the [`grayscale(_:)`](<https://developer.apple.com/documentation/swiftui/view/grayscale(_:)>) modifier. The parameter ranges from `0.0` to `1.0`, and it controls the intensity of the effect. `0.0` is more colorful, and `1.0` is more grayscale.

```swift
Color.red
    .frame(width: 60, height: 60)
    .grayscale(0.5)
```

[`colorInvert()`](<https://developer.apple.com/documentation/swiftui/view/colorinvert()>) is a simple no-parameter modifier that inverts all of the colors in a view.

```swift
 Color.red
    .frame(width: 100, height: 100)
    .colorInvert()
```

### Corner Radius

Use [`cornerRadius(_:antialiased:)`](<https://developer.apple.com/documentation/swiftui/view/cornerradius(_:antialiased:)>) to apply rounded corners to your view. The first parameter is a float that determines the radius of the rounded corners. The `antialiased` parameter defaults to `true`, and typically you can omit this argument.

```swift
Color.red
    .frame(width: 200, height: 100)
    .cornerRadius(25)
```

### Clipping to a Shape

[`clipShape(_:style:)`](<https://developer.apple.com/documentation/swiftui/view/clipshape(_:style:)>) will clip your view to the shape that you specify. This means that only the portion of the view within the specified shape will be visible. For example, the following code block clips the text to the provided circle shape. Any part of the text outside of the circle is not visible.

```swift
Text("Hello world")
    .frame(width: 175, height: 100)
    .foregroundColor(Color.white)
    .background(Color.black)
    .clipShape(Circle())
```

### 3D Rotations

[`rotation3DEffect(_:axis:anchor:anchorZ:perspective:)`](<https://developer.apple.com/documentation/swiftui/view/rotation3deffect(_:axis:anchor:anchorz:perspective:)>) is a little more complicated, but it can produce some really cool 3D effects. The first parameter is the angle to rotate the view. You can specify an angle in degrees or radians by using one of the initializers listed [here](https://developer.apple.com/documentation/swiftui/angle). `axis` is a 3-tuple with elements `x`, `y`, and `z` that specifies the axis of rotation in 3D space. For example, `(x: 1.0, y: 0.0, z: 0.0)` would specify the x-axis. `anchor` and `anchorZ` define the point around which the rotation is centered, and `perspective` sets the vanishing point. `anchor`, `anchorZ`, and `perspective` have default values, and don't need to be set explicitly to achieve a 3D rotation.

```swift
Text("Hello world")
    .rotation3DEffect(.degrees(45), axis: (x: 0.0, y: 1.0, z: 0.0))
```

### Blur

Use [`blur(radius:opaque:)`](<https://developer.apple.com/documentation/swiftui/view/blur(radius:opaque:)>) to apply a Gaussian blur to a view. A larger `radius` will result in a more diffuse blur, and the `opaque` Bool controls whether or not the blur is opaque. This value defaults to `false`, resulting in a transparent blur effect.

```swift
Text("Hello world")
    .blur(radius: 2.0)
```

### Opacity

Use the [`opacity(_:)`](<https://developer.apple.com/documentation/swiftui/view/opacity(_:)>) modifier to set the transparency of your view. The parameter in this modifier ranges from fully transparent at `0` to fully opaque at `1`. The following creates a yellow square that is 50% transparent.

```swift
Color.yellow
    .frame(width: 100, height: 100)
    .opacity(0.5)
```

### Shadows

Use [`shadow(color:radius:x:y:)`](<https://developer.apple.com/documentation/swiftui/view/shadow(color:radius:x:y:)>) to add a shadow to a view. You can choose a [`Color`](https://developer.apple.com/documentation/swiftui/color) for your shadow. If you are going for a natural shadow, `.gray` or `.black` work best. `radius` specifies the shadow's size. `x` and `y` determine the x-offset and y-offset for the shadow relative to the view.

```swift
Color.red
    .frame(width: 60, height: 60)
    .shadow(color: Color.gray, radius: 1.0, x: 5, y: 5)
```

# Text

A view that displays one or more lines of read-only text.

```swift
Text("Hello world")
```

## Modifiers

A lot of the modifiers listed under the "View" section above will work really well with Text, even if they are not explicitly listed in this section.

### Font

Choose a standard font for your Text with the [`font(_:)`](<https://developer.apple.com/documentation/swiftui/text/font(_:)>) modifier. Some standard font options include `.largeTitle`, `.title2`, `.headline`, and `.subheadline`. See all standard font options [here](https://developer.apple.com/documentation/swiftui/font).

```swift
Text("Hello world")
    .font(.largeTitle)
```

Apply a customized system font if you want a non-standard font. See all font weights [here](https://developer.apple.com/documentation/swiftui/font/weight). See all font designs [here](https://developer.apple.com/documentation/swiftui/font/design).

```swift
Text("Hello world")
    .font(.system(size: 12, weight: .light, design: .serif))
```

### Bold, Italicized, and Underlined Text

Apply [bold](<https://developer.apple.com/documentation/swiftui/text/bold()>), [italicized](<https://developer.apple.com/documentation/swiftui/text/italic()>), or underlined text with their respective modifiers. [`underline(_:color:)`](<https://developer.apple.com/documentation/swiftui/text/underline(_:color:)>) allows you to specify a color for the underline. See all available colors [here](https://developer.apple.com/documentation/swiftui/color).

```swift
Text("Hello world")
    .bold()
    .italic()
    .underline(color: .blue)
```

### Color

Change text color using [`foregroundColor(_:)`](<https://developer.apple.com/documentation/swiftui/text/foregroundcolor(_:)>). See all available colors [here](https://developer.apple.com/documentation/swiftui/color).

```swift
Text("Hello world")
    .foregroundColor(.teal)
```

### Layout and Alignment

Limit the number of lines with the [`lineLimit(_:)`](<https://developer.apple.com/documentation/swiftui/text/linelimit(_:)>). Set this value to `nil` if you don't want a line limit.

```swift
Text("Hello world")
    .lineLimit(2)
```

Set the line spacing with the [`lineSpacing(_:)`](<https://developer.apple.com/documentation/swiftui/text/linespacing(_:)>) modifier.

```swift
Text("Hello world")
    .lineSpacing(20.5)
```

Set the text alignment with [`multilineTextAlignment(_:)`](<https://developer.apple.com/documentation/swiftui/text/multilinetextalignment(_:)>). See all alignment values [here](https://developer.apple.com/documentation/swiftui/textalignment).

```swift
Text("Hello world")
    .multilineTextAlignment(.trailing)
```

# Image

A view that displays an image.

## System Images

To use Apple's SF Symbols framework, use [`init(systemName:)`](<https://developer.apple.com/documentation/swiftui/image/init(systemname:)>) to create your image. Make sure to provide the name of an actual SF Symbol, like `"clock.fill"`. An SF Symbols reference list can be found [here](https://sfsymbols.com/).

```swift
Image(systemName: "clock.fill")
```

## Modifiers

A lot of the modifiers listed under the "View" section above will work really well with Images, even if they are not explicitly listed in this section.

### Colors

Use [`foregroundColor(_:)`](<https://developer.apple.com/documentation/swiftui/image/foregroundcolor(_:)>) to set the color of the image. This works best for SF Symbols where the entire symbol will be rendered in the color that you specify. See all available colors [here](https://developer.apple.com/documentation/swiftui/color).

```swift
Image(systemName: "clock.fill")
    .foregroundColor(.red)
```

### Font

[Fonts](<https://developer.apple.com/documentation/swiftui/image/font(_:)>) can also be applied to images. This mostly applies to system images from the SF Symbols list, but specifying a font will affect the size of the rendered image. The following renders the raincloud image as if it were part of a `.largeTitle`. See all standard font options [here](https://developer.apple.com/documentation/swiftui/font).

```swift
Image(systemName: "cloud.heavyrain.fill")
    .font(.largeTitle)
```

### Aspect Ratio

Use [`aspectRatio(_:contentMode:)`](<https://developer.apple.com/documentation/swiftui/image/aspectratio(_:contentmode:)-46dre>) to constrain an image's dimensions. The first parameter is a ratio of width / height for the resulting view. Using `nil` or omitting this argument will preserve the existing ratio. The contentMode can be either `.fill` or `.fit`. `.fill` will stretch the image whereas `.fit` will not.

```swift
Image(systemName: "cloud.heavyrain.fill")
    .aspectRatio(0.75, contentMode: .fit)
```

# Button

A control that initiates an action.

## Modifiers

A lot of the modifiers listed under the "View" section above will work really well with Buttons, even if they are not explicitly listed in this section.

### Styles

Use the [`buttonStyle(_:)`](<https://developer.apple.com/documentation/swiftui/view/buttonstyle(_:)-66fbx>) modifier to apply a style to a button. There are some built-in button styles for use [here](https://developer.apple.com/documentation/swiftui/primitivebuttonstyle). For example, `.bordered`, `.borderedProminent`, and `.borderless`.

```swift
Button("Button", action: {})
    .buttonStyle(.bordered)
```

### Borders

Use [`buttonBorderShape(_:)`](<https://developer.apple.com/documentation/swiftui/menu/buttonbordershape(_:)>) to set the shape of the button's border. This modifier has a visible effect only when using the `.bordered` or `.borderedProminent` button styles. The list of available ButtonBorderShapes is [here](https://developer.apple.com/documentation/swiftui/buttonbordershape).

```swift
Button("Button", action: {})
    .buttonStyle(.bordered)
    .buttonBorderShape(.capsule)
```

# HStack

A view that arranges its children in in a horizontal line.

## Initializer

[`init(alignment:spacing:content:)`](<https://developer.apple.com/documentation/swiftui/hstack/init(alignment:spacing:content:)>) allows you to specify the `alignment` as well as the `spacing` for this `HStack`. `alignment` defaults to `.center`, but it can be any of these [`VerticalAlignment` values ](https://developer.apple.com/documentation/swiftui/verticalalignment) as well. This will determine the alignment along the vertical axis. `spacing` determines how much space there is between children.

```swift
HStack(alignment: .top, spacing: 10) {
    ForEach(1...5, id: \.self) {
        Text("Item \($0)")
    }
}
```

## Modifiers

There aren't many interesting modifiers specifically for `HStacks`, but you can apply any of the modifiers listed in the "View" section above to a `HStack`.

# VStack

A view that arranges its children in a vertical line.

## Initializer

[`init(alignment:spacing:content:)`](<https://developer.apple.com/documentation/swiftui/vstack/init(alignment:spacing:content:)>) allows you to specify the `alignment` and `spacing` of this `VStack`. `alignment` again defaults to `.center`, but you can choose any other [`HorizontalAlignment` value](https://developer.apple.com/documentation/swiftui/horizontalalignment) as well. This determines alignment along the horizontal axis. `spacing` again determines the spacing between children.

```swift
VStack(alignment: .leading, spacing: 10) {
    ForEach(1...10, id: \.self) {
        Text("Item \($0)")
    }
}
```

## Modifiers

There aren't many interesting modifiers specifically for `VStacks`, but you can apply any of the modifiers listed in the "View" section above to a `VStack`.

# ZStack

A view that overlays its children, aligning them in both axes.

## Initializer

[`init(alignment:content:)`](<https://developer.apple.com/documentation/swiftui/zstack/init(alignment:content:)>) allows you to specify the `alignment` for the `ZStack`. `alignment` again defaults to `.center`, but other [`Alignment` values](https://developer.apple.com/documentation/swiftui/alignment) are available too. These `Alignment` values allow you to specify the alignment along both the vertical and horizontal axes.

```swift
ZStack(alignment: .bottomLeading) {
    Rectangle()
        .fill(Color.red)
        .frame(width: 100, height: 50)
    Rectangle()
        .fill(Color.blue)
        .frame(width:50, height: 100)
}
```

## Modifiers

There aren't many interesting modifiers specifically for `ZStacks`, but you can apply any of the modifiers listed in the "View" section above to a `ZStack`.

# ScrollView

A scrollable view.

## Initializer

[`init(_:showsIndicators:content:)`](<https://developer.apple.com/documentation/swiftui/scrollview/init(_:showsindicators:content:)>) allows you to specify the scrollable axis and visible or invisible scroll indicators. The default scrollable axis is `.vertical`, but you can also specify `.horizontal`, or an [`Axis.Set`](https://developer.apple.com/documentation/swiftui/axis/set) containing both. `showsIndicators` is `true` by default.

```swift
ScrollView([.horizontal, .vertical], showsIndicators: false) {
    HStack {
        ForEach(0..<100) {
            Text("Row \($0)")
        }
    }
}
```

## Modifiers

There aren't many interesting modifiers specifically for `ScrollViews`, but you can apply any of the modifiers listed in the "View" section above to a `ScrollView`.

# TabView

A view that switches between multiple child views using interactive user interface elements.

## Modifiers

A lot of the modifiers listed under the "View" section above will work really well with TabViews, even if they are not explicitly listed in this section.

### Styles

Use [`tabViewStyle(_:)`](<https://developer.apple.com/documentation/swiftui/view/tabviewstyle(_:)>) to set the style of this TabView. The list of available styles can be found [here](https://developer.apple.com/documentation/swiftui/tabviewstyle). For example, you could set the style to `.page`.

```swift
TabView {
    Text("The First Tab")
        .badge(10)
        .tabItem {
            Image(systemName: "1.square.fill")
            Text("First")
        }
}
.tabViewStyle(.page)
```

Use [`indexViewStyle(_:)`](<https://developer.apple.com/documentation/swiftui/text/indexviewstyle(_:)>) to style the index for the TabView. An example of an index is on your iOS home screen: the index is the row of dots above the dock that indicate which page you are on. The list of available index styles is [here](https://developer.apple.com/documentation/swiftui/indexviewstyle).

```swift
TabView {
    Text("The First Tab")
        .badge(10)
        .tabItem {
            Image(systemName: "1.square.fill")
            Text("First")
        }
}
.tabViewStyle(.page)
.indexViewStyle(.page(backgroundDisplayMode: .always))
```
