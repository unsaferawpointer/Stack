//
//  DataSnapshotTests.swift
//  StackTests
//
//  Created by Anton Cherkasov on 27.08.2023.
//

import XCTest
@testable import Stack

final class DataSnapshotTests: XCTestCase {

	var sut: DataSnapshot<IdentifiableItemMock>!

	override func setUpWithError() throws {
		sut = .empty
	}

	override func tearDownWithError() throws {
		sut = nil
	}
}

// MARK: - Common interface
extension DataSnapshotTests {

	func test_difference_whenOldSnapshotIsEmpty() throws {
		// Arrange

		let item0 = IdentifiableItemMock()
		let item1 = IdentifiableItemMock()
		let item2 = IdentifiableItemMock()

		let newSnapshot = DataSnapshot(items: [item0, item1, item2])

		var removedIndexes: [Int] = []
		var insertedIndexes: [Int] = []

		// Act
		sut.difference(from: newSnapshot) { index in
			removedIndexes.append(index)
		} insert: { index in
			insertedIndexes.append(index)
		}

		// Assert
		XCTAssertEqual(removedIndexes, [])
		XCTAssertEqual(insertedIndexes, [0, 1, 2])

		XCTAssertEqual(sut.items, [item0, item1, item2])
	}

	func test_difference_withTheReplacementOfAllItems() throws {
		// Arrange

		let oldItem0 = IdentifiableItemMock()
		let oldItem1 = IdentifiableItemMock()
		let oldItem2 = IdentifiableItemMock()

		sut = DataSnapshot(items: [oldItem0, oldItem1, oldItem2])

		let newItem0 = IdentifiableItemMock()
		let newItem1 = IdentifiableItemMock()
		let newItem2 = IdentifiableItemMock()

		let newSnapshot = DataSnapshot(items: [newItem0, newItem1, newItem2])

		var removedIndexes: [Int] = []
		var insertedIndexes: [Int] = []

		// Act
		sut.difference(from: newSnapshot) { index in
			removedIndexes.append(index)
		} insert: { index in
			insertedIndexes.append(index)
		}

		// Assert
		XCTAssertEqual(removedIndexes, [2, 1, 0])
		XCTAssertEqual(insertedIndexes, [0, 1, 2])

		XCTAssertEqual(sut.items, [newItem0, newItem1, newItem2])
	}

	func test_difference() throws {
		// Arrange

		let oldItem0 = IdentifiableItemMock()
		let oldItem1 = IdentifiableItemMock()
		let oldItem2 = IdentifiableItemMock()

		sut = DataSnapshot(items: [oldItem0, oldItem1, oldItem2])

		let newItem0 = IdentifiableItemMock()

		let newSnapshot = DataSnapshot(items: [oldItem0, newItem0, oldItem1])

		var removedIndexes: [Int] = []
		var insertedIndexes: [Int] = []

		// Act
		sut.difference(from: newSnapshot) { index in
			removedIndexes.append(index)
		} insert: { index in
			insertedIndexes.append(index)
		}

		// Assert
		XCTAssertEqual(removedIndexes, [2])
		XCTAssertEqual(insertedIndexes, [1])

		XCTAssertEqual(sut.items, [oldItem0, newItem0, oldItem1])
	}

	func test_update() throws {
		// Arrange

		let updatedId = UUID()

		let oldItem0 = IdentifiableItemMock()
		let oldItem1 = IdentifiableItemMock(id: updatedId)
		let oldItem2 = IdentifiableItemMock()

		sut = DataSnapshot(items: [oldItem0, oldItem1, oldItem2])

		let newItem0 = IdentifiableItemMock(id: updatedId)
		let newItem1 = IdentifiableItemMock()

		let newSnapshot = DataSnapshot(items: [oldItem0, newItem0, newItem1])

		var updatedIndexes: [Int] = []
		var newItems: [IdentifiableItemMock] = []

		// Act
		sut.update(from: newSnapshot) { index, newItem in
			updatedIndexes.append(index)
			newItems.append(newItem)
		}

		// Assert
		XCTAssertEqual(Set(updatedIndexes), Set([0, 1]))
		XCTAssertEqual(Set(newItems), Set([oldItem0, newItem0]))

		XCTAssertEqual(sut.items, [oldItem0, newItem0, oldItem2])
	}
}

// MARK: - Nested data structs
extension DataSnapshotTests {

	struct IdentifiableItemMock: IdentifiableItem, Hashable {

		var id: UUID

		var content: String

		init(id: UUID = .init(), content: String = .random) {
			self.id = id
			self.content = content
		}
	}
}
