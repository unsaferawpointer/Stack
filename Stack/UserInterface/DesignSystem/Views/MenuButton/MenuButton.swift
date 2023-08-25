//
//  MenuButton.swift
//  Stack
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import Cocoa
import DesignSystem

final class MenuButton: NSButton {

	var configuration: Configuration?
}

// MARK: - ConfigurableView
extension MenuButton: ConfigurableView {

	typealias Configuration = MenuButtonConfiguration

	convenience init(_ configuration: MenuButtonConfiguration) {
		self.init(frame: .zero)
		configureUserInterface()
		updateInterface(configuration)
	}

	func configure(_ configuration: MenuButtonConfiguration) {
		updateInterface(configuration)
	}
}

// MARK: - Helpers
private extension MenuButton {

	func configureUserInterface() {
		self.action = #selector(click(_:))
		self.target = self

		self.isBordered = true
		self.imagePosition = .imageOnly
		self.setButtonType(.momentaryPushIn)
		self.showsBorderOnlyWhileMouseInside = true
		self.bezelStyle = .texturedRounded
	}

	func updateInterface(_ configuration: Configuration) {
		self.configuration = configuration
		self.image = NSImage(
			systemSymbolName: configuration.imageName,
			accessibilityDescription: nil
		)
	}

	func showMenu() {
		guard let configuration else {
			return
		}
		let menu = ConfigurableMenu(configuration: configuration.menu)
		menu.popUp(positioning: menu.items.first, at: frame.origin, in: superview)
	}
}

// MARK: - Actions
extension MenuButton {

	@objc
	func click(_ sender: Any) {
		showMenu()
	}
}
