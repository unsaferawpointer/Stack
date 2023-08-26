//
//  TextFieldItem.swift
//  Stack
//
//  Created by Anton Cherkasov on 26.08.2023.
//

import Cocoa

struct TextFieldItem {

	var text: String

	var font: NSFont.TextStyle

	var textColor: NSColor = .controlTextColor

	var placeholder: String

	var alignment: NSTextAlignment = .left

	var action: ((String) -> Void)?

}

// MARK: - TableItem
extension TextFieldItem: TableItem {

	typealias Cell = TextFieldCell
}

// MARK: - Equatable
extension TextFieldItem: Equatable {

	static func == (lhs: TextFieldItem, rhs: TextFieldItem) -> Bool {
		return lhs.text == rhs.text
		&& lhs.font == rhs.font
		&& lhs.textColor == rhs.textColor
		&& lhs.placeholder == rhs.placeholder
		&& lhs.alignment == rhs.alignment
	}
}
