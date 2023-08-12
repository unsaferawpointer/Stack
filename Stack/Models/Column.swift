//
//  Column.swift
//  Stack
//
//  Created by Anton Cherkasov on 12.08.2023.
//

import Foundation

/// Column model
struct Column {

	/// Column identifier
	let id: UUID

	/// Column title
	var title: String

	/// Column cards
	var cards: [Card]

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - id: Column identifier
	///    - title: Column title
	///    - cards: Column cards
	init(
		id: UUID = UUID(),
		title: String,
		cards: [Card] = []
	) {
		self.id = id
		self.title = title
		self.cards = cards
	}
}

// MARK: - Codable
extension Column: Codable {

	enum CodingKeys: CodingKey {
		case id
		case title
		case cards
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let id = try container.decode(UUID.self, forKey: .id)
		let title = try container.decode(String.self, forKey: .title)
		let cards = try container.decode([Card].self, forKey: .cards)
		self.init(id: id, title: title, cards: cards)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(title, forKey: .title)
		try container.encode(cards, forKey: .cards)
	}
}

// MARK: - Identifiable
extension Column: Identifiable { }

// MARK: - Equatable
extension Column: Equatable { }
