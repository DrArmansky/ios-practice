//
//  main.swift
//  multiSum
//
//  Created by Kira on 08.11.2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

protocol Summable {
   associatedtype Member
   static func +(a: Self, b: Self) -> Self
}

extension String: Summable {
   typealias Member = String
   static func +(a: Member, b: Member) -> Self {
       return "\(a) \(b)"
   }
}

extension Set: Summable {
    typealias Member = Set
    static func +(a: Member, b: Member) -> Self {
        return a.union(b)
    }
}

extension Array: Summable {
    typealias Member = Array
    static func +(a: Member, b: Member) -> Self {
        var c = a
        c.append(contentsOf: b)
        return c
    }
}

extension Dictionary: Summable {
    typealias Member = Dictionary
    static func +(a: Member, b: Member) -> Self {
        return a.reduce(b) { key, val in
            var key = key
            key[val.0] = val.1
            return key
        }
    }
}

extension Int: Summable {
    typealias Member = Int
}

extension Float: Summable {
    typealias Member = Float
}

extension Double: Summable {
    typealias Member = Double
}

func add<T: Summable>( a: T, b: T) -> T {
   return a + b
}
