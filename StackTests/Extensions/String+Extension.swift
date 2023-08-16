//
//  String+Extension.swift
//  StackTests
//
//  Created by Anton Cherkasov on 16.08.2023.
//

import Foundation

extension String {

	static var random: String {
		return UUID().uuidString
	}
}
