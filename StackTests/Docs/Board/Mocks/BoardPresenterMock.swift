//
//  BoardPresenterMock.swift
//  StackTests
//
//  Created by Anton Cherkasov on 18.08.2023.
//

@testable import Stack

final class BoardPresenterMock {

	var invocations: [Action] = []
}

// MARK: - BoardUnitPresenter
extension BoardPresenterMock: BoardUnitPresenter {

	func present(_ content: BoardContent) {
		invocations.append(.present(content))
	}
}

// MARK: - Nested data structs
extension BoardPresenterMock {

	enum Action {
		case present(_ content: BoardContent)
	}
}
