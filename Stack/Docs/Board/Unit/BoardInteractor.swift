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
}

// MARK: - Helpers
private extension BoardInteractor {

	func configure() {
		storage.addObservation(for: self) { [weak self] _, content in
			self?.presenter?.present(content)
		}
	}
}
