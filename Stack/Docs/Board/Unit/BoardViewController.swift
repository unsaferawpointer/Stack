//
//  ViewController.swift
//  Stack
//
//  Created by Anton Cherkasov on 08.08.2023.
//

import Cocoa
import DesignSystem

protocol BoardViewOutput {

	/// View did change life-cycle state
	func viewDidChange(_ state: ViewState)
}

protocol BoardView {

	/// Display view-controller view-model
	///
	/// - Parameters:
	///    - model: Displayed model
	func display(_ model: BoardUnitModel)
}

class BoardViewController: NSViewController {

	// MARK: - DI

	var output: BoardViewOutput?

	// MARK: - UI-Properties

	lazy var stackView: HStackView = {
		let view = HStackView()
		return view
	}()

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - configure: Configuration closure. Setup unit here.
	init(_ configure: (BoardViewController) -> Void) {
		super.init(nibName: nil, bundle: nil)
		configure(self)
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
		self.view = stackView
	}

}

// MARK: - BoardView
extension BoardViewController: BoardView {

	func display(_ model: BoardUnitModel) {
		stackView.reloardItems(model.columns)
	}
}
