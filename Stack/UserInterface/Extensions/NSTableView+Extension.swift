//
//  NSTableView+Extension.swift
//  Stack
//
//  Created by Anton Cherkasov on 26.08.2023.
//

import Cocoa

extension NSTableView {

	@discardableResult
	func addColumn(
		_ identifier: NSUserInterfaceItemIdentifier,
		withTitle title: String,
		style: ColumnStyle
	) -> Self {
		let column = NSTableColumn(identifier: identifier)

		if let width = style.minWidth {
			column.minWidth = width
		}
		if let width = style.maxWidth {
			column.maxWidth = width
		}
		column.title = title
		if let alignment = style.alignment {
			column.headerCell.alignment = alignment
		}
		column.resizingMask = .autoresizingMask
		addTableColumn(column)
		return self
	}

	enum ColumnStyle {
		case flexible(min: CGFloat?, max: CGFloat?)
		case toggle
	}
}

extension NSTableView.ColumnStyle {

	var alignment: NSTextAlignment? {
		switch self {
		case .flexible:
			return nil
		case .toggle:
			return .center
		}
	}

	var minWidth: CGFloat? {
		switch self {
		case .flexible(let min, _):
			return min
		case .toggle:
			return 36
		}
	}

	var maxWidth: CGFloat? {
		switch self {
		case .flexible(_ , let max):
			return max
		case .toggle:
			return 36
		}
	}
}

// MARK: - Animations
extension NSTableView {

	func removeRows(at index: Int, withAnimation animation: AnimationOptions = [.effectFade, .slideDown]) {
		self.removeRows(at: .init(integer: index), withAnimation: animation)
	}

	func insertRows(at index: Int, withAnimation animation: AnimationOptions = [.effectFade, .slideRight]) {
		self.insertRows(at: .init(integer: index), withAnimation: animation)
	}
}
