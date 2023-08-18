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
}
