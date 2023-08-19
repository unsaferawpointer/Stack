//
//  BoardInteractorMock.swift
//  StackTests
//
//  Created by Anton Cherkasov on 18.08.2023.
//

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
}

// MARK: - Nested data structs
extension BoardInteractorMock {

	enum Action {
		case fetchData
		case addColumn(title: String)
	}

	struct Stubs {
		var fetchData: BoardContent = .initial
	}
}
