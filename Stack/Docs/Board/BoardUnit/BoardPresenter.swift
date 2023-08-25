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
			makeColumn(from: column)
		}
		return BoardUnitModel(columns: columns)
	}

	func makeColumn(from column: BoardColumn) -> ColumnConfiguration {
		let title = TextfieldConfiguration(
			text: column.title,
			placeholder: localization.columnHeaderPlaceholder
		) { [weak self] newTitle in
			self?.interactor?.renameColumn(newTitle, ofColumn: column.id)
		}
		let menu = makeMenu(column: column)
		let button = MenuButtonConfiguration(imageName: "ellipsis", menu: menu)
		let header = HeaderConfiguration(title: title, button: button)
		return .init(id: column.id, header: header)
	}

	func makeMenu(column: BoardColumn) -> MenuConfiguration {
		return MenuConfiguration(items: [])
			.addItem(localization.newCardContextMenuItemTitle, iconName: "plus") {
				// TODO: - Handle action
			}
			.addDivider()
			.addItem(localization.moveForwardContextMenuItemTitle, iconName: "arrow.forward.to.line") { [weak self] in
				self?.interactor?.moveForwardColumn(column.id)
			}
			.addItem(localization.moveBackwardContextMenuItemTitle, iconName: "arrow.backward.to.line") { [weak self] in
				self?.interactor?.moveBackwardColumn(column.id)
			}
			.addDivider()
			.addItem(localization.deleteContextMenuItemTitle, iconName: "trash") { [weak self] in
				self?.interactor?.deleteColumn(column.id)
			}
	}
}
