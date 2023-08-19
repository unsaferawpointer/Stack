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
}

private extension String {

	func localized() -> String {
		return NSLocalizedString(self, tableName: "BoardLocalizable", bundle: .main, value: "", comment: "")
	}
}
