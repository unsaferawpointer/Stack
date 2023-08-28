//
//  MenuItemConfiguration.swift
//  Stack
//
//  Created by Anton Cherkasov on 27.08.2023.
//

import Foundation

/// Menu item configuration
struct MenuItemConfiguration {

	/// Menu title
	let title: String

	/// Menu icon
	let iconName: String?

	/// Key equivalent
	let keyEquivalent: String

	/// Action
	let action: (() -> Void)?

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - title: Menu item title
	///    - iconName: Menu item icon
	///    - keyEquivalent: Key equivalent
	///    - action: Action by click
	init(
		title: String,
		iconName: String? = nil,
		keyEquivalent: String = "",
		action: (() -> Void)? = nil
	) {
		self.title = title
		self.iconName = iconName
		self.keyEquivalent = keyEquivalent
		self.action = action
	}
}

// MARK: - Equatable
extension MenuItemConfiguration: Equatable {

	static func == (lhs: MenuItemConfiguration, rhs: MenuItemConfiguration) -> Bool {
		return lhs.title == rhs.title
		&& lhs.iconName == rhs.iconName
		&& lhs.keyEquivalent == rhs.keyEquivalent
	}
}
