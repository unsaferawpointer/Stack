//
//  Card.swift
//  Stack
//
//  Created by Anton Cherkasov on 12.08.2023.
//

import Foundation

struct Card {

	let id: UUID

	var text: String

	var tag: String?

	var category: Category

	var estimation: Int

	init(
		id: UUID = UUID(),
		text: String,
		tag: String? = nil,
		category: Category = [],
		estimation: Int = 0
	) {
		self.id = id
		self.text = text
		self.tag = tag
		self.category = category
		self.estimation = estimation
	}
}

// MARK: - Codable
extension Card: Codable {

	enum CodingKeys: CodingKey {
		case id
		case text
		case tag
		case category
		case estimation
	}

	init(from decoder: Decoder) throws {

		let container = try decoder.container(keyedBy: CodingKeys.self)

		let id = try container.decode(UUID.self, forKey: .id)
		let text = try container.decode(String.self, forKey: .text)
		let tag = try container.decodeIfPresent(String.self, forKey: .tag)
		let category = try container.decode(Category.self, forKey: .category)
		let estimation = try container.decode(Int.self, forKey: .estimation)
		self.init(id: id, text: text, tag: tag, category: category, estimation: estimation)
	}

	func encode(to encoder: Encoder) throws {

		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(id, forKey: .id)
		try container.encode(text, forKey: .text)
		try container.encode(tag, forKey: .tag)
		try container.encode(category, forKey: .category)
		try container.encode(estimation, forKey: .estimation)
	}
}

// MARK: - Identifiable
extension Card: Identifiable { }

// MARK: - Equatable
extension Card: Equatable { }
