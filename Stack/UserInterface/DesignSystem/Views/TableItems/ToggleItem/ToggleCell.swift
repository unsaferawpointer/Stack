//
//  ToggleCell.swift
//  Stack
//
//  Created by Anton Cherkasov on 26.08.2023.
//

import Cocoa
import DesignSystem

final class ToggleCell: NSView {

	var configuration: Configuration?

	// MARK: - UI-Properties

	lazy var cell = NSButton.toggle()
}

// MARK: - TableCell
extension ToggleCell: TableCell {

	static var reuseIdentifier: String = "toggle_cell"

	typealias Configuration = ToggleItem

	convenience init(_ configuration: ToggleItem) {
		self.init(frame: .zero)
		configureUserInterface()
		configureConstraints()
		updateUserInterface(configuration)
	}

	func configure(_ configuration: ToggleItem) {
		updateUserInterface(configuration)
	}
}

// MARK: - Helpers
private extension ToggleCell {

	func configureUserInterface() {
		cell.target = self
		cell.action = #selector(cellHasBeenClicked(_:))
	}

	func updateUserInterface(_ configuration: Configuration) {
		self.configuration = configuration
		self.cell.state = configuration.isEnable ? .on : .off
		self.cell.image = NSImage(
			systemSymbolName: configuration.imageName,
			accessibilityDescription: nil
		)
		self.cell.alternateImage = NSImage(
			systemSymbolName: configuration.alternativeImage,
			accessibilityDescription: nil
		)
		cell.contentTintColor = configuration.isEnable
									? configuration.tintColor
									: .tertiaryLabelColor
	}

	func configureConstraints() {
		[cell].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			addSubview($0)
		}

		NSLayoutConstraint.activate(
			[
				cell.centerXAnchor.constraint(equalTo: centerXAnchor),
				cell.centerYAnchor.constraint(equalTo: centerYAnchor)
			]
		)
	}
}

// MARK: - Actions
extension ToggleCell {

	@objc
	func cellHasBeenClicked(_ sender: NSButton) {
		configuration?.isEnable = sender.state == .on
		guard let configuration else {
			return
		}
		updateUserInterface(configuration)
		configuration.action?(sender.state == .on)
	}
}
