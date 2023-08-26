//
//  ListViewController+TableDelegate.swift
//  Stack
//
//  Created by Anton Cherkasov on 26.08.2023.
//

import Cocoa

// MARK: - NSTableViewDelegate
extension ListViewController: NSTableViewDelegate {

	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		guard let identifier = tableColumn?.identifier else {
			return nil
		}
		let item = items[row]
		let configuration = makeConfiguration(
			for: item,
			at: identifier
		)
		return makeCellIfNeeded(configuration)
	}

}

// MARK: - Helpers
private extension ListViewController {

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
				isEnable: item.isFavorite
			) { newValue in

			}
		default:
			fatalError()
		}
	}

	func makeCellIfNeeded<T: TableItem>(_ configuration: T) -> NSView? {
		let identifier = NSUserInterfaceItemIdentifier(T.Cell.reuseIdentifier)
		var cell = table.makeView(withIdentifier: identifier, owner: self) as? T.Cell
		if cell == nil {
			cell = T.Cell(configuration)
			cell?.identifier = identifier
		}
		cell?.configure(configuration)
		return cell
	}
}
