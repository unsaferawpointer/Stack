//
//  BoardLocalizationMock.swift
//  StackTests
//
//  Created by Anton Cherkasov on 19.08.2023.
//

@testable import Stack

final class BoardLocalizationMock {

	var stubs = Stubs()
}

// MARK: - BoardUnitLocalization
extension BoardLocalizationMock: BoardUnitLocalization {

	var columnHeaderPlaceholder: String {
		stubs.columnHeaderPlaceholder
	}

	var defaultColumnTitle: String {
		stubs.defaultColumnTitle
	}
}

// MARK: - Nested data structs
extension BoardLocalizationMock {

	struct Stubs {
		var defaultColumnTitle: String = .random
		var columnHeaderPlaceholder: String = .random
	}
}
