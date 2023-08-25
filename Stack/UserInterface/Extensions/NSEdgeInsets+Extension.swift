//
//  NSEdgeInsets+Extension.swift
//  Stack
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import Cocoa

extension NSEdgeInsets {

	init(top: CGFloat = 0) {
		self.init(top: top, left: 0, bottom: 0, right: 0)
	}

	init(left: CGFloat = 0) {
		self.init(top: 0, left: left, bottom: 0, right: 0)
	}

	init(bottom: CGFloat = 0) {
		self.init(top: 0, left: 0, bottom: bottom, right: 0)
	}

	init(right: CGFloat = 0) {
		self.init(top: 0, left: 0, bottom: 0, right: right)
	}
}
