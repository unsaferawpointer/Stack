//
//  ColumnView.swift
//  Stack
//
//  Created by Anton Cherkasov on 17.08.2023.
//

import Cocoa
import DesignSystem

class ColumnView: NSView, ConfigurableView {

	// MARK: - ConfigurableView

	typealias Configuration = ColumnConfiguration

	required init(_ configuration: ColumnConfiguration) {
		super.init(frame: .zero)
		configureUserInterface()
		configureConstraints()
		configure(configuration)
	}

	func configure(_ configuration: ColumnConfiguration) {
		header.configure(configuration.header)
	}

	// MARK: - UI-Properties

	lazy private var header = ColumnHeader(.empty)

	lazy private var scrollview = NSScrollView.plain()

	lazy private var list: NSTableView = {
		let view = NSTableView()
		view.style = .inset
		view.usesAlternatingRowBackgroundColors = true
		view.usesAutomaticRowHeights = false
		view.allowsMultipleSelection = true
		view.rowHeight = 120
		view.intercellSpacing = .init(width: 0, height: 16)
		return view
	}()

	// MARK: - Initialization

	@available(*, unavailable, message: "Use init()")
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

// MARK: - Helpers
private extension ColumnView {

	func configureUserInterface() {
		let column = NSTableColumn(identifier: .init("main"))
		list.addTableColumn(column)
		list.headerView = nil
	}

	func configureConstraints() {

		scrollview.documentView = list
		scrollview.attachEdges(.all, toView: self)
		scrollview.contentInsets = .init(top: 32)

		header.attachEdges([.leading, .top, .trailing], toView: self)
		header.set(.height, toConstant: 32)
		header.translatesAutoresizingMaskIntoConstraints = false
	}
}
