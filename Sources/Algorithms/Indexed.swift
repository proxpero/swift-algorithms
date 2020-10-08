//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift Algorithms open source project
//
// Copyright (c) 2020 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

/// A collection wrapper that iterates over the indices and elements of a
/// collection together.
public struct Indexed<Base: Collection> {
    /// The element type for an `Indexed` collection.
    public typealias Element = (index: Base.Index, element: Base.Element)
    
    /// The base collection.
    public let base: Base
}

extension Indexed: Collection {
    public var startIndex: Base.Index {
        base.startIndex
    }
    
    public var endIndex: Base.Index {
        base.endIndex
    }
    
    public subscript(position: Base.Index) -> Element {
        (index: position, element: base[position])
    }
    
    public func index(after i: Base.Index) -> Base.Index {
        base.index(after: i)
    }
    
    public func index(_ i: Base.Index, offsetBy distance: Int) -> Base.Index {
        base.index(i, offsetBy: distance)
    }
    
    public func index(_ i: Base.Index, offsetBy distance: Int, limitedBy limit: Base.Index) -> Base.Index? {
        base.index(i, offsetBy: distance, limitedBy: limit)
    }
    
    public func distance(from start: Base.Index, to end: Base.Index) -> Int {
        base.distance(from: start, to: end)
    }
}

extension Indexed: BidirectionalCollection where Base: BidirectionalCollection {
    public func index(before i: Base.Index) -> Base.Index {
        base.index(before: i)
    }
}

extension Indexed: RandomAccessCollection where Base: RandomAccessCollection {}
extension Indexed: Equatable where Base: Equatable {}
extension Indexed: Hashable where Base: Hashable {}

extension Collection {
    /// Returns a collection of pairs *(i, x)*, where *i* represents an index of
    /// the collection, and *x* represents an element.
    ///
    /// This example iterates over the indices and elements of a set, building an
    /// array consisting of indices of names with five or fewer letters.
    ///
    ///     let names: Set = ["Sofia", "Camilla", "Martina", "Mateo", "Nicolás"]
    ///     var shorterIndices: [Set<String>.Index] = []
    ///     for (i, name) in zip(names.indices, names) {
    ///         if name.count <= 5 {
    ///             shorterIndices.append(i)
    ///         }
    ///     }
    ///
    /// Returns: A collection of paired indices and elements of this collection.
    public func indexed() -> Indexed<Self> {
        Indexed(base: self)
    }
}
