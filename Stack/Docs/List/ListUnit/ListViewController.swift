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

	// MARK: - Data

	var items: [ListUnitModel.TaskModel] = []

	// MARK: - DI

	var output: ListViewOutput?

	// MARK: - UI-Properties

	lazy private var scrollview = NSScrollView.plain()

	lazy var table: NSTableView = {
		let view = NSTableView()
		view.dataSource = self
		view.delegate = self
		view.usesAlternatingRowBackgroundColors = true
		view.columnAutoresizingStyle = .reverseSequentialColumnAutoresizingStyle
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
		self.items = model.items
		table.reloadData()
	}
}

// MARK: - Helpers
private extension ListViewController {

	func configureUserInterface() {

		scrollview.documentView = table

		table
			.addColumn(.status, withTitle: "􀆅", style: .toggle)
			.addColumn(.text, withTitle: "Task description", style: .flexible(min: 180, max: nil))
			.addColumn(.isUrgent, withTitle: "􀋦", style: .toggle)
	}

}

extension NSUserInterfaceItemIdentifier {

	static let text = NSUserInterfaceItemIdentifier("text")

	static let isUrgent = NSUserInterfaceItemIdentifier("is_urgent")

	static let status = NSUserInterfaceItemIdentifier("status")
}
