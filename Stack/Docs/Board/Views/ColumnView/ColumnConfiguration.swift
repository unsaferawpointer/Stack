//
//  ColumnConfiguration.swift
//  Stack
//
//  Created by Anton Cherkasov on 17.08.2023.
//

import Foundation
import DesignSystem

struct ColumnConfiguration: UniqueConfiguration {

	typealias View = ColumnView

	var id: AnyHashable

	var title: String

	var placeholder: String?

	var menu: MenuConfiguration?

	var action: ((String) -> Void)?
}

// MARK: - Equatable
extension ColumnConfiguration: Equatable {

	static func == (lhs: ColumnConfiguration, rhs: ColumnConfiguration) -> Bool {
		return lhs.id == rhs.id
		&& lhs.title == rhs.title
		&& lhs.placeholder == rhs.placeholder
		&& lhs.menu == rhs.menu
	}
}
