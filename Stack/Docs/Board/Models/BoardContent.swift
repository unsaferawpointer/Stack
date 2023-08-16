//
//  BoardContent.swift
//  Stack
//
//  Created by Anton Cherkasov on 12.08.2023.
//

import Foundation
import UniformTypeIdentifiers

struct BoardContent {

	/// Board identifier
	private(set) var id: UUID

	/// Sprint period
	private(set) var period: Period?

	/// Sprint velocity in story points
	private(set) var velocity: Int?

	/// Board column
	private(set) var columns: [BoardColumn]

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - id: Content identifier
	///    - period: Sprint period
	///    - velocity: Sprint velocity
	///    - columns: Board columns
	init(
		id: UUID = UUID(),
		period: Period? = nil,
		velocity: Int? = nil,
		columns: [BoardColumn] = []
	) {
		self.id = id
		self.period = period
		self.velocity = velocity
		self.columns = columns
	}
}

// MARK: - Codable
extension BoardContent: Codable { }

// MARK: - Equatable
extension BoardContent: Equatable { }

// MARK: - Helpers
extension BoardContent {

	static var initial: BoardContent {
		return .init()
	}
}
