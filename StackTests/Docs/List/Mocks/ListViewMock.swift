//
//  ListViewMock.swift
//  StackTests
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import Foundation
@testable import Stack

final class ListViewMock {

	var invocations: [Action] = []

	var stubs = Stubs()
}

// MARK: - ListView
extension ListViewMock: ListView {

	func display(_ model: ListUnitModel) {
		invocations.append(.display(model))
	}

	func scrollTo(_ id: UUID) {
		invocations.append(.scrollTo(id))
	}

	func selectedIdentifiers() -> Set<UUID> {
		stubs.selectedIdentifiers
	}
}

// MARK: - Nested data structs
extension ListViewMock {

	enum Action {
		case display(_ model: ListUnitModel)
		case scrollTo(_ id: UUID)
	}

	struct Stubs {
		var selectedIdentifiers: Set<UUID> = .init()
	}
}
