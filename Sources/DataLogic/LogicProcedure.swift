//
//  File.swift
//  
//
//  Created by Shota Shimazu on 2024/01/28.
//

import Foundation

protocol LogicProcedure {
    associatedtype Input
    associatedtype Output

    var input: Input? { get set }
    var output: Output { get set }

    mutating func execute() -> Output?
}

enum ProcedureOutput<Value> {
    case value(Value)
    case void
}
