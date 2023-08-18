//
//  BoardDocumentDataPublisher.swift
//  StackTests
//
//  Created by Anton Cherkasov on 18.08.2023.
//

@testable import Stack

final class BoardDataPublisherMock {

	var invocations: [Action] = []

	var stubs = Stubs()
}

// MARK: - DocumentDataPublisher
extension BoardDataPublisherMock: DocumentDataPublisher {

	typealias State = BoardContent

	var state: BoardContent {
		stubs.state
	}

	func modificate(_ block: (inout BoardContent) -> Void) {
		invocations.append(.modificate)
		block(&stubs.modificated)
	}

	func addObservation<O>(for object: O, handler: @escaping (O, BoardContent) -> Void) where O : AnyObject {
		invocations.append(.addObservation)
		stubs.observation = { [weak object] value in
			guard let object else {
				return
			}
			handler(object, value)
		}
	}
}

extension BoardDataPublisherMock {

	enum Action {
		case modificate
		case addObservation
	}

	struct Stubs {
		var state: BoardContent = .initial
		var modificated: BoardContent = .initial
		var observation: ((BoardContent) -> Void)?
	}
}
