//
//  HStackView.swift
//  Stack
//
//  Created by Anton Cherkasov on 26.08.2023.
//

import Cocoa

public class HStackView: NSView {

	private(set) var items: [any UniqueConfiguration] = []
	private(set) var views: [NSView] = []

	// MARK: - UI-Properties

	lazy var container: NSStackView = {
		let view = NSStackView()
		view.orientation = .horizontal
		view.distribution = .fillEqually
		return view
	}()

	// MARK: - Initialization

	public init() {
		super.init(frame: .zero)
		configureUserInterface()
	}

	@available(*, unavailable, message: "Use init()")
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Life-cycle

	public override func layout() {
		super.layout()
		print(#function)
		container.subviews.forEach { view in
			view.frame.size.height = frame.size.height
		}
	}

}

// MARK: - Helpers
private extension HStackView {

	func configureUserInterface() {
		addSubview(container)
		container.autoresizingMask = [.height, .width]
		container.frame = .init(origin: .zero, size: frame.size)
	}
}

extension HStackView {

	public var spacing: CGFloat {
		get {
			container.spacing
		}
		set {
			container.spacing = newValue
		}
	}
}

extension HStackView {

	public func reloardItems(_ new: [any UniqueConfiguration]) {
		performAnimation(new)
	}

	func performAnimation(_ new: [any UniqueConfiguration]) {

		let old = items.map(\.id)
		let diff = new.map(\.id).difference(from: old).inferringMoves()

		for (index, item) in items.enumerated() {
			configure(item: item, index: index)
		}

		self.items = new

		var moved: [AnyHashable: NSView] = [:]


		NSAnimationContext.runAnimationGroup({ context in
			context.duration = 0.3
			for change in diff {
				switch change {
				case let .remove(oldOffset, id, newOffset):
					let view = views.remove(at: oldOffset)
					if newOffset != nil {
						moved[id] = view
					}
					self.container.animator().removeView(view)
				case let .insert(newOffset, id, _):
					let view: NSView = {
						if let movedView = moved[id] {
							return movedView
						} else {
							return items[newOffset].makeView()
						}
					}()
					views.insert(view, at: newOffset)
					view.frame.size.height = container.frame.height
					view.frame.origin.x = getOffset(for: newOffset)
					view.autoresizingMask = [.height]
					self.container.animator().insertArrangedSubview(view, at: newOffset)
				}
			}
		}, completionHandler: {

		})
	}

	func configure<T: ViewConfiguration>(item: T, index: Int) {
		guard let view = views[index] as? T.View else {
			return
		}
		view.configure(item)
	}

	func getOffset(for index: Int) -> CGFloat {
		let numberOfViews = container.arrangedSubviews.count
		if index == 0 {
			return 0
		} else if index == numberOfViews {
			return container.frame.width
		} else {
			return (container.arrangedSubviews[index].frame.minX + container.arrangedSubviews[index - 1].frame.maxX) / CGFloat(2)
		}
	}
}

extension NSStackView {

	func removeView(at index: Int) {
		let view = subviews[index]
		removeView(view)
	}
}
