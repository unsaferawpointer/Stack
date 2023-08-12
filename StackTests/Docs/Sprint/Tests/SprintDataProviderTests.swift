//
//  SprintDataProviderTests.swift
//  StackTests
//
//  Created by Anton Cherkasov on 12.08.2023.
//

import XCTest
@testable import Stack

final class SprintDataProviderTests: XCTestCase {

	var sut: SprintDataProvider!

	override func setUpWithError() throws {
		sut = SprintDataProvider(content: .empty)
	}

	override func tearDownWithError() throws {
		sut = nil
	}
}

// MARK: - DataProvider test-cases
extension SprintDataProviderTests {

	func test_read() throws {
		// Arrange
		let data = try loadFile(withName: "Sprint_v1")

		// Act
		try sut.read(from: data, ofType: "com.paperwave.Stack.sprint")

		// Assert
		XCTAssertEqual(sut.content, expected)
	}

	func test_read_whenFormatIsInvalid() throws {
		// Arrange
		let data = try loadFile(withName: "Sprint_v1_broken")

		// Act
		XCTAssertThrowsError(try sut.read(from: data, ofType: "com.paperwave.Stack.sprint"), "It is expected error") { error in
			XCTAssertEqual(error as? DocumentError, .unexpectedFormat)
		}
	}

	func test_read_whenNoVersion() throws {
		// Arrange
		let data = try loadFile(withName: "Sprint_v1_no_version")

		// Act
		XCTAssertThrowsError(try sut.read(from: data, ofType: "com.paperwave.Stack.sprint"), "Expected error") { error in
			XCTAssertEqual(error as? DocumentError, .unexpectedFormat)
		}
	}

	func test_read_whenVersionIsInvalid() throws {
		// Arrange
		let data = try loadFile(withName: "Sprint_v1_invalid_version")

		// Act
		XCTAssertThrowsError(try sut.read(from: data, ofType: "com.paperwave.Stack.sprint"), "Expected error") { error in
			XCTAssertEqual(error as? DocumentError, .unknownVersion)
		}
	}

	func test_data() throws {
		// Arrange
		sut.content = expected

		// Act
		let result = try sut.data(ofType: "com.paperwave.Stack.sprint")

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
private extension SprintDataProviderTests {

	func loadFile(withName name: String) throws -> Data {
		let bundle = Bundle(for: SprintDataProviderTests.self)
		let path = try XCTUnwrap(bundle.path(forResource: name, ofType: "sprint"))
		return try XCTUnwrap(FileManager.default.contents(atPath: path))
	}
}

private extension SprintDataProviderTests {

	var expected: SprintContent {
		return .init(
			id: UUID(uuidString: "644E7052-D1EB-474B-875B-D354F41E8CAF")!,
			period: .init(start: Date(timeIntervalSince1970: 0), end: Date(timeIntervalSince1970: 100)),
			velocity: 7,
			columns:
				[
					.init(id: UUID(uuidString: "73F84672-9398-4638-A676-BF65F5155D0B")!, title: "Backlog", cards:
							[
								Card(
									id: UUID(uuidString: "F59AB097-7B8C-4B09-BFA9-DD075BC543D1")!,
									text: "card0",
									tag: nil,
									isUrgent: false,
									estimation: 0
								),
								Card(
									id: UUID(uuidString: "F19F1EB8-0C9F-4B16-97F0-CB3BE864637D")!,
									text: "card1",
									tag: nil,
									isUrgent: false,
									estimation: 13
								),
								Card(
									id: UUID(uuidString: "6B4D75CF-97D5-48CD-B664-7A048A4C0AB6")!,
									text: "card2",
									tag: "tag2",
									isUrgent: true,
									estimation: 7
								)
							]
						 ),
					.init(id: UUID(uuidString: "498EDB3D-7ED3-429F-80B2-46AB9E6F467F")!, title: "In Progress", cards:
							[
								Card(
									id: UUID(uuidString: "E4B21AF6-3360-4899-8258-2C527557303B")!,
									text: "card0",
									tag: nil,
									isUrgent: false,
									estimation: 0
								)
							]
						 ),
					.init(id: UUID(uuidString: "6CD7E750-DF6E-45F5-975C-CDA57C17845B")!, title: "Done", cards:
							[
								Card(
									id: UUID(uuidString: "8E20B76D-670A-4CCC-994B-E4BA178B98F5")!,
									text: "card0",
									tag: nil,
									isUrgent: false,
									estimation: 0
								)
							]
						 )
				]
		)
	}
}
