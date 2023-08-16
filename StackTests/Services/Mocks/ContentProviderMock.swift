//
//  ContentProviderMock.swift
//  StackTests
//
//  Created by Anton Cherkasov on 16.08.2023.
//

import Foundation
@testable import Stack

final class ContentProviderMock {

	var stubs = Stubs()
}

// MARK: - ContentProvider
extension ContentProviderMock: ContentProvider {

	typealias Content = String

	func data(ofType typeName: String, content: String) throws -> Data {
		stubs.data
	}

	func read(from data: Data, ofType typeName: String) throws -> String {
		stubs.content
	}
}

// MARK: - Nested data structs
extension ContentProviderMock {

	struct Stubs {
		var data: Data = .random
		var content: Content = .random
	}
}
