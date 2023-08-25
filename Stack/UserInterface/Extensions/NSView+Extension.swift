//
//  NSView+Extension.swift
//  Stack
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import Cocoa

enum Layout {

	struct Edges: OptionSet {

		var rawValue: UInt8

		static var top 				= Edges(rawValue: 1 << 0)
		static var leading 			= Edges(rawValue: 1 << 1)
		static var trailing 		= Edges(rawValue: 1 << 2)
		static var bottom 			= Edges(rawValue: 1 << 3)

		static var all: Edges 		= [.top, .leading, .trailing, .bottom]

	}

	struct Sides: OptionSet {

		var rawValue: UInt8

		static var width 			= Sides(rawValue: 1 << 0)
		static var height 			= Sides(rawValue: 1 << 1)

		static var all: Sides 		= [.width, .height]
	}
}

extension NSView {

	typealias Edges = Layout.Edges

	typealias Sides = Layout.Sides

	@discardableResult
	func set(_ sides: Sides, toConstant constant: CGFloat) -> Self {
		translatesAutoresizingMaskIntoConstraints = false
		if sides.contains(.height) {
			heightAnchor.constraint(equalToConstant: constant).isActive = true
		}
		if sides.contains(.width) {
			widthAnchor.constraint(equalToConstant: constant).isActive = true
		}
		return self
	}

	@discardableResult
	func attachEdges(_ edges: Edges, toView view: NSView, inset: CGFloat = 0) -> Self {
		translatesAutoresizingMaskIntoConstraints = false
		if !view.subviews.contains(where: { $0 === self }) {
			view.addSubview(self)
		}
		if edges.contains(.top) {
			topAnchor.constraint(equalTo: view.topAnchor, constant: inset)
				.isActive = true
		}
		if edges.contains(.leading) {
			leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset)
				.isActive = true
		}
		if edges.contains(.trailing) {
			trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset)
				.isActive = true
		}
		if edges.contains(.bottom) {
			bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -inset)
				.isActive = true
		}
		return self
	}
}
