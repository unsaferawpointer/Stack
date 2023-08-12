//
//  SprintDataProvider.swift
//  Stack
//
//  Created by Anton Cherkasov on 12.08.2023.
//

import Foundation

/// Data provider of sprint document
final class SprintDataProvider {

	let lastVersion: Version = .v1

	lazy var decoder: JSONDecoder = {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970
		return decoder
	}()

	lazy var encoder: JSONEncoder = {
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		encoder.dateEncodingStrategy = .secondsSince1970
		return encoder
	}()

	/// Content of sprint document
	var content: SprintContent

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - content: Content of sprint document
	init(content: SprintContent) {
		self.content = content
	}
}

// MARK: - DataProvider
extension SprintDataProvider: DataProvider {

	func data(ofType typeName: String) throws -> Data {
		switch typeName.lowercased() {
		case "com.paperwave.stack.sprint":
			let file = DocumentFile(version: lastVersion.rawValue, content: content)
			return try encoder.encode(file)
		default:
			throw DocumentError.unexpectedFormat
		}
	}

	func read(from data: Data, ofType typeName: String) throws {
		switch typeName.lowercased() {
		case "com.paperwave.stack.sprint":
			try migrate(data)
		default:
			throw DocumentError.unexpectedFormat
		}
	}
}

// MARK: - Helpers
private extension SprintDataProvider {

	func migrate(_ data: Data) throws {
		guard let versionedFile = try? decoder.decode(VersionedFile.self, from: data) else {
			throw DocumentError.unexpectedFormat
		}
		guard let version = Version(rawValue: versionedFile.version), version == lastVersion else {
			throw DocumentError.unknownVersion
		}
		guard let file = try? decoder.decode(DocumentFile<SprintContent>.self, from: data) else {
			throw DocumentError.unexpectedFormat
		}
		self.content = file.content
	}
}

// MARK: - Nested data structs
extension SprintDataProvider {

	enum Version: String {
		case v1
	}
}
