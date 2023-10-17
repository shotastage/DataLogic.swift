//
//  FormerUUID.swift
//
//
//  Created by Shota Shimazu on 2023/10/18.
//

import Foundation


public struct UUID4 {

    private(set) var uuid: (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)
    
    private(set) var uuidString: String
    
    private(set) var uuidBridgedObject: UUID

    public init() {
        self.uuidBridgedObject = UUID()

        self.uuidString = self.uuidBridgedObject.uuidString
        self.uuid = self.uuidBridgedObject.uuid
    }
}
