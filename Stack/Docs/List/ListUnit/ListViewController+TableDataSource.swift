//
//  ListViewController+TableDataSource.swift
//  Stack
//
//  Created by Anton Cherkasov on 26.08.2023.
//

import Cocoa

// MARK: - NSTableViewDataSource
extension ListViewController: NSTableViewDataSource {

	func numberOfRows(in tableView: NSTableView) -> Int {
		return items.count
	}
}
