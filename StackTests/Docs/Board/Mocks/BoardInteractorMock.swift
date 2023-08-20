//
//  BoardInteractorMock.swift
//  StackTests
//
//  Created by Anton Cherkasov on 18.08.2023.
//

import Foundation
@testable import Stack

final class BoardInteractorMock {

	var invocations: [Action] = []

	var stubs = Stubs()
}

// MARK: - BoardUnitInteractor
extension BoardInteractorMock: BoardUnitInteractor {

	func fetchData(_ completionBlock: (BoardContent) -> Void) {
		invocations.append(.fetchData)
		completionBlock(stubs.fetchData)
	}

	func addColumn(with title: String) {
		invocations.append(.addColumn(title: title))
	}

	func deleteColumn(_ id: UUID) {
		invocations.append(.deleteColumn(id: id))
	}

	func moveForwardColumn(_ id: UUID) {
		invocations.append(.moveForwardColumn(id: id))
	}

	func moveBackwardColumn(_ id: UUID) {
		invocations.append(.moveBackwardColumn(id: id))
	}

	func renameColumn(_ newTitle: String, ofColumn id: UUID) {
		invocations.append(.renameColumn(newTitle: newTitle, id: id))
	}
}

// MARK: - Nested data structs
extension BoardInteractorMock {

	enum Action {
		case fetchData
		case addColumn(title: String)
		case deleteColumn(id: UUID)
		case moveForwardColumn(id: UUID)
		case moveBackwardColumn(id: UUID)
		case renameColumn(newTitle: String, id: UUID)
	}

	struct Stubs {
		var fetchData: BoardContent = .initial
	}
}
