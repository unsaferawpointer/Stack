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

