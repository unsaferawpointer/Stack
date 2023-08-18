//
//  BoardPresenterTests.swift
//  StackTests
//
//  Created by Anton Cherkasov on 18.08.2023.
//

import XCTest
@testable import Stack

final class BoardPresenterTests: XCTestCase {

	var sut: BoardPresenter!

	var interactor: BoardInteractorMock!

	var view: BoardViewMock!

	override func setUpWithError() throws {
		interactor = BoardInteractorMock()
		view = BoardViewMock()
		sut = BoardPresenter()
		sut.interactor = interactor
		sut.view = view
	}

	override func tearDownWithError() throws {
		sut = nil
		interactor = nil
		view = nil
	}
}

// MARK: - BoardViewOutput
extension BoardPresenterTests {

	func test_viewDidChange() throws {
		// Arrange

		let column1 = BoardColumn(id: UUID(), title: .random, cards: [])
		let column2 = BoardColumn(id: UUID(), title: .random, cards: [])

		interactor.stubs.fetchData = BoardContent(
			id: UUID(),
			period: nil,
			velocity: nil,
			columns: [column1, column2]
		)

		// Act
		sut.viewDidChange(.didLoad)

		// Assert
		XCTAssertEqual(interactor.invocations.count, 1)
		guard case .fetchData = interactor.invocations.first else {
			return XCTFail("`fetchData` must be invocked")
		}

		XCTAssertEqual(view.invocations.count, 1)
		guard case let .display(model) = view.invocations.first else {
			return XCTFail("`display` must be invocked")
		}

		XCTAssertEqual(model.columns, [.init(id: column1.id, title: column1.title),
									   .init(id: column2.id, title: column2.title)])
	}
}

// MARK: - BoardUnitPresenter
extension BoardPresenterTests {

	func test_present() throws {
		// Arrange

		let column1 = BoardColumn(id: UUID(), title: .random, cards: [])
		let column2 = BoardColumn(id: UUID(), title: .random, cards: [])

		let content = BoardContent(
			id: UUID(),
			period: nil,
			velocity: nil,
			columns: [column1, column2]
		)

		// Act
		sut.present(content)

		// Assert
		XCTAssertEqual(view.invocations.count, 1)
		guard case let .display(model) = view.invocations.first else {
			return XCTFail("`display` must be invocked")
		}

		XCTAssertEqual(model.columns, [.init(id: column1.id, title: column1.title),
									   .init(id: column2.id, title: column2.title)])

		XCTAssertTrue(interactor.invocations.isEmpty)
	}
}
