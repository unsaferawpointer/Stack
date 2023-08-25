//
//  ListContent.swift
//  Stack
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import Foundation
import UniformTypeIdentifiers

struct ListContent {

	/// List identifier
	private(set) var id: UUID

	/// Board column
	var tasks: [TaskItem]

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - id: Content identifier
	///    - tasks: List tasks
	init(
		id: UUID = UUID(),
		tasks: [TaskItem] = []
	) {
		self.id = id
		self.tasks = tasks
	}
}

// MARK: - Codable
extension ListContent: Codable { }

// MARK: - Equatable
extension ListContent: Equatable { }

// MARK: - Helpers
extension ListContent {

	static var initial: ListContent {
		return .init()
	}
}
