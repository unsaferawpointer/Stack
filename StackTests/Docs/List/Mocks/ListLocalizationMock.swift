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
extension ListLocalizationMock: ListUnitLocalization { }

// MARK: - Nested data structs
extension ListLocalizationMock {

	struct Stubs { }
}
