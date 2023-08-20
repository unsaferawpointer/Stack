//
//  BoardUnitPresenter.swift
//  Stack
//
//  Created by Anton Cherkasov on 16.08.2023.
//

import Foundation
import DesignSystem

protocol BoardUnitPresenter: AnyObject {
	func present(_ content: BoardContent)
}

/// `Board` unit presenter
final class BoardPresenter {

	var interactor: BoardUnitInteractor?

	var localization: BoardUnitLocalization

	var view: BoardView?

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - localization: Unit localization
	init(
		localization: BoardUnitLocalization = BoardLocalization()
	) {
		self.localization = localization
	}
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

	func addColumnButtonHasBeenClicked() {
		interactor?.addColumn(with: localization.defaultColumnTitle)
	}
}

// MARK: - Helpers
private extension BoardPresenter {

	func makeModel(from content: BoardContent) -> BoardUnitModel {
		let columns = content.columns.map { column in
			ColumnConfiguration(
				id: column.id,
				title: column.title,
				placeholder: localization.columnHeaderPlaceholder,
				menu: makeMenu(column: column)
			)
		}
		return BoardUnitModel(columns: columns)
	}

	func makeMenu(column: BoardColumn) -> MenuConfiguration {
		return MenuConfiguration(items: [])
			.addItem(localization.newCardContextMenuItemTitle, iconName: "plus") {
				// TODO: - Handle action
			}
			.addDivider()
			.addItem(localization.moveForwardContextMenuItemTitle, iconName: "arrow.forward.to.line") {
				// TODO: - Handle action
			}
			.addItem(localization.moveBackwardContextMenuItemTitle, iconName: "arrow.backward.to.line") {
				// TODO: - Handle action
			}
			.addDivider()
			.addItem(localization.deleteContextMenuItemTitle, iconName: "trash") {
				// TODO: - Handle action
			}
	}
}
