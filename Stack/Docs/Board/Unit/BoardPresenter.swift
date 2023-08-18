//
//  BoardUnitPresenter.swift
//  Stack
//
//  Created by Anton Cherkasov on 16.08.2023.
//

import Foundation

protocol BoardUnitPresenter {
	func present(_ content: BoardContent)
}

/// `Board` unit presenter
final class BoardPresenter {

	var interactor: BoardUnitInteractor?

	var view: BoardView?
}

// MARK: - BoardUnitPresenter
extension BoardPresenter: BoardUnitPresenter {

	func present(_ content: BoardContent) {
		let model = makeModel(from: content)
		view?.display(model)
	}
}

// MARK: - BoardViewOutput
extension BoardPresenter: BoardViewOutput {

	func viewDidChange(_ state: ViewState) {
		guard case .didLoad = state else {
			return
		}
		interactor?.fetchData { [weak self] content in
			self?.present(content)
		}
	}
}

// MARK: - Helpers
private extension BoardPresenter {

	func makeModel(from content: BoardContent) -> BoardUnitModel {
		let columns = content.columns.map { column in
			ColumnConfiguration(
				id: column.id,
				title: column.title,
				placeholder: nil
			)
		}
		return BoardUnitModel(columns: columns)
	}
}
