//
//  NSScrollView+Extension.swift
//  Stack
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import Cocoa

extension NSScrollView {

	static func plain() -> NSScrollView {
		let view = NSScrollView()
		view.borderType = .noBorder
		view.hasHorizontalScroller = false
		view.autohidesScrollers = true
		view.hasVerticalScroller = false
		view.automaticallyAdjustsContentInsets = true
		return view
	}
}
