//
//  DataProvider.swift
//  Stack
//
//  Created by Anton Cherkasov on 12.08.2023.
//

import Foundation

/// Data provider interface
protocol DataProvider {

	func data(ofType typeName: String) throws -> Data

	func read(from data: Data, ofType typeName: String) throws
}
