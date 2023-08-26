//
//  UniqueConfiguration.swift
//  Stack
//
//  Created by Anton Cherkasov on 26.08.2023.
//

import Foundation

public protocol UniqueConfiguration: ViewConfiguration {

	var id: AnyHashable { get }
}
