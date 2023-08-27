//
//  ListUnitTableAdapter.swift
//  Stack
//
//  Created by Anton Cherkasov on 27.08.2023.
//

import Cocoa

/// Table adapter
final class TableAdapter: NSObject {

	typealias Model = ListUnitModel.TaskModel

	var snapshot: DataSnapshot<Model> = .empty

	weak var table: NSTableView?

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - table: animated table-view
	init(table: NSTableView) {
		self.table = table
		super.init()
		self.table?.delegate = self
		self.table?.dataSource = self
	}
}

// MARK: - NSTableViewDataSource
extension TableAdapter: NSTableViewDataSource {

	func numberOfRows(in tableView: NSTableView) -> Int {
		return snapshot.count
	}
}

// MARK: - NSTableViewDelegate
extension TableAdapter: NSTableViewDelegate {

	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		guard let identifier = tableColumn?.identifier else {
			return nil
		}
		let item = snapshot[row]
		let configuration = makeConfiguration(
			for: item,
			at: identifier
		)
		return makeCellIfNeeded(configuration)
	}
}

// MARK: - Helpers
private extension TableAdapter {

	func makeConfiguration(for item: ListUnitModel.TaskModel, at column: NSUserInterfaceItemIdentifier) -> any TableItem {
		switch column {
		case .status:
			return ToggleItem(
				imageName: "app",
				alternativeImage: "checkmark",
				tintColor: .yellow,
				isEnable: item.isDone
			) { newValue in

			}
		case .text:
			return TextFieldItem(
				text: item.text,
				font: .headline,
				textColor: item.isDone ? .tertiaryLabelColor : .controlTextColor,
				placeholder: ""
			) { newValue in

			}
		case .isUrgent:
			return ToggleItem(
				imageName: "bolt",
				alternativeImage: "bolt.fill",
				tintColor: .systemOrange,
				isEnable: item.isUrgent
			) { newValue in
				
			}
		default:
			fatalError()
		}
	}

	func makeCellIfNeeded<T: TableItem>(_ configuration: T) -> NSView? {
		let identifier = NSUserInterfaceItemIdentifier(T.Cell.reuseIdentifier)
		var cell = table?.makeView(withIdentifier: identifier, owner: self) as? T.Cell
		if cell == nil {
			cell = T.Cell(configuration)
			cell?.identifier = identifier
		}
		cell?.configure(configuration)
		return cell
	}

	func configureCell<T: TableItem>(configuration: T, column: Int, at row: Int) {
		guard let field = table?.view(atColumn: column, row: row, makeIfNecessary: false) as? T.Cell else {
			return
		}
		field.configure(configuration)
	}

	func configure(item: ListUnitModel.TaskModel, at row: Int) {
		guard let table else {
			return
		}
		for (index, identifier) in table.tableColumns.map(\.identifier).enumerated() {
			let config = makeConfiguration(for: item, at: identifier)
			configureCell(configuration: config, column: index, at: row)
		}
	}
}

// MARK: - Common interface
extension TableAdapter {

	func scrollTo(_ id: UUID) {
		guard let table, let first = snapshot.indexes(for: Set([id])).first else {
			return
		}
		NSAnimationContext.runAnimationGroup { context in
			context.allowsImplicitAnimation = true
			context.duration = 0.3
			table.scrollRowToVisible(first)
		}
	}

	func performAnimation(_ new: DataSnapshot<Model>) {

		guard let table else {
			return
		}

		snapshot.update(from: new) { index, updated in
			configure(item: updated, at: index)
		}

		let selection = table.selectedRowIndexes
		let selected = snapshot.identifiers(for: selection)

		table.beginUpdates()
		snapshot.difference(from: new) { index in
			table.removeRows(at: index)
		} insert: { index in
			table.insertRows(at: index)
		}
		table.endUpdates()

		let selectedRows = snapshot.indexes(for: selected)
		table.selectRowIndexes(selectedRows, byExtendingSelection: false)
	}
}

extension NSUserInterfaceItemIdentifier {

	static let text = NSUserInterfaceItemIdentifier("text")

	static let isUrgent = NSUserInterfaceItemIdentifier("is_urgent")

	static let status = NSUserInterfaceItemIdentifier("status")
}
