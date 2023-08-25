//
//  ListDataProviderTests.swift
//  StackTests
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import XCTest
@testable import Stack

final class ListDataProviderTests: XCTestCase {

	var sut: ListDataProvider!

	override func setUpWithError() throws {
		sut = ListDataProvider()
	}

	override func tearDownWithError() throws {
		sut = nil
	}
}

// MARK: - ContentProvider test-cases
extension ListDataProviderTests {

	func test_read() throws {
		// Arrange
		let data = try loadFile(withName: "List_v1")

		// Act
		let result = try sut.read(from: data, ofType: "com.paperwave.Stack.list")

		// Assert
		XCTAssertEqual(result, expected)
	}

	func test_read_whenFileContainsMinimumRequiredProperties() throws {
		// Arrange
		let data = try loadFile(withName: "List_v1_minimum")
		let expected = ListContent(id: try XCTUnwrap(UUID(uuidString: "644E7052-D1EB-474B-875B-D354F41E8CAF")))

		// Act
		let result = try sut.read(from: data, ofType: "com.paperwave.Stack.list")

		// Assert
		XCTAssertEqual(result, expected)
	}

	func test_read_whenFormatIsInvalid() throws {
		// Arrange
		let data = try loadFile(withName: "List_v1_broken")

		// Act
		XCTAssertThrowsError(try sut.read(from: data, ofType: "com.paperwave.Stack.list"), "It is expected error") { error in
			XCTAssertEqual(error as? DocumentError, .unexpectedFormat)
		}
	}

	func test_read_whenNoVersion() throws {
		// Arrange
		let data = try loadFile(withName: "List_v1_no_version")

		// Act
		XCTAssertThrowsError(try sut.read(from: data, ofType: "com.paperwave.Stack.list"), "Expected error") { error in
			XCTAssertEqual(error as? DocumentError, .unexpectedFormat)
		}
	}

	func test_read_whenVersionIsInvalid() throws {
		// Arrange
		let data = try loadFile(withName: "List_v1_invalid_version")

		// Act
		XCTAssertThrowsError(try sut.read(from: data, ofType: "com.paperwave.Stack.list"), "Expected error") { error in
			XCTAssertEqual(error as? DocumentError, .unknownVersion)
		}
	}

	func test_data() throws {
		// Act
		let result = try sut.data(ofType: "com.paperwave.Stack.list", content: expected)

		// Assert
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		encoder.dateEncodingStrategy = .secondsSince1970

		let file = DocumentFile(version: "v1", content: expected)
		let expectedData = try encoder.encode(file)
		XCTAssertEqual(result, expectedData)
	}
}

// MARK: - Helpers
private extension ListDataProviderTests {

	func loadFile(withName name: String) throws -> Data {
		let bundle = Bundle(for: ListDataProviderTests.self)
		let path = try XCTUnwrap(bundle.path(forResource: name, ofType: "stacklist"))
		return try XCTUnwrap(FileManager.default.contents(atPath: path))
	}
}

private extension ListDataProviderTests {

	var expected: ListContent {
		return .init(
			id: UUID(uuidString: "644E7052-D1EB-474B-875B-D354F41E8CAF")!,
			tasks:
				[
					TaskItem(
						id: UUID(uuidString: "F59AB097-7B8C-4B09-BFA9-DD075BC543D1")!,
						text: "task0",
						tag: nil,
						category: .urgent,
						estimation: 0,
						subtasks: nil
					),
					TaskItem(
						id: UUID(uuidString: "F19F1EB8-0C9F-4B16-97F0-CB3BE864637D")!,
						text: "task1",
						tag: nil,
						category: [],
						estimation: 13,
						subtasks: nil
					),
					TaskItem(
						id: UUID(uuidString: "6B4D75CF-97D5-48CD-B664-7A048A4C0AB6")!,
						text: "task2",
						tag: "tag2",
						category: .urgent,
						estimation: 7,
						subtasks: nil
					)
				]
		)
	}
}

