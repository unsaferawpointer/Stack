//
//  TextField+Extension.swift
//  Stack
//
//  Created by Anton Cherkasov on 17.08.2023.
//

import Cocoa

extension TextField {

	static func plain() -> TextField {
		let field = TextField(.empty)
		field.drawsBackground = false
		field.isBezeled = false
		field.cell?.truncatesLastVisibleLine = true
		field.cell?.lineBreakMode = .byTruncatingTail
		return field
	}

	func fontStyle(_ style: NSFont.TextStyle) -> Self {
		self.font = NSFont.preferredFont(forTextStyle: style)
		return self
	}

	func foregroundColor(_ color: NSColor) -> Self {
		self.textColor = color
		return self
	}
}
