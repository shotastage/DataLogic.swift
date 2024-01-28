//
//  FormerUUID.swift
//
//
//  Created by Shota Shimazu on 2023/10/18.
//

import Foundation

public struct UUID1 {
    init() {
        print("Currentry, not supported!")
    }
}

public struct UUID4 {
    private(set) var uuid: (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)

    private(set) var uuidString: String

    private(set) var uuidBridgedObject: UUID

    public init() {
        uuidBridgedObject = UUID()

        uuidString = uuidBridgedObject.uuidString
        uuid = uuidBridgedObject.uuid
    }
}
