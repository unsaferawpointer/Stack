//
//  SprintDocument.swift
//  Stack
//
//  Created by Anton Cherkasov on 08.08.2023.
//

import Cocoa

class SprintDocument: NSDocument {

	var provider: SprintDataProvider

	override init() {
		self.provider = SprintDataProvider(content: .empty)
		super.init()
	}

	override class var autosavesInPlace: Bool {
		return true
	}

	override func makeWindowControllers() {
		// Returns the Storyboard that contains your Document window.
		let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
		let windowController = storyboard.instantiateController(
			withIdentifier: NSStoryboard.SceneIdentifier("Document Window Controller")
		) as! NSWindowController
		self.addWindowController(windowController)
	}

	override func data(ofType typeName: String) throws -> Data {
		return try provider.data(ofType: typeName)
	}

	override func read(from data: Data, ofType typeName: String) throws {
		try provider.read(from: data, ofType: typeName)
	}

}
