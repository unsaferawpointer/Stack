//
//  BoardPresenterTests.swift
//  StackTests
//
//  Created by Anton Cherkasov on 18.08.2023.
//

import XCTest
import DesignSystem
@testable import Stack

final class BoardPresenterTests: XCTestCase {

	var sut: BoardPresenter!

	var interactor: BoardInteractorMock!

	var view: BoardViewMock!

	var localization: BoardLocalizationMock!

	override func setUpWithError() throws {
		interactor = BoardInteractorMock()
		view = BoardViewMock()
		localization = BoardLocalizationMock()
		sut = BoardPresenter(localization: localization)
		sut.interactor = interactor
		sut.view = view
	}

	override func tearDownWithError() throws {
		sut = nil
		interactor = nil
		view = nil
		localization = nil
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
		guard case .display = view.invocations.first else {
			return XCTFail("`display` must be invocked")
		}
	}

	func test_addColumnButtonHasBeenClicked() throws {
		// Act
		sut.addColumnButtonHasBeenClicked()

		// Assert
		XCTAssertEqual(interactor.invocations.count, 1)
		guard case let .addColumn(title) = interactor.invocations.first else {
			return XCTFail("`addColumn` must be invocked")
		}
		XCTAssertEqual(title, localization.defaultColumnTitle)
	}

	func test_deleteColumn() throws {
		// Arrange

		let column1 = BoardColumn(id: UUID(), title: .random, cards: [])

		let content = BoardContent(
			id: UUID(),
			period: nil,
			velocity: nil,
			columns: [column1]
		)

		sut.present(content)

		guard case let .display(model) = view.invocations.first else {
			return XCTFail("`display` must be invocked")
		}

		let menu = try XCTUnwrap(model.columns.first?.menu)

		let itemOfDeletion = menu.items[5]
		guard case .menuItem(let configuration) = itemOfDeletion else {
			return XCTFail("`menuItem` is expected")
		}

		// Act
		configuration.action?()

		// Assert
		XCTAssertEqual(interactor.invocations.count, 1)
		guard case let .deleteColumn(id) = interactor.invocations.first else {
			return XCTFail("`deleteColumn` must be invocked")
		}

		XCTAssertEqual(id, column1.id)

	}

	func test_moveForward() throws {
		// Arrange

		let column1 = BoardColumn(id: UUID(), title: .random, cards: [])

		let content = BoardContent(
			id: UUID(),
			period: nil,
			velocity: nil,
			columns: [column1]
		)

		sut.present(content)

		guard case let .display(model) = view.invocations.first else {
			return XCTFail("`display` must be invocked")
		}

		let menu = try XCTUnwrap(model.columns.first?.menu)

		let itemOfForwardMoving = menu.items[2]
		guard case .menuItem(let configuration) = itemOfForwardMoving else {
			return XCTFail("`menuItem` is expected")
		}

		// Act
		configuration.action?()

		// Assert
		XCTAssertEqual(interactor.invocations.count, 1)
		guard case let .moveForwardColumn(id) = interactor.invocations.first else {
			return XCTFail("`moveForwardColumn` must be invocked")
		}

		XCTAssertEqual(id, column1.id)
	}

	func test_moveBackward() throws {
		// Arrange

		let column1 = BoardColumn(id: UUID(), title: .random, cards: [])

		let content = BoardContent(
			id: UUID(),
			period: nil,
			velocity: nil,
			columns: [column1]
		)

		sut.present(content)

		guard case let .display(model) = view.invocations.first else {
			return XCTFail("`display` must be invocked")
		}

		let menu = try XCTUnwrap(model.columns.first?.menu)

		let itemOfForwardMoving = menu.items[3]
		guard case .menuItem(let configuration) = itemOfForwardMoving else {
			return XCTFail("`menuItem` is expected")
		}

		// Act
		configuration.action?()

		// Assert
		XCTAssertEqual(interactor.invocations.count, 1)
		guard case let .moveBackwardColumn(id) = interactor.invocations.first else {
			return XCTFail("`moveBackwardColumn` must be invocked")
		}

		XCTAssertEqual(id, column1.id)
	}

	func test_renameColumn() throws {
		// Arrange

		let column1 = BoardColumn(id: UUID(), title: .random, cards: [])

		let expectedTitle: String = .random

		let content = BoardContent(
			id: UUID(),
			period: nil,
			velocity: nil,
			columns: [column1]
		)

		sut.present(content)

		guard case let .display(model) = view.invocations.first else {
			return XCTFail("`display` must be invocked")
		}

		let column1Model = try XCTUnwrap(model.columns.first)

		// Act
		column1Model.action?(expectedTitle)

		// Assert
		XCTAssertEqual(interactor.invocations.count, 1)
		guard case let .renameColumn(newTitle, id) = interactor.invocations.first else {
			return XCTFail("`renameColumn` must be invocked")
		}

		XCTAssertEqual(id, column1.id)
		XCTAssertEqual(newTitle, expectedTitle)
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

		let placeholder = localization.columnHeaderPlaceholder

		XCTAssertEqual(model.columns.count, 2)

		let column1Model = model.columns[0]

		XCTAssertEqual(column1Model.id, column1.id)
		XCTAssertEqual(column1Model.title, column1.title)
		XCTAssertEqual(column1Model.placeholder, placeholder)
		XCTAssertEqual(column1Model.menu?.items.count, 6)

		let column2Model = model.columns[1]

		XCTAssertEqual(column2Model.id, column2.id)
		XCTAssertEqual(column2Model.title, column2.title)
		XCTAssertEqual(column2Model.placeholder, placeholder)
		XCTAssertEqual(column2Model.menu?.items.count, 6)

		XCTAssertTrue(interactor.invocations.isEmpty)
	}
}
