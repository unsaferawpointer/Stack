//
//  NSButton+Extension.swift
//  Stack
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import Cocoa

extension NSButton {

	static func menu() -> NSButton {
		let view = NSButton()
		view.isBordered = true
		view.imagePosition = .imageOnly
		view.setButtonType(.momentaryPushIn)
		view.showsBorderOnlyWhileMouseInside = true
		view.bezelStyle = .texturedRounded
		return view
	}

	static func toggle() -> NSButton {
		let view = NSButton()
		view.setButtonType(.toggle)
		view.isBordered = false
		view.bezelStyle = .texturedRounded
		view.imagePosition = .imageOnly
		view.cell?.isBezeled = false
		return view
	}

	func withImage(systemName: String) -> Self {
		self.image = NSImage(
			systemSymbolName: systemName,
			accessibilityDescription: nil
		)
		return self
	}

	func withTarget(_ target: AnyObject?) -> Self {
		self.target = target
		return self
	}

	func withAction(_ action: Selector) -> Self {
		self.action = action
		return self
	}
}
