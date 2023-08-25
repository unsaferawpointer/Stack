//
//  ListUnitAssembly.swift
//  Stack
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import Cocoa

final class ListUnitAssembly {

	/// Builds `List` unit
	///
	/// - Parameters:
	///     - storage: Content storage
	func build(storage: any DocumentDataPublisher<ListContent>) -> NSViewController {

		let presenter = ListPresenter()
		let interactor = ListInteractor(storage: storage)

		presenter.interactor = interactor
		interactor.presenter = presenter

		return ListViewController { viewController in
			viewController.output = presenter
			presenter.view = viewController
		}
	}
}
