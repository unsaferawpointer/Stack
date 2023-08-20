//
//  BoardLocalization.swift
//  Stack
//
//  Created by Anton Cherkasov on 19.08.2023.
//

import Foundation

/// Board Unit localization
protocol BoardUnitLocalization {

	var defaultColumnTitle: String { get }
	var columnHeaderPlaceholder: String { get }

	// MARK: - Context menu items

	var newCardContextMenuItemTitle: String { get }
	var moveForwardContextMenuItemTitle: String { get }
	var moveBackwardContextMenuItemTitle: String { get }
	var deleteContextMenuItemTitle: String { get }
}

/// Board Unit localization
final class BoardLocalization { }

// MARK: - BoardUnitLocalization
extension BoardLocalization: BoardUnitLocalization {

	var defaultColumnTitle: String {
		return "default_column_title".localized()
	}

	var columnHeaderPlaceholder: String {
		return "column_header_placeholder".localized()
	}

	// MARK: - Context menu items

	var newCardContextMenuItemTitle: String {
		return "new_card_context_menu_item_title".localized()
	}

	var moveForwardContextMenuItemTitle: String {
		return "move_forward_context_menu_item_title".localized()
	}

	var moveBackwardContextMenuItemTitle: String {
		return "move_backward_context_menu_item_title".localized()
	}

	var deleteContextMenuItemTitle: String {
		return "delete_context_menu_item_title".localized()
	}
}

private extension String {

	func localized() -> String {
		return NSLocalizedString(self, tableName: "BoardLocalizable", bundle: .main, value: "", comment: "")
	}
}
