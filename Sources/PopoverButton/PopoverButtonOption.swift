//
//  PopoverButtonOption.swift
//
//
//  Created by sake on 2024/08/03.
//

import Foundation

// MARK: - Popover Button Option

public struct PopoverButtonOption {
    public let id: Int // Identifier
    public let title: String // Title

    public init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}
