//
//  ListDocument.swift
//  Stack
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import Cocoa

class ListDocument: NSDocument {

	var storage: DocumentStorage<ListContent>

	override init() {
		self.storage = DocumentStorage<ListContent>(
			initialState: .initial,
			provider: ListDataProvider()
		)
		super.init()
		storage.addObservation(for: self) { [weak self] _, content in
			self?.updateChangeCount(.changeDone)
		}
	}

	override class var autosavesInPlace: Bool {
		return true
	}

	override func makeWindowControllers() {
		// Returns the Storyboard that contains your Document window.
		let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
		let windowController = storyboard.instantiateController(
			withIdentifier: NSStoryboard.SceneIdentifier("Backlog Window Controller")
		) as! NSWindowController
		windowController.window?.contentViewController = ListUnitAssembly().build(storage: storage)
		self.addWindowController(windowController)
	}

	override func data(ofType typeName: String) throws -> Data {
		return try storage.data(ofType: typeName)
	}

	override func read(from data: Data, ofType typeName: String) throws {
		try storage.read(from: data, ofType: typeName)
	}

}
