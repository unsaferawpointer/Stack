//
//  DocumentDataPublisher.swift
//  Stack
//
//  Created by Anton Cherkasov on 16.08.2023.
//

import Foundation

protocol DocumentDataPublisher<State> {

	associatedtype State

	var state: State { get }

	func modificate(_ block: (inout State) -> Void)

	func addObservation<O: AnyObject>(
		for object: O,
		handler: @escaping (O, State) -> Void
	)
}
