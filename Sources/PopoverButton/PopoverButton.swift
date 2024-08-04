import SwiftUI

// MARK: - Popover Button

public struct PopoverButton<Content: View>: View {
    // Properties
    let action: (PopoverButtonOption) -> Void // Action
    let options: [PopoverButtonOption] // Options
    let content: Content // Content

    // State properties
    @State var defaultOptionId: Int? // Default option ID
    @State private var showPopover: Bool = false // Popover display flag

    // For ViewInspector Tests
    let inspection = Inspection<Self>()

    /// Initializer
    /// - Parameters:
    ///  - action: Action
    ///   - options: Options
    ///   - defaultOptionId: Default option ID
    ///   - content: Content
    public init(action: @escaping (PopoverButtonOption) -> Void,
                options: [PopoverButtonOption],
                defaultOptionId: Int? = nil,
                @ViewBuilder content: () -> Content) {
        self.action = action
        self.options = options
        self.defaultOptionId = defaultOptionId
        self.content = content()
    }

    public var body: some View {
        Button(action: {
            showPopover = true
        }, label: {
            content
        })
        .popover(isPresented: $showPopover) {
            VStack {
                ForEach(options, id: \.id) { option in
                    Button(action: {
                        action(option)
                        defaultOptionId = option.id
                        showPopover = false
                    }, label: {
                        HStack {
                            Text(option.title)
                                .foregroundColor(.gray)

                            // Show checkmark if the option is selected
                            if option.id == defaultOptionId {
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
        .onReceive(inspection.notice, perform: { output in
            inspection.visit(self, output) // For ViewInspector Tests
        })
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

    return PopoverButton(action: { option in
                             print("Selected option: \(option.title)")
                         },
                         options: options,
                         defaultOptionId: 2,
                         content: {
                             Image(systemName: "line.3.horizontal.decrease")
                                 .resizable()
                                 .aspectRatio(contentMode: .fit)
                                 .frame(width: 18, height: 18)
                                 .foregroundColor(.gray)
                                 .clipShape(Circle())
                         })
}
