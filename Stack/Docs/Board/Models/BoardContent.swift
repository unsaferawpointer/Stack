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
	var id: UUID

	/// Sprint period
	var period: Period

	/// Sprint velocity in story points
	var velocity: Int

	/// Board column
	var columns: [BoardColumn]

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
		period: Period,
		velocity: Int = 0,
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

	static var empty: BoardContent {
		let period = Period(start: .now, end: .now)
		return .init(period: period, velocity: 0)
	}
}
