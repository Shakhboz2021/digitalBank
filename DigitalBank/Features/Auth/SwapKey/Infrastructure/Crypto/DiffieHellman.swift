//
//  DiffieHellman.swift
//  DigitalBank
//
//  Created by Muhammad on 06/08/25.
//

import Foundation
import BigInt

public class DiffieHellman: NSObject {
    let bitLength: Int = 512
    var a, p, g: BigUInt? // a is a private key, p(prime number) and g(a primitive root of P) public keys
    var bigA, bigB: BigUInt?
    var bigK: BigUInt?
    
    public override init() {
        super.init()
    }
    
    public convenience init(a: String = "", p: String = "", g: String = "") {
        self.init()
        self.a = BigUInt(a)
        self.p = BigUInt(p)
        self.g = BigUInt(g)
    }
    
    @objc public func get_a() -> String {
        a = BigUInt.randomInteger(withMaximumWidth: bitLength)
        return a!.description
    }
    
    @objc public func get_p() -> String {
        p = BigUInt.randomInteger(withMaximumWidth: bitLength)
        return p!.description
    }
    
    @objc public func get_g() -> String {
        g = BigUInt.randomInteger(withMaximumWidth: bitLength)
        return g!.description
    }
    
    @objc public func get_bigA() -> String { // (g^a)mod(p)
        bigA = g?.power(a!, modulus: p!)
        return bigA!.description
    }
    
    @objc public func getKeyK(keyB:String) -> String {
        let bigB = BigUInt.init(extendedGraphemeClusterLiteral: keyB)
        bigK = bigB.power(a!, modulus: p!)
        return bigK!.description
    }
}

