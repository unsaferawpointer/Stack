//
//  ListViewMock.swift
//  StackTests
//
//  Created by Anton Cherkasov on 25.08.2023.
//

@testable import Stack

final class ListViewMock {

	var invocations: [Action] = []
}

// MARK: - ListView
extension ListViewMock: ListView {

	func display(_ model: ListUnitModel) {
		invocations.append(.display(model))
	}
}

// MARK: - Nested data structs
extension ListViewMock {

	enum Action {
		case display(_ model: ListUnitModel)
	}
}
