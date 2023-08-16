//
//  Data+Extension.swift
//  StackTests
//
//  Created by Anton Cherkasov on 16.08.2023.
//

import Foundation

extension Data {

	static var random: Data {
		return String.random.data(using: .utf8) ?? Data()
	}
}
