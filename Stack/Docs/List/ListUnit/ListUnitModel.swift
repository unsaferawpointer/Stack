//
//  ListUnitModel.swift
//  Stack
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import Foundation
import DesignSystem

struct ListUnitModel {

	/// Items displayed by table
	var items: [TaskModel] = []
}

// MARK: - Nested data structs
extension ListUnitModel {

	/// Task view-model
	struct TaskModel {

		var id: UUID

		var text: String

		var isDone: Bool

		var isUrgent: Bool
	}
}

// MARK: - IdentifiableItem
extension ListUnitModel.TaskModel: IdentifiableItem { }
