//
//  ArrayExtensions.swift
//  StrayCompanion
//
//  Created by Luis Hankel on 02/03/2020.
//  Copyright © 2020 Luis Hankel. All rights reserved.
//

extension Array {
    func chunked(size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
