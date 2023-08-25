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
}

// MARK: - ListUnitPresenter
extension ListPresenterTests {

	func test_present() throws {
		// Arrange
		let content = ListContent()

		// Act
		sut.present(content)

		// Assert
		XCTAssertEqual(view.invocations.count, 1)
		guard case .display = view.invocations.first else {
			return XCTFail("`display` must be invocked")
		}
	}
}

