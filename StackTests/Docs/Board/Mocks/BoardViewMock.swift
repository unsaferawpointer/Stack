//
//  BoardViewMock.swift
//  StackTests
//
//  Created by Anton Cherkasov on 18.08.2023.
//

@testable import Stack

final class BoardViewMock {

	var invocations: [Action] = []
}

// MARK: - BoardView
extension BoardViewMock: BoardView {

	func display(_ model: BoardUnitModel) {
		invocations.append(.display(model))
	}
}

// MARK: - Nested data structs
extension BoardViewMock {

	enum Action {
		case display(_ model: BoardUnitModel)
	}
}
