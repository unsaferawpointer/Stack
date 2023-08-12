//
//  SprintContent.swift
//  Stack
//
//  Created by Anton Cherkasov on 12.08.2023.
//

import Foundation
import UniformTypeIdentifiers

struct SprintContent {

	/// Sprint identifier
	var id: UUID

	/// Sprint period
	var period: Period

	/// Velocity in story points
	var velocity: Int

	/// Board column
	var columns: [Column]

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
		columns: [Column] = []
	) {
		self.id = id
		self.period = period
		self.velocity = velocity
		self.columns = columns
	}
}

// MARK: - Codable
extension SprintContent: Codable { }

// MARK: - Equatable
extension SprintContent: Equatable { }

// MARK: - Helpers
extension SprintContent {

	static var empty: SprintContent {
		let period = Period(start: .now, end: .now)
		return .init(period: period, velocity: 0)
	}
}
