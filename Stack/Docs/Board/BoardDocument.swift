//
//  BoardDocument.swift
//  Stack
//
//  Created by Anton Cherkasov on 08.08.2023.
//

import Cocoa

class BoardDocument: NSDocument {

	var storage: DocumentStorage<BoardContent>

	override init() {
		self.storage = DocumentStorage<BoardContent>(
			initialState: .initial,
			provider: BoardDataProvider()
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
			withIdentifier: NSStoryboard.SceneIdentifier("Document Window Controller")
		) as! NSWindowController
		windowController.window?.contentViewController = BoardUnitAssembly().build(storage: storage)
		self.addWindowController(windowController)
	}

	override func data(ofType typeName: String) throws -> Data {
		return try storage.data(ofType: typeName)
	}

	override func read(from data: Data, ofType typeName: String) throws {
		try storage.read(from: data, ofType: typeName)
	}

}
