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

	var newCardContextMenuItemTitle: String {
		stubs.newCardContextMenuItemTitle
	}

	var moveForwardContextMenuItemTitle: String {
		stubs.moveForwardContextMenuItemTitle
	}

	var moveBackwardContextMenuItemTitle: String {
		stubs.moveBackwardContextMenuItemTitle
	}

	var deleteContextMenuItemTitle: String {
		stubs.deleteContextMenuItemTitle
	}
}

// MARK: - Nested data structs
extension BoardLocalizationMock {

	struct Stubs {
		var defaultColumnTitle: String = .random
		var columnHeaderPlaceholder: String = .random

		var newCardContextMenuItemTitle: String = .random
		var moveForwardContextMenuItemTitle: String = .random
		var moveBackwardContextMenuItemTitle: String = .random
		var deleteContextMenuItemTitle: String = .random
	}
}
