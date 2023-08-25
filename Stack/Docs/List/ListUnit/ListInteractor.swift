//
//  ListInteractor.swift
//  Stack
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import Foundation

/// `List` unit interactor
protocol ListUnitInteractor: AnyObject {

	/// Fetch data
	func fetchData(_ completionBlock: (ListContent) -> Void)
}

/// `List` unit interactor
final class ListInteractor {

	private(set) var storage: any DocumentDataPublisher<ListContent>

	weak var presenter: ListUnitPresenter?

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - storage: Document storage
	init(storage: any DocumentDataPublisher<ListContent>) {
		self.storage = storage
		configure()
	}
}

// MARK: - ListUnitInteractor
extension ListInteractor: ListUnitInteractor {

	func fetchData(_ completionBlock: (ListContent) -> Void) {
		completionBlock(storage.state)
	}
}

// MARK: - Helpers
private extension ListInteractor {

	func configure() {
		storage.addObservation(for: self) { [weak self] _, content in
			self?.presenter?.present(content)
		}
	}
}

