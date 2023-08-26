//
//  ConfigurableView.swift
//  Stack
//
//  Created by Anton Cherkasov on 26.08.2023.
//

import Cocoa

/// Interface of the configurable view
public protocol ConfigurableView: NSView {

	associatedtype Configuration

	/// Basic initialization
	///
	/// - Parameters:
	///    - configuration: Initial configuration
	init(_ configuration: Configuration)

	/// Update view
	///
	/// - Parameters:
	///    - configuration: New configuration
	func configure(_ configuration: Configuration)
}
