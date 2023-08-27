//
//  ListInteractorMock.swift
//  StackTests
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import Foundation
@testable import Stack

final class ListInteractorMock {

	var invocations: [Action] = []

	var stubs = Stubs()
}

// MARK: - ListUnitInteractor
extension ListInteractorMock: ListUnitInteractor {

	func fetchData(_ completionBlock: (ListContent) -> Void) {
		invocations.append(.fetchData)
		completionBlock(stubs.fetchData)
	}

	func createTask(withText text: String, completionHandler: (UUID) -> Void) {
		invocations.append(.createTask(text: text))
		completionHandler(stubs.createdTaskIdentifier)
	}
}

// MARK: - Nested data structs
extension ListInteractorMock {

	enum Action {
		case fetchData
		case createTask(text: String)
	}

	struct Stubs {
		var fetchData: ListContent = .initial
		var createdTaskIdentifier: UUID = UUID()
	}
}
