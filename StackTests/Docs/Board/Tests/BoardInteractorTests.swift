//
//  BoardInteractorTests.swift
//  StackTests
//
//  Created by Anton Cherkasov on 18.08.2023.
//

import XCTest
@testable import Stack

final class BoardInteractorTests: XCTestCase {

	var sut: BoardInteractor!

	var presenter: BoardPresenterMock!

	var storage: BoardDataPublisherMock!

	override func setUpWithError() throws {
		presenter = BoardPresenterMock()
		storage = BoardDataPublisherMock()
		sut = BoardInteractor(storage: storage)
		sut.presenter = presenter
	}

	override func tearDownWithError() throws {
		sut = nil
		presenter = nil
		storage = nil
	}
}

// MARK: - BoardUnitInteractor
extension BoardInteractorTests {

	func test_fetchData() throws {
		// Arrange

		storage.stubs.state = BoardContent(
			id: UUID(),
			period: nil,
			velocity: nil,
			columns: []
		)

		var expectedContent: BoardContent?

		// Act
		sut.fetchData { content in
			expectedContent = content
		}

		// Assert
		XCTAssertEqual(expectedContent, storage.stubs.state)
		XCTAssertEqual(storage.invocations, [.addObservation])
	}

	func test_addColumn() throws {
		// Arrange
		let title: String = .random
		storage.invocations.removeAll()

		// Act
		sut.addColumn(with: title)

		// Assert
		XCTAssertEqual(storage.invocations.count, 1)
		guard case .modificate = storage.invocations.first else {
			return XCTFail("`modificate` must be invocked")
		}
		XCTAssertEqual(storage.stubs.modificated.columns.count, 1)
		XCTAssertEqual(storage.stubs.modificated.columns.last?.title, title)
	}

	func test_deleteColumn() throws {
		// Arrange
		storage.invocations.removeAll()

		let column1 = BoardColumn(id: UUID(), title: .random, cards: [])
		let column2 = BoardColumn(id: UUID(), title: .random, cards: [])

		storage.stubs.modificated.columns = [column1, column2]

		// Act
		sut.deleteColumn(column1.id)

		// Assert
		XCTAssertEqual(storage.invocations.count, 1)
		guard case .modificate = storage.invocations.first else {
			return XCTFail("`modificate` must be invocked")
		}
		XCTAssertEqual(storage.stubs.modificated.columns.count, 1)
		XCTAssertEqual(storage.stubs.modificated.columns.first?.id, column2.id)
	}

	func test_moveForward() throws {
		// Arrange
		storage.invocations.removeAll()

		let column1 = BoardColumn(id: UUID(), title: .random, cards: [])
		let column2 = BoardColumn(id: UUID(), title: .random, cards: [])
		let column3 = BoardColumn(id: UUID(), title: .random, cards: [])

		storage.stubs.modificated.columns = [column1, column2, column3]

		// Act
		sut.moveForwardColumn(column2.id)

		// Assert
		XCTAssertEqual(storage.invocations.count, 1)
		guard case .modificate = storage.invocations.first else {
			return XCTFail("`modificate` must be invocked")
		}
		XCTAssertEqual(storage.stubs.modificated.columns.count, 3)
		XCTAssertEqual(storage.stubs.modificated.columns.map(\.id), [column1.id, column3.id, column2.id])
	}

	func test_moveBackward() throws {
		// Arrange
		storage.invocations.removeAll()

		let column1 = BoardColumn(id: UUID(), title: .random, cards: [])
		let column2 = BoardColumn(id: UUID(), title: .random, cards: [])
		let column3 = BoardColumn(id: UUID(), title: .random, cards: [])

		storage.stubs.modificated.columns = [column1, column2, column3]

		// Act
		sut.moveBackwardColumn(column2.id)

		// Assert
		XCTAssertEqual(storage.invocations.count, 1)
		guard case .modificate = storage.invocations.first else {
			return XCTFail("`modificate` must be invocked")
		}
		XCTAssertEqual(storage.stubs.modificated.columns.count, 3)
		XCTAssertEqual(storage.stubs.modificated.columns.map(\.id), [column2.id, column1.id, column3.id])
	}

	func test_renameColumn() throws {
		// Arrange
		storage.invocations.removeAll()

		let newTitle: String = .random
		let column1 = BoardColumn(id: UUID(), title: .random, cards: [])

		storage.stubs.modificated.columns = [column1]

		// Act
		sut.renameColumn(newTitle, ofColumn: column1.id)

		// Assert
		XCTAssertEqual(storage.invocations.count, 1)
		guard case .modificate = storage.invocations.first else {
			return XCTFail("`modificate` must be invocked")
		}
		XCTAssertEqual(storage.stubs.modificated.columns.first?.title, newTitle)
	}
}

// MARK: - Common cases
extension BoardInteractorTests {

	func test_dataObservation() throws {
		// Arrange

		let column1 = BoardColumn(id: UUID(), title: .random, cards: [])
		let column2 = BoardColumn(id: UUID(), title: .random, cards: [])

		let expectedContent = BoardContent(
			id: UUID(),
			period: nil,
			velocity: nil,
			columns: [column1, column2]
		)

		// Act
		storage.stubs.observation?(expectedContent)

		// Assert
		XCTAssertEqual(presenter.invocations.count, 1)
		guard case let .present(content) = presenter.invocations.first else {
			return XCTFail("`present` must be invocked")
		}

		XCTAssertEqual(content, expectedContent)
	}
}

