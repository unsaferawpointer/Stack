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

	/// Create new task
	///
	/// - Parameters:
	///    - text: Task text
	///    - completionHandler: Completion handler
	func createTask(withText text: String, completionHandler: (UUID) -> Void)

	func deleteTasks(_ ids: Set<UUID>)
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

	func createTask(withText text: String, completionHandler: (UUID) -> Void) {
		let new = TaskItem(text: text)
		storage.modificate { state in
			state.tasks.append(new)
		}
		completionHandler(new.id)
	}

	func deleteTasks(_ ids: Set<UUID>) {
		storage.modificate { state in
			state.tasks.removeAll(where: \.id, containedIn: ids)
		}
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

