//
//  ListPresenterMock.swift
//  StackTests
//
//  Created by Anton Cherkasov on 25.08.2023.
//

@testable import Stack

final class ListPresenterMock {

	var invocations: [Action] = []
}

// MARK: - ListUnitPresenter
extension ListPresenterMock: ListUnitPresenter {

	func present(_ content: ListContent) {
		invocations.append(.present(content))
	}
}

// MARK: - Nested data structs
extension ListPresenterMock {

	enum Action {
		case present(_ content: ListContent)
	}
}
