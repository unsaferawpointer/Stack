//
//  ListInteractorTests.swift
//  StackTests
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import XCTest
@testable import Stack

final class ListInteractorTests: XCTestCase {

	var sut: ListInteractor!

	var presenter: ListPresenterMock!

	var storage: ListDataPublisherMock!

	override func setUpWithError() throws {
		presenter = ListPresenterMock()
		storage = ListDataPublisherMock()
		sut = ListInteractor(storage: storage)
		sut.presenter = presenter
	}

	override func tearDownWithError() throws {
		sut = nil
		presenter = nil
		storage = nil
	}
}

// MARK: - ListUnitInteractor
extension ListInteractorTests {

	func test_fetchData() throws {
		// Arrange

		storage.stubs.state = ListContent(
			id: UUID(),
			tasks: []
		)

		var expectedContent: ListContent?

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
extension ListInteractorTests {

	func test_dataObservation() throws {
		// Arrange
		let expectedContent = ListContent(
			id: UUID(),
			tasks: []
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

