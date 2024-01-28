//
//  File.swift
//  
//
//  Created by Shota Shimazu on 2024/01/28.
//

import Foundation

protocol LogicProcedure {
    var into: Any { get set }
    var out: Any { get set }
    var procedure: () -> Void { get set }
    func `do`()
}

extension LogicProcedure {
    func `do`() {
        //
    }
}
