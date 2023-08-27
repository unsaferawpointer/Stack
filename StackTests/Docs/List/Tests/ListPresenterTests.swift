//
//  ListPresenterTests.swift
//  StackTests
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import XCTest
import DesignSystem
@testable import Stack

final class ListPresenterTests: XCTestCase {

	var sut: ListPresenter!

	var interactor: ListInteractorMock!

	var view: ListViewMock!

	var localization: ListLocalizationMock!

	override func setUpWithError() throws {
		interactor = ListInteractorMock()
		view = ListViewMock()
		localization = ListLocalizationMock()
		sut = ListPresenter(localization: localization)
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

// MARK: - ListViewOutput
extension ListPresenterTests {

	func test_viewDidChange() throws {
		// Arrange
		interactor.stubs.fetchData = ListContent()

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

	func test_createNew() throws {
		// Act
		sut.createNew()

		// Assert
		XCTAssertEqual(interactor.invocations.count, 1)
		guard case let .createTask(text) = interactor.invocations.first else {
			return XCTFail("`createTask` must be invocked")
		}

		XCTAssertEqual(text, localization.defaultTaskText)

		XCTAssertEqual(view.invocations.count, 1)
		guard case let .scrollTo(id) = view.invocations.first else {
			return XCTFail("`scrollTo` must be invocked")
		}

		XCTAssertEqual(id, interactor.stubs.createdTaskIdentifier)
	}
}

// MARK: - ListUnitPresenter
extension ListPresenterTests {

	func test_present() throws {
		// Arrange

		let taskItem0 = TaskItem(text: .random)
		let taskItem1 = TaskItem(text: .random)

		let content = ListContent(id: .init(), tasks: [taskItem0, taskItem1])

		// Act
		sut.present(content)

		// Assert
		XCTAssertEqual(view.invocations.count, 1)
		guard case let.display(model) = view.invocations.first else {
			return XCTFail("`display` must be invocked")
		}

		XCTAssertEqual(model.items.count, 2)

		let taskModel0 = try XCTUnwrap(model.items.first)

		XCTAssertEqual(taskModel0.id, taskItem0.id)
		XCTAssertEqual(taskModel0.text, taskItem0.text)
		XCTAssertEqual(taskModel0.isDone, false)
		XCTAssertEqual(taskModel0.isUrgent, taskItem0.category.contains(.urgent))
	}
}

