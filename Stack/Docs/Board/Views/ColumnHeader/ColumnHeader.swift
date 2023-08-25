//
//  ColumnHeader.swift
//  Stack
//
//  Created by Anton Cherkasov on 17.08.2023.
//

import Cocoa
import DesignSystem

final class ColumnHeader: NSVisualEffectView {

	var configuration: Configuration?

	// MARK: - UI-Properties

	private lazy var textfield = TextField.plain()
		.fontStyle(.headline)
		.foregroundColor(.textColor)

	private lazy var menuButton = MenuButton(.empty)

	private lazy var container: NSStackView = {
		let view = NSStackView(views: [textfield, menuButton])
		view.orientation = .horizontal
		view.alignment = .centerY
		return view
	}()
}

// MARK: - ConfigurableView
extension ColumnHeader: ConfigurableView {

	typealias Configuration = HeaderConfiguration

	convenience init(_ configuration: HeaderConfiguration) {
		self.init(frame: .zero)
		configureUserInterface()
		configureConstraints()
		updateUserInterface(configuration)
	}

	func configure(_ configuration: HeaderConfiguration) {
		updateUserInterface(configuration)
	}
}

// MARK: - Helpers
private extension ColumnHeader {

	func configureUserInterface() {
		material = .headerView
		blendingMode = .withinWindow
	}

	func updateUserInterface(_ configuration: Configuration) {
		self.configuration = configuration

		textfield.configure(configuration.title)
		menuButton.configure(configuration.button)
	}

	func configureConstraints() {
		container.attachEdges([.leading, .trailing], toView: self, inset: 16)
		container.attachEdges([.top, .bottom], toView: self)
	}
}

// MARK: - NSTextFieldDelegate
extension ColumnHeader: NSTextFieldDelegate {

	func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
		if commandSelector == #selector(insertNewline(_:)) {
			window?.makeFirstResponder(nil)
			return true
		}
		return false
	}
}
