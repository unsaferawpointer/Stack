//
//  ListLocalization.swift
//  Stack
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import Foundation

/// List Unit localization
protocol ListUnitLocalization {

	var defaultTaskText: String { get }

	var deleteMenuItemTitle: String { get }
}

/// List Unit localization
final class ListLocalization { }

// MARK: - ListUnitLocalization
extension ListLocalization: ListUnitLocalization {

	var defaultTaskText: String {
		return "default_task_text".localized()
	}

	var deleteMenuItemTitle: String {
		return "delete_menu_item_title".localized()
	}
}

private extension String {

	func localized() -> String {
		return NSLocalizedString(self, tableName: "ListLocalizable", bundle: .main, value: "", comment: "")
	}
}

