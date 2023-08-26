//
//  TableItem.swift
//  Stack
//
//  Created by Anton Cherkasov on 26.08.2023.
//

import Cocoa

/// Cell-model configuration interface
public protocol TableItem: Equatable {

	associatedtype Cell: TableCell where Cell.Configuration == Self

}

// MARK: - methods by-default
extension TableItem {

	/// Make cell based on this configuration
	public func makeCell() -> Cell {
		return Cell(self)
	}
}
