//
//  ColumnHeader.swift
//  Stack
//
//  Created by Anton Cherkasov on 17.08.2023.
//

import Cocoa
import DesignSystem

class ColumnHeader: NSVisualEffectView {

	/// Header title
	var title: String {
		didSet {
			textfield.stringValue = title
		}
	}

	/// Header placeholder
	var placeholderString: String? {
		didSet {
			textfield.placeholderString = placeholderString
		}
	}

	var menuConfiguration: MenuConfiguration?

	var action: ((String) -> Void)?

	// MARK: - UI-Properties

	private lazy var textfield = NSTextField
		.plain()
		.fontStyle(.headline)
		.foregroundColor(.textColor)

	private lazy var menuButton: NSButton = {
		let view = NSButton(
			title: "",
			target: self,
			action: #selector(menuButtonHasBeenClicked(_:))
		)
		view.image = NSImage(systemSymbolName: "ellipsis", accessibilityDescription: nil)
		view.imagePosition = .imageOnly
		view.setButtonType(.momentaryPushIn)
		view.bezelStyle = .texturedRounded
		return view
	}()

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - title: String
	///    - placeholderString: Placeholder
	init(title: String, placeholderString: String? = nil) {
		self.title = title
		self.placeholderString = placeholderString
		super.init(frame: .zero)
		configureUserInterface()
		updateUserInterface()
		configureConstraints()
		material = .headerView
		self.blendingMode = .withinWindow
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

// MARK: - Actions
extension ColumnHeader {

	@objc
	func menuButtonHasBeenClicked(_ sender: Any) {

		guard let configuration = menuConfiguration else {
			return
		}

		let menu = ConfigurableMenu(configuration: configuration)
		menu.popUp(positioning: menu.items.first, at: menuButton.frame.origin, in: self)
	}
}

extension ColumnHeader {

	@objc
	func titleHasBeenChanged(_ sender: Any) {
		action?(textfield.stringValue)
	}
}

// MARK: - Helpers
private extension ColumnHeader {

	func configureUserInterface() {
		textfield.cell?.sendsActionOnEndEditing = true
		textfield.action = #selector(titleHasBeenChanged(_:))
		textfield.target = self
	}

	func updateUserInterface() {
		textfield.stringValue = title
		textfield.placeholderString = placeholderString
	}

	func configureConstraints() {
		[textfield, menuButton].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			addSubview($0)
		}

		NSLayoutConstraint.activate(
			[
				textfield.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
				textfield.centerYAnchor.constraint(equalTo: centerYAnchor),
				textfield.trailingAnchor.constraint(equalTo: menuButton.leadingAnchor, constant: -16),

				menuButton.centerYAnchor.constraint(equalTo: centerYAnchor),
				menuButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
			]
		)
	}
}
