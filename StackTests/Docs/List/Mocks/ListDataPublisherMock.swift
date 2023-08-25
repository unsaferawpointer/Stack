//
//  ListDataPublisherMock.swift
//  StackTests
//
//  Created by Anton Cherkasov on 25.08.2023.
//

@testable import Stack

final class ListDataPublisherMock {

	var invocations: [Action] = []

	var stubs = Stubs()
}

// MARK: - DocumentDataPublisher
extension ListDataPublisherMock: DocumentDataPublisher {

	typealias State = ListContent

	var state: ListContent {
		stubs.state
	}

	func modificate(_ block: (inout ListContent) -> Void) {
		invocations.append(.modificate)
		block(&stubs.modificated)
	}

	func addObservation<O>(for object: O, handler: @escaping (O, ListContent) -> Void) where O : AnyObject {
		invocations.append(.addObservation)
		stubs.observation = { [weak object] value in
			guard let object else {
				return
			}
			handler(object, value)
		}
	}
}

extension ListDataPublisherMock {

	enum Action {
		case modificate
		case addObservation
	}

	struct Stubs {
		var state: ListContent = .initial
		var modificated: ListContent = .initial
		var observation: ((ListContent) -> Void)?
	}
}
