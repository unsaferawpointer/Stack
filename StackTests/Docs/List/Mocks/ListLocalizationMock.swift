//
//  ListLocalizationMock.swift
//  StackTests
//
//  Created by Anton Cherkasov on 25.08.2023.
//

@testable import Stack

final class ListLocalizationMock {

	var stubs = Stubs()
}

// MARK: - ListUnitLocalization
extension ListLocalizationMock: ListUnitLocalization {

	var defaultTaskText: String {
		stubs.defaultTaskText
	}
}

// MARK: - Nested data structs
extension ListLocalizationMock {

	struct Stubs {
		var defaultTaskText: String = .random
	}
}
