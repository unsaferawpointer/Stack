//
//  TextField.swift
//  Stack
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import Cocoa
import DesignSystem

final class TextField: NSTextField {

	var configuration: Configuration?
}

// MARK: - ConfigurableView
extension TextField: ConfigurableView {

	typealias Configuration = TextfieldConfiguration

	convenience init(_ configuration: Configuration) {
		self.init(frame: .zero)
		configureUserInterface()
		updateInterface(configuration)
	}

	func configure(_ configuration: Configuration) {
		updateInterface(configuration)
	}
}

// MARK: - Helpers
private extension TextField {

	func configureUserInterface() {
		cell?.sendsActionOnEndEditing = true
		action = #selector(textHasBeenChanged(_:))
		target = self; delegate = self
	}

	func updateInterface(_ configuration: Configuration) {
		self.configuration = configuration

		stringValue = configuration.text

	}
}

// MARK: - Actions
extension TextField {

	@objc
	func textHasBeenChanged(_ sender: Any) {
		guard let configuration else {
			return
		}
		configuration.action?(stringValue)
	}
}

// MARK: - NSTextFieldDelegate
extension TextField: NSTextFieldDelegate {

	func control(
		_ control: NSControl,
		textView: NSTextView,
		doCommandBy commandSelector: Selector
	) -> Bool {
		if commandSelector == #selector(insertNewline(_:)) {
			window?.makeFirstResponder(nil)
			return true
		}
		return false
	}
}
