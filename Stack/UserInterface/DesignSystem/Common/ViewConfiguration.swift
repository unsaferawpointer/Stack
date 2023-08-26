//
//  ViewConfiguration.swift
//  Stack
//
//  Created by Anton Cherkasov on 26.08.2023.
//

import Cocoa

/// View-model configuration interface
public protocol ViewConfiguration: Equatable {

	associatedtype View: ConfigurableView where View.Configuration == Self

}

// MARK: - methods by-default
extension ViewConfiguration {

	/// Make view based on this configuration
	public func makeView() -> View {
		return View(self)
	}
}
