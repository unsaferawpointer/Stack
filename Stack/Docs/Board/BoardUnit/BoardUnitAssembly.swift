//
//  BoardUnitAssembly.swift
//  Stack
//
//  Created by Anton Cherkasov on 18.08.2023.
//

import Cocoa

final class BoardUnitAssembly {

	/// Builds `Board` unit
	///
	/// - Parameters:
	///     - storage: Content storage
	func build(storage: any DocumentDataPublisher<BoardContent>) -> NSViewController {

		let presenter = BoardPresenter()
		let interactor = BoardInteractor(storage: storage)

		presenter.interactor = interactor
		interactor.presenter = presenter

		return BoardViewController { viewController in
			viewController.output = presenter
			presenter.view = viewController
		}
	}
}
