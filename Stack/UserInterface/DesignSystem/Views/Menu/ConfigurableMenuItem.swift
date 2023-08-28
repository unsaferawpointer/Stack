//
//  ConfigurableMenuItem.swift
//  Stack
//
//  Created by Anton Cherkasov on 27.08.2023.
//

import Cocoa

final class ConfigurableMenuItem: NSMenuItem {

	let configuraion: MenuItemConfiguration

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - configuration: Menu configuration
	init(_ configuraion: MenuItemConfiguration) {
		self.configuraion = configuraion
		super.init(
			title: configuraion.title,
			action: #selector(menuHasBeenClicked(_:)),
			keyEquivalent: configuraion.keyEquivalent
		)
		self.image = NSImage(systemSymbolName: configuraion.iconName)
		self.isEnabled = configuraion.action != nil
		self.target = self
	}

	@available(*, unavailable, message: "Use init(model:)")
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Actions
extension ConfigurableMenuItem {

	@objc
	func menuHasBeenClicked(_ sender: Any) {
		configuraion.action?()
	}
}
