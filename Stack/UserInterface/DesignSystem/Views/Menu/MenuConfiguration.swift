//
//  MenuConfiguration.swift
//  Stack
//
//  Created by Anton Cherkasov on 27.08.2023.
//

import Foundation

enum MenuItem: Equatable {
	case menu(_ title: String, items: [MenuItem])
	case menuItem(_ configuration: MenuItemConfiguration)
	case divider
}

/// Menu configuration
struct MenuConfiguration {

	/// Menu items
	public var items: [MenuItem]

	public init(items: [MenuItem]) {
		self.items = items
	}
}

// MARK: - Public interface
extension MenuConfiguration {

	/// Add menu item
	func addItem(
		_ title: String,
		iconName: String? = nil,
		keyEquivalent: String = "",
		action: (() -> Void)?
	) -> Self {

		var items = self.items
		let configuratiion = MenuItemConfiguration(
			title: title,
			iconName: iconName,
			keyEquivalent: keyEquivalent,
			action: action
		)
		let new: MenuItem = .menuItem(configuratiion)
		items.append(new)
		return MenuConfiguration(items: items)
	}

	/// Add menu as menu item
	func addMenu<S: Sequence>(_ title: String, data: S, block: (S.Element) -> MenuItem) -> Self {
		var items =  self.items
		let menu: MenuItem = .menu(title, items: data.map(block))
		items.append(menu)
		return MenuConfiguration(items: items)
	}

	/// Add divider to menu
	func addDivider() -> Self {
		var items =  self.items
		items.append(.divider)
		return MenuConfiguration(items: items)
	}
}

// MARK: - Equatable
extension MenuConfiguration: Equatable { }

