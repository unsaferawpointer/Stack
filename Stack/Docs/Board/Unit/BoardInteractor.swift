//
//  BoardInteractor.swift
//  Stack
//
//  Created by Anton Cherkasov on 16.08.2023.
//

import Foundation

protocol BoardUnitInteractor: AnyObject {

	/// Fetch data
	func fetchData(_ completionBlock: (BoardContent) -> Void)
}

/// `Board` unit interactor
final class BoardInteractor {

	var storage: any DocumentDataPublisher<BoardContent>

	var presenter: BoardUnitPresenter?

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
}

// MARK: - Helpers
private extension BoardInteractor {

	func configure() {
		storage.addObservation(for: self) { [weak self] _, content in
			self?.presenter?.present(content)
		}
	}
}
