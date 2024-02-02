//
//  LogicProcedure.swift
//
//
//  Created by Shota Shimazu on 2024/01/28.
//

import Foundation

protocol LogicProcedure {
    associatedtype Input
    associatedtype Output

    var input: Input? { get set }
    var value: Output { get set }

    mutating func execute() -> Output?
}

public enum ProcedureOutput<Value> {
    case value(Value)
    case void
}
