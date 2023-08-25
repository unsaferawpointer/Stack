//
//  MenuButtonConfiguration.swift
//  Stack
//
//  Created by Anton Cherkasov on 25.08.2023.
//

import Cocoa
import DesignSystem

struct MenuButtonConfiguration: ViewConfiguration {

	typealias View = MenuButton

	var imageName: String

	var menu: MenuConfiguration

	// MARK: - Initialization

	init(imageName: String, menu: MenuConfiguration) {
		self.imageName = imageName
		self.menu = menu
	}

}

// MARK: - Default configurations
extension MenuButtonConfiguration {

	static var empty: MenuButtonConfiguration {
		return .init(imageName: "", menu: .init(items: []))
	}
}
