//
//  DataSnapshot.swift
//  Stack
//
//  Created by Anton Cherkasov on 27.08.2023.
//

import Foundation

protocol IdentifiableItem {
	var id: UUID { get }
}

/// Snapshot of the table data
struct DataSnapshot<Item: IdentifiableItem> {

	private(set) var items: [Item]

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - items: Items
	init(items: [Item]) {
		self.items = items
	}
}

// MARK: - Basic methods
extension DataSnapshot {

	/// - Returns: Number of items
	var count: Int {
		return items.count
	}

	/// - Returns: Item ID set
	func identifiers(for indexSet: IndexSet) -> Set<UUID> {
		let identifiers = indexSet.map { index in
			items[index].id
		}
		return Set(identifiers)
	}

	func indexes(for identifiers: Set<UUID>) -> IndexSet {
		let indexes = identifiers.compactMap { id in
			items.firstIndex(where: \.id, equalsTo: id)
		}
		return IndexSet(indexes)
	}

	/// Calculate difference between current and new snapshot
	mutating func difference(from new: DataSnapshot, remove: (Int) -> Void, insert: (Int) -> Void) {
		let changes = new.items.difference(from: items) { old, new in
			return old.id == new.id
		}
		for change in changes {
			switch change {
			case .remove(let offset, _, _):
				items.remove(at: offset)
				remove(offset)
			case .insert(let offset, let item, _):
				items.insert(item, at: offset)
				insert(offset)
			}
		}
	}

	/// Update current items without remove / insert operations
	mutating func update(from new: DataSnapshot, block: (Int, Item) -> Void) {

		let oldIdentifiers = Set(items.map(\.id))
		let updated = oldIdentifiers.intersection(new.items.map(\.id))

		for id in updated {
			guard
				let index = items.firstIndex(where: \.id, equalsTo: id),
				let newItem = new.items.first(where: { $0.id == id })
			else {
				continue
			}
			block(index, newItem)
			items[index] = newItem
		}
	}
}

// MARK: - Subscript
extension DataSnapshot {

	subscript(_ index: Int) -> Item {
		return items[index]
	}
}

// MARK: - Default snapshots
extension DataSnapshot {

	static var empty: DataSnapshot {
		return .init(items: [])
	}
}
