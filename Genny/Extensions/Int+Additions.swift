//
//  Int+Additions.swift
//  Genny
//
//  Created by Garri Adrian Nablo on 6/18/17.
//
//

import Foundation

func sizeof <T> (_ : T.Type) -> Int {
    return (MemoryLayout<T>.size)
}

func sizeof <T> (_ : T) -> Int {
    return (MemoryLayout<T>.size)
}

func sizeof <T> (_ value : [T]) -> Int {
    return (MemoryLayout<T>.size * value.count)
}
