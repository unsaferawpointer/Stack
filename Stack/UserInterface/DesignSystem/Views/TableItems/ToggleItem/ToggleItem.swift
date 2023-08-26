//
//  ToggleItem.swift
//  Stack
//
//  Created by Anton Cherkasov on 26.08.2023.
//

import Cocoa

struct ToggleItem {

	var imageName: String

	var alternativeImage: String

	var tintColor: NSColor = .controlAccentColor

	var isEnable: Bool = false

	var action: ((Bool) -> Void)?
}

// MARK: - TableItem
extension ToggleItem: TableItem {
	typealias Cell = ToggleCell
}

// MARK: - Equatable
extension ToggleItem: Equatable {

	static func == (lhs: ToggleItem, rhs: ToggleItem) -> Bool {
		return lhs.imageName == rhs.imageName
		&& lhs.alternativeImage == rhs.alternativeImage
		&& lhs.tintColor == rhs.tintColor
		&& lhs.isEnable == rhs.isEnable
	}
}
