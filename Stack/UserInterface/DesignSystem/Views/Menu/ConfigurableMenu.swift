//
//  ConfigurableMenu.swift
//  Stack
//
//  Created by Anton Cherkasov on 27.08.2023.
//

import Cocoa

/// Configurable menu
final class ConfigurableMenu: NSMenu {

	/// Menu configuration
	var configuration: MenuConfiguration {
		didSet {
			removeAllItems()
			for item in configuration.items {
				configure(self, item: item)
			}
		}
	}

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - configuration: Menu configuration
	init(configuration: MenuConfiguration) {
		self.configuration = configuration
		super.init(title: "")
		configure(configuration.items)
	}

	@available(*, unavailable, message: "Use init(configuration:)")
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Helpers
private extension ConfigurableMenu {

	func configure(_ items: [MenuItem]) {
		items.forEach { item in
			configure(self, item: item)
		}
	}

	func configure(_ menu: NSMenu, item: MenuItem) {
		switch item {
		case let .menu(title, items):
			let item = NSMenuItem()
			item.title = title
			menu.addItem(item)

			let submenu = NSMenu()
			item.submenu = submenu
			items.forEach {
				configure(submenu, item: $0)
			}
		case let .menuItem(configuration):
			let item = ConfigurableMenuItem(configuration)
			menu.addItem(item)
		case .divider:
			let item = NSMenuItem.separator()
			menu.addItem(item)
		}
	}
}
