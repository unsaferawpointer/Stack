//
//  Period.swift
//  Stack
//
//  Created by Anton Cherkasov on 12.08.2023.
//

import Foundation

struct Period: Codable {

	/// Start of the period
	var start: Date

	/// End of the period
	var end: Date
}

// MARK: - Equatable
extension Period: Equatable { }
