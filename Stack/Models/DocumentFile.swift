//
//  DocumentFile.swift
//  Stack
//
//  Created by Anton Cherkasov on 12.08.2023.
//

import Foundation

struct DocumentFile<Content: Codable>: Codable {

	let version: String

	var content: Content
}
