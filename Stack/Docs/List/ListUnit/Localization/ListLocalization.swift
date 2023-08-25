//
//  ListLocalization.swift
//  Stack
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import Foundation

/// List Unit localization
protocol ListUnitLocalization { }

/// List Unit localization
final class ListLocalization { }

// MARK: - ListUnitLocalization
extension ListLocalization: ListUnitLocalization { }

private extension String {

	func localized() -> String {
		return NSLocalizedString(self, tableName: "ListLocalizable", bundle: .main, value: "", comment: "")
	}
}

