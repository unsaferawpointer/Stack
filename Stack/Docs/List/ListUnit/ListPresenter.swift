//
//  ListPresenter.swift
//  Stack
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import Foundation
import DesignSystem

/// List unit presenter Interface
protocol ListUnitPresenter: AnyObject {
	func present(_ content: ListContent)
}

/// `List` unit presenter
final class ListPresenter {

	var interactor: ListUnitInteractor?

	var localization: ListUnitLocalization

	var view: ListView?

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - localization: Unit localization
	init(
		localization: ListUnitLocalization = ListLocalization()
	) {
		self.localization = localization
	}
}

// MARK: - ListUnitPresenter
extension ListPresenter: ListUnitPresenter {

	func present(_ content: ListContent) {
		let model = makeModel(from: content)
		view?.display(model)
	}
}

// MARK: - ListViewOutput
extension ListPresenter: ListViewOutput {

	func viewDidChange(_ state: ViewState) {
		guard case .didLoad = state else {
			return
		}
		interactor?.fetchData { [weak self] content in
			self?.present(content)
		}
	}

	func createNew() {
		interactor?.createTask(withText: localization.defaultTaskText) { [weak self] id in
			self?.view?.scrollTo(id)
		}
	}
}

// MARK: - Helpers
private extension ListPresenter {

	func makeModel(from content: ListContent) -> ListUnitModel {

		let items = content.tasks.map { item in
			ListUnitModel.TaskModel(
				id: item.id,
				text: item.text,
				isDone: false,
				isUrgent: item.category.contains(.urgent)
			)
		}
		return ListUnitModel(items: items)
	}
}
