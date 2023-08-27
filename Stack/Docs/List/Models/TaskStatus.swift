//
//  TaskStatus.swift
//  Stack
//
//  Created by Anton Cherkasov on 27.08.2023.
//

import Foundation

enum TaskStatus {
	case todo
	case inProgress(start: Date, progress: Float)
	case done(start: Date, end: Date)
}

extension TaskStatus {

	func next() -> TaskStatus? {
		switch self {
		case .todo:
			return .inProgress(start: .now, progress: 0)
		case .inProgress(let start, _):
			let now: Date = .now
			return .done(start: min(start, now), end: now)
		case .done:
			return nil
		}
	}

	func previous() -> TaskStatus? {
		switch self {
		case .todo:
			return nil
		case .inProgress:
			return .todo
		case .done(let start, _):
			return .inProgress(start: start, progress: 0)
		}
	}
}

extension TaskStatus {

	var progress: Float {
		switch self {
		case .todo:
			return 0
		case .inProgress( _, let progress):
			return max(1, progress)
		case .done:
			return 1
		}
	}
}

// MARK: - Equatable
extension TaskStatus: Equatable { }

// MARK: - Codable
extension TaskStatus: Codable { }
