import SwiftUI

// MARK: - Delegate

protocol PopoverButtonDelegate: AnyObject {
    /// Called when an option is selected
    /// - Parameter option: Selected option
    func onSelectedPopoverOption(option: PopoverButtonOption)
}

// MARK: - Popover Button

struct PopoverButton<Content: View>: View {
    // Properties
    let options: [PopoverButtonOption] // Options
    weak var delegate: PopoverButtonDelegate? // Delegate
    let content: Content // Content

    // State properties
    @State var selectedOptionId: Int? // Selected option ID
    @State private var showPopover: Bool = false // Popover display flag

    /// Initializer
    /// - Parameters:
    ///   - options: Options
    ///   - selectedOptionId: Selected option ID
    ///   - delegate: Delegate
    ///   - content: Content
    init(options: [PopoverButtonOption],
         selectedOptionId: Int? = nil,
         delegate: PopoverButtonDelegate? = nil,
         @ViewBuilder content: () -> Content) {
        self.options = options
        self.selectedOptionId = selectedOptionId
        self.delegate = delegate
        self.content = content()
    }

    var body: some View {
        Button(action: {
            showPopover = true
        }, label: {
            content
        })
        .popover(isPresented: $showPopover) {
            VStack {
                ForEach(options, id: \.id) { option in
                    Button(action: {
                        delegate?.onSelectedPopoverOption(option: option)
                        selectedOptionId = option.id
                        showPopover = false
                    }, label: {
                        HStack {
                            Text(option.title)
                                .foregroundColor(.gray)

                            // Show checkmark if the option is selected
                            if option.id == selectedOptionId {
                                Spacer()
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    })

                    // Show divider if it's not the last option
                    if option.id != options.last?.id {
                        Divider()
                    }
                }
            }
            .padding()
            .presentationCompactAdaptation(PresentationAdaptation.popover) // Use popover presentation
        }
    }
}

// MARK: - Preview

#Preview {
    let options: [PopoverButtonOption] = [
        PopoverButtonOption(id: 1, title: "Price: High to Low"),
        PopoverButtonOption(id: 2, title: "Price: Low to High"),
        PopoverButtonOption(id: 3, title: "Newest First"),
        PopoverButtonOption(id: 4, title: "Oldest First")
    ]

    return PopoverButton(options: options, selectedOptionId: 2, content: {
        Image(systemName: "line.3.horizontal.decrease")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 18, height: 18)
            .foregroundColor(.gray)
            .clipShape(Circle())
    })
}
