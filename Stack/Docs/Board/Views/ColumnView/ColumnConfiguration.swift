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

	var header: HeaderConfiguration
}

// MARK: - Equatable
extension ColumnConfiguration: Equatable {

	static func == (lhs: ColumnConfiguration, rhs: ColumnConfiguration) -> Bool {
		return lhs.id == rhs.id && lhs.header == rhs.header
	}
}
