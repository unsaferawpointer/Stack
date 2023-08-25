//
//  TextfieldConfiguration.swift
//  Stack
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import Cocoa
import DesignSystem

struct TextfieldConfiguration: ViewConfiguration {

	typealias View = TextField

	var text: String

	var placeholder: String

	var action: ((String) -> Void)?

}

// MARK: - Equatable
extension TextfieldConfiguration: Equatable {

	static func == (lhs: TextfieldConfiguration, rhs: TextfieldConfiguration) -> Bool {
		return lhs.text == rhs.text
	}
}

// MARK: - Default configurations
extension TextfieldConfiguration {

	static var empty: TextfieldConfiguration {
		return .init(text: "", placeholder: "")
	}
}
