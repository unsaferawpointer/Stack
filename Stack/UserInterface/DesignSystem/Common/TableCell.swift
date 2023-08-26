//
//  TableCell.swift
//  Stack
//
//  Created by Anton Cherkasov on 26.08.2023.
//

import Cocoa

/// Interface of the configurable cell
public protocol TableCell: ConfigurableView {

	/// Reuse identifier
	static var reuseIdentifier: String { get }

}
