//
//  Category.swift
//  Stack
//
//  Created by Anton Cherkasov on 14.08.2023.
//

import Foundation

/// Card category
struct Category: OptionSet {
	var rawValue: Int
}

// MARK: - Codable
extension Category: Codable { }

// MARK: - Default categories
extension Category {
	static let urgent = Category(rawValue: 1 << 0)
}
