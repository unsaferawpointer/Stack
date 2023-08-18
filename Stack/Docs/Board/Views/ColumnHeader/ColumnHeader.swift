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

	// MARK: - UI-Properties

	private lazy var textfield = NSTextField
		.plain()
		.fontStyle(.headline)
		.foregroundColor(.textColor)

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
		configureConstraints()
		material = .headerView
		self.blendingMode = .withinWindow
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

// MARK: - Helpers
private extension ColumnHeader {

	func configureUserInterface() {
		textfield.stringValue = title
		textfield.placeholderString = placeholderString
	}

	func configureConstraints() {
		[textfield].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			addSubview($0)
		}

		NSLayoutConstraint.activate(
			[
				textfield.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
				textfield.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
				textfield.centerYAnchor.constraint(equalTo: centerYAnchor)
			]
		)
	}
}
