//
//  TextFieldCell.swift
//  Stack
//
//  Created by Anton Cherkasov on 26.08.2023.
//

import Cocoa
import DesignSystem

final class TextFieldCell: NSView {

	var configuration: Configuration?

	// MARK: - UI-Properties

	lazy var field = NSTextField()
}

// MARK: - TableCell
extension TextFieldCell: TableCell {

	typealias Configuration = TextFieldItem

	static var reuseIdentifier: String = "textfield_cell"

	convenience init(_ configuration: TextFieldItem) {
		self.init(frame: .zero)
		configureUserInterface()
		configureConstraints()
		updateUserInterface(configuration)
	}

	func configure(_ configuration: TextFieldItem) {
		updateUserInterface(configuration)
	}
}

// MARK: - Helpers
private extension TextFieldCell {

	func configureUserInterface() {
		field.isBezeled = false
		field.isBordered = false
		field.drawsBackground = false
		field.usesSingleLineMode = true
		field.target = self
		field.action = #selector(cellDidChange(_:))
	}

	func updateUserInterface(_ configuration: Configuration) {
		self.configuration = configuration

		field.stringValue = configuration.text
		field.placeholderString = configuration.placeholder
		field.isEditable = configuration.action != nil
		field.textColor = configuration.textColor
		field.font = NSFont.preferredFont(forTextStyle: configuration.font)
		field.alignment = configuration.alignment
	}

	func configureConstraints() {
		[field].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			addSubview($0)
		}

		NSLayoutConstraint.activate(
			[
				field.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
				field.centerYAnchor.constraint(equalTo: centerYAnchor),
				field.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
			]
		)
	}
}

// MARK: - Actions
extension TextFieldCell {

	@objc
	func cellDidChange(_ sender: NSTextField) {
		guard sender === field else {
			return
		}
		configuration?.action?(sender.stringValue)
	}
}
