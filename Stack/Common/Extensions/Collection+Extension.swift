//
//  Collection+Extension.swift
//  Stack
//
//  Created by Anton Cherkasov on 27.08.2023.
//

import Foundation

extension Collection {

	/// Returns the first index of the object for which the condition is satisfied
	///
	/// - Parameters:
	///    - keyPath: Property keypath
	///    - value: Value
	func firstIndex<T: Equatable>(where keyPath: KeyPath<Element, T>, equalsTo value: T) -> Index? {
		return firstIndex {
			$0[keyPath: keyPath] == value
		}
	}
}
