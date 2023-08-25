//
//  ListViewController.swift
//  Stack
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import Cocoa
import DesignSystem

protocol ListViewOutput {

	/// View did change life-cycle state
	func viewDidChange(_ state: ViewState)
}

protocol ListView {

	/// Display view-controller view-model
	///
	/// - Parameters:
	///    - model: Displayed model
	func display(_ model: ListUnitModel)
}

class ListViewController: NSViewController {

	// MARK: - DI

	var output: ListViewOutput?

	// MARK: - UI-Properties

	lazy private var scrollview = NSScrollView.plain()

	lazy var list: NSOutlineView = {
		let view = NSOutlineView()
		view.usesAlternatingRowBackgroundColors = true
		return view
	}()

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - configure: Configuration closure. Setup unit here.
	init(_ configure: (ListViewController) -> Void) {
		super.init(nibName: nil, bundle: nil)
		configure(self)
		configureUserInterface()
	}

	@available(*, unavailable, message: "Use init(_:)")
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Life-cycle

	override func viewDidLoad() {
		super.viewDidLoad()
		output?.viewDidChange(.didLoad)
	}

	override func loadView() {
		self.view = scrollview
	}

}

// MARK: - ListView
extension ListViewController: ListView {

	func display(_ model: ListUnitModel) {
		// TODO: - Handle action
	}
}

private extension ListViewController {

	func configureUserInterface() {

		scrollview.documentView = list

		let column = NSTableColumn(identifier: .init("main"))
		list.addTableColumn(column)
	}
}
