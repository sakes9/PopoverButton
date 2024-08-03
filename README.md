# Popover Button

`PopoverButton` is a SwiftUI component that turns any view into a button, which, when tapped, displays a popover. The items to be displayed in the popover are passed from the outside and displayed in a list format.

<img src="images/sample_01.png" alt="sample" width="200">
<img src="images/sample_02.png" alt="sample" width="200">

## Features

- Turns any view into a button and displays a list-style popover.

## Installation

To install `PopoverButton` using Swift Package Manager, add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/sakes9/PopoverButton.git", from: "{{ version }}")
]
```

Then, add `PopoverButton` as a dependency to your target:

```swift
.target(
    name: "YourTargetName",
    dependencies: ["PopoverButton"]
)
```

## Usage

Here's a basic example of how to use `PopoverButton` in your SwiftUI view:

```swift
import PopoverButton
import SwiftUI

struct ContentView: View {
    let viewModel = ContentViewModel()

    let options: [PopoverButtonOption] = [
        PopoverButtonOption(id: 1, title: "Price: High to Low"),
        PopoverButtonOption(id: 2, title: "Price: Low to High"),
        PopoverButtonOption(id: 3, title: "Newest First"),
        PopoverButtonOption(id: 4, title: "Oldest First")
    ]

    var body: some View {
        HStack {
            Text("Sort button")
            PopoverButton(options: options,
                          selectedOptionId: 2,
                          delegate: viewModel,
                          content: {
                              Image(systemName: "line.3.horizontal.decrease")
                                  .resizable()
                                  .aspectRatio(contentMode: .fit)
                                  .frame(width: 30, height: 30)
                                  .foregroundColor(.gray)
                                  .clipShape(Circle())
                          })
        }
        .padding(.horizontal)
    }
}

class ContentViewModel: PopoverButtonDelegate {
    func onSelectedPopoverOption(option: PopoverButtonOption) {
        print("Selected option: \(option.title)")
    }
}
```

### Parameters

- `options`: An array of `PopoverButtonOption` instances containing the options to display in the popover.
- selectedOptionId: The ID of the selected option. Default is `nil`.
- `delegate`: An instance of `PopoverButtonDelegate` to handle the selection of an option.
