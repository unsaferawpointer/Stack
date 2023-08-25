//
//  ListDataProvider.swift
//  Stack
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import Foundation

/// Data provider of board document
final class ListDataProvider {

	/// Last supported version
	let lastVersion: Version = .v1
}

// MARK: - ContentProvider
extension ListDataProvider: ContentProvider {

	typealias Content = ListContent

	func data(ofType typeName: String, content: Content) throws -> Data {
		switch typeName.lowercased() {
		case "com.paperwave.stack.list":
			let file = DocumentFile(version: lastVersion.rawValue, content: content)
			let encoder = JSONEncoder()
			encoder.outputFormatting = .prettyPrinted
			encoder.dateEncodingStrategy = .secondsSince1970
			return try encoder.encode(file)
		default:
			throw DocumentError.unexpectedFormat
		}
	}

	func read(from data: Data, ofType typeName: String) throws -> Content {
		switch typeName.lowercased() {
		case "com.paperwave.stack.list":
			return try migrate(data)
		default:
			throw DocumentError.unexpectedFormat
		}
	}
}

// MARK: - Helpers
private extension ListDataProvider {

	func migrate(_ data: Data) throws -> Content {

		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970

		guard let versionedFile = try? decoder.decode(VersionedFile.self, from: data) else {
			throw DocumentError.unexpectedFormat
		}
		guard let version = Version(rawValue: versionedFile.version), version == lastVersion else {
			throw DocumentError.unknownVersion
		}
		guard let file = try? decoder.decode(DocumentFile<ListContent>.self, from: data) else {
			throw DocumentError.unexpectedFormat
		}
		return file.content
	}
}

// MARK: - Nested data structs
extension ListDataProvider {

	/// Version of a document file
	enum Version: String {
		case v1
	}
}
