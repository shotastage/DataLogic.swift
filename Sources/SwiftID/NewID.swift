//
//  NewID.swift
//
//  Created by Shota Shimazu on 2023/10/17.
//  Copyright © 2023 Shota Shimazu. All rights reserved.
//

import Foundation

#if os(iOS) || os(macOS) || os(watchOS) || os(tvOS)
import Security
#else
import OpenSSL
#endif


public struct NewID {
    let timestamp64bit = Int64(Date().timeIntervalSince1970 * 1000)

    init() {
        print("Now under construction...")
    }
}
