//
//  DocumentStorageTests.swift
//  StackTests
//
//  Created by Anton Cherkasov on 16.08.2023.
//

import XCTest
@testable import Stack

final class DocumentStorageTests: XCTestCase {

	var sut: DocumentStorage<String>!

	var provider: ContentProviderMock!

	override func setUpWithError() throws {
		provider = ContentProviderMock()
		sut = DocumentStorage<String>(
			initialState: .random,
			provider: provider
		)
	}

	override func tearDownWithError() throws {
		provider = nil
		sut = nil
	}
}

// MARK: - DocumentDataRepresentation
extension DocumentStorageTests {

	func test_read() throws {
		// Arrange
		let data: Data = .random
		let type: String = .random

		// Act
		try sut.read(from: data, ofType: type)

		// Assert
		XCTAssertEqual(sut.state, provider.stubs.content)
	}

	func test_dataOfType() throws {
		// Act
		let result = try sut.data(ofType: .random)

		// Assert
		XCTAssertEqual(result, provider.stubs.data)
	}
}

// MARK: - DocumentDataPublisher
extension DocumentStorageTests {

	func test_modificate() throws {
		// Arrange
		let newState: String = .random

		// Act
		sut.modificate { state in
			state.removeAll()
			state.append(contentsOf: newState)
		}

		// Assert
		XCTAssertEqual(sut.state, newState)
	}

	func test_addObservation() throws {
		// Arrange
		var state: String?
		let initialState: String = .random

		sut = DocumentStorage(
			initialState: initialState,
			provider: provider
		)

		// Act
		sut.addObservation(for: self) { _, newState in
			state = newState
		}

		// Assert
		XCTAssertEqual(state, initialState)
	}
}

// MARK: - Helpers
private extension BoardDataProviderTests {

	func loadFile(withName name: String) throws -> Data {
		let bundle = Bundle(for: BoardDataProviderTests.self)
		let path = try XCTUnwrap(bundle.path(forResource: name, ofType: "stackboard"))
		return try XCTUnwrap(FileManager.default.contents(atPath: path))
	}
}
