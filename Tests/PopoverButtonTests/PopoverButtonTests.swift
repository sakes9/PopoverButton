@testable import PopoverButton
import SwiftUI
import ViewInspector
import XCTest

final class PopoverButtonTests: XCTestCase {
    /// Test Popover Button
    func testPopoverButtonElement() throws {
        let options = [
            PopoverButtonOption(id: 1, title: "Option 1"),
            PopoverButtonOption(id: 2, title: "Option 2"),
            PopoverButtonOption(id: 3, title: "Option 3")
        ]
        
        let sut = PopoverButton(action: { _ in }, options: options, selectedOptionId: .constant(2)) {
            Text("Popover Button")
        }
        
        let inspection = try sut.inspect()
        
        let content = try inspection.find(text: "Popover Button").string()
        XCTAssertEqual(content, "Popover Button", "Content should be set to 'Popover Button'")
    }
}
