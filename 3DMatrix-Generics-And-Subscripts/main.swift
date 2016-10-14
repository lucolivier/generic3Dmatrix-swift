//
//  main.swift
//  3DMatrix-Generics-And-Subscripts
//
//  Created by Luc-Olivier on 5/5/16.
//  Copyright © 2016 Luc-Olivier. All rights reserved.
//

import Foundation


public enum Matrix3DException : ErrorType {
    case OutOfRange
}

struct Matrix3D<T> {
    private let xs, ys, zs: UInt
    var description: String {
        return "[\(xs),\(ys),\(zs)]"
    }
    private var matrix : [T?]
    init(xs: UInt, ys: UInt, zs: UInt) {
        self.xs = (xs == 0 ? 1 : xs)
        self.ys = (ys == 0 ? 1 : ys)
        self.zs = (zs == 0 ? 1 : zs)
        matrix = Array(count: Int(xs * ys * zs), repeatedValue: nil)
    }
    func printAll() {
        for z: UInt in 0...2 {
            for y:UInt in 0...2 {
                for x:UInt in 0...2 {
                    let index = Int(x+(y*xs)+(z*xs*ys))
                    print("\(x),\(y),\(z): \(matrix[ index ])")
                }
            }
        }
    }
    func printAll2() {
        for item in matrix {
            print(item)
        }
    }
    var err: (error: ErrorType, message: String)?
    mutating private func isValidCell(x x: UInt, y: UInt, z: UInt) throws -> Bool {
        //if x >= 0 && x < xs && y >= 0 && y < ys && z >= 0 && z < zs { return true }
        if x < xs && y < ys && z < zs { return true }
        throw Matrix3DException.OutOfRange
    }
    subscript(x: UInt, y: UInt, z: UInt) -> T? {
        mutating get {
            self.err = nil
            do {
                if try isValidCell(x: x, y: y, z: z) { return matrix[ Int( x+(y*xs)+(z*xs*ys) ) ] }
            } catch {
                self.err = (error, "while getting x: \(x), y: \(y), z: \(z)")
            }
            return nil
        }
        set {
            self.err = nil
            do {
                if try isValidCell(x: x, y: y, z: z) { matrix[ Int( x+(y*xs)+(z*xs*ys) ) ] = newValue }
            } catch {
                self.err = (error, "while setting x: \(x), y: \(y), z: \(z) to \(newValue)")
            }
        }
    }
}

var m1 = Matrix3D<Int>(xs: 3, ys: 3, zs: 3)
print(m1.description)
m1[0,0,0] = 1
//if m1.err == nil { print(m1[0,0,0]!) }
m1[2,2,0] = 65464654
m1[0,0,1] = 99999999
m1[2,2,2] = 99999999

m1.printAll()
//m1.printAll2()

//for x in 0...2 {
//    for y in 0...2 {
//        for z in 0...2 {
//            print("\(x),\(y),\(z): \(m1[UInt(x),UInt(y),UInt(z)])")
//        }
//    }
//}


