//
//  HeaderConfiguration.swift
//  Stack
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import Cocoa
import DesignSystem

struct HeaderConfiguration: ViewConfiguration {

	typealias View = ColumnHeader

	var title: TextfieldConfiguration

	var button: MenuButtonConfiguration

}

// MARK: - Equatable
extension HeaderConfiguration: Equatable {

	static func == (lhs: HeaderConfiguration, rhs: HeaderConfiguration) -> Bool {
		return lhs.title == rhs.title
		&& lhs.button == rhs.button
	}
}

// MARK: - Default configurations
extension HeaderConfiguration {

	static var empty: HeaderConfiguration {
		return .init(
			title: .empty,
			button: .empty
		)
	}
}
