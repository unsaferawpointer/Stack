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
		header.title = configuration.title
		header.placeholderString = configuration.placeholder
		header.menuConfiguration = configuration.menu
		header.action = configuration.action
	}

	// MARK: - UI-Properties

	lazy private var header = ColumnHeader(title: "")

	lazy private var scrollview: NSScrollView = {
		let view = NSScrollView()
		view.borderType = .noBorder
		view.hasHorizontalScroller = false
		view.autohidesScrollers = true
		view.hasVerticalScroller = false
		view.automaticallyAdjustsContentInsets = true
		return view
	}()

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
		scrollview.translatesAutoresizingMaskIntoConstraints = false
		addSubview(scrollview)
		NSLayoutConstraint.activate(
			[
				scrollview.leadingAnchor.constraint(equalTo: leadingAnchor),
				scrollview.topAnchor.constraint(equalTo: topAnchor),
				scrollview.trailingAnchor.constraint(equalTo: trailingAnchor),
				scrollview.bottomAnchor.constraint(equalTo: bottomAnchor)
			]
		)

		header.translatesAutoresizingMaskIntoConstraints = false
		addSubview(header)
		NSLayoutConstraint.activate(
			[
				header.heightAnchor.constraint(equalToConstant: 32),
				header.leadingAnchor.constraint(equalTo: leadingAnchor),
				header.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
				header.trailingAnchor.constraint(equalTo: trailingAnchor)
			]
		)
		scrollview.contentInsets = .init(top: 32, left: 0, bottom: 0, right: 0)
	}
}
