//
//  DocumentDataRepresentation.swift
//  Stack
//
//  Created by Anton Cherkasov on 16.08.2023.
//

import Foundation

protocol DocumentDataRepresentation {

	/// Returns data of a document content
	///
	/// - Parameters:
	///    - typeName: Type identifier
	/// - Returns: Document data
	func data(ofType typeName: String) throws -> Data

	/// Read file data
	///
	/// - Parameters:
	///    - data: File data
	///    - typeName: Type identifier
	func read(from data: Data, ofType typeName: String) throws
}
