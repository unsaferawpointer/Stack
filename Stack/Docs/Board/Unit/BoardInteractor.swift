//
//  BoardInteractor.swift
//  Stack
//
//  Created by Anton Cherkasov on 16.08.2023.
//

import Foundation

/// `Board` unit interactor
protocol BoardUnitInteractor: AnyObject {

	/// Fetch data
	func fetchData(_ completionBlock: (BoardContent) -> Void)

	/// Add new column
	///
	/// - Parameters:
	///    - title: Column title
	func addColumn(with title: String)

	/// Delete column
	///
	/// - Parameters:
	///    - id: Column identifier
	func deleteColumn(_ id: UUID)

	/// Move column forward
	///
	/// - Parameters:
	///    - id: Column identifier
	func moveForwardColumn(_ id: UUID)

	/// Move column backward
	///
	/// - Parameters:
	///    - id: Column identifier
	func moveBackwardColumn(_ id: UUID)

	/// Rename column
	///
	/// - Parameters:
	///    - newTitle: New title
	///    - id: Column identifier
	func renameColumn(_ newTitle: String, ofColumn id: UUID)
}

/// `Board` unit interactor
final class BoardInteractor {

	private(set) var storage: any DocumentDataPublisher<BoardContent>

	weak var presenter: BoardUnitPresenter?

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - storage: Document storage
	init(storage: any DocumentDataPublisher<BoardContent>) {
		self.storage = storage
		configure()
	}
}

// MARK: - BoardUnitInteractor
extension BoardInteractor: BoardUnitInteractor {

	func fetchData(_ completionBlock: (BoardContent) -> Void) {
		completionBlock(storage.state)
	}

	func addColumn(with title: String) {
		let new = BoardColumn(title: title)
		storage.modificate { state in
			state.columns.append(new)
		}
	}

	func moveForwardColumn(_ id: UUID) {
		storage.modificate { state in
			guard let index = state.columns.firstIndex(where: { $0.id == id }) else {
				return
			}
			guard index < (state.columns.count - 1) else {
				return
			}
			let newIndex = index + 1
			let movedColumn = state.columns.remove(at: index)
			state.columns.insert(movedColumn, at: newIndex)
		}
	}

	func moveBackwardColumn(_ id: UUID) {
		storage.modificate { state in
			guard let index = state.columns.firstIndex(where: { $0.id == id }) else {
				return
			}
			guard index != 0 else {
				return
			}
			let newIndex = index - 1
			let movedColumn = state.columns.remove(at: index)
			state.columns.insert(movedColumn, at: newIndex)
		}
	}

	func deleteColumn(_ id: UUID) {
		storage.modificate { state in
			state.columns.removeAll { column in
				column.id == id
			}
		}
	}

	func renameColumn(_ newTitle: String, ofColumn id: UUID) {
		storage.modificate { state in
			guard let index = state.columns.firstIndex(where: { $0.id == id }) else {
				return
			}
			state.columns[index].title = newTitle
		}
	}
}

// MARK: - Helpers
private extension BoardInteractor {

	func configure() {
		storage.addObservation(for: self) { [weak self] _, content in
			self?.presenter?.present(content)
		}
	}
}
