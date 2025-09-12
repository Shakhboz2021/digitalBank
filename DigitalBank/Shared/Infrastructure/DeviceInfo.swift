//
//  DeviceInfo.swift
//  DigitalBank
//
//  Created by Muhammad on 27/08/25.
//

import UIKit

enum DeviceInfo {
    static func current() -> AppDevice {
        .init(
            deviceType: "I",
            deviceCode: Keychain.get(key: .deviceID),  
            deviceName: UIDevice.current.name,
            systemVersion: UIDevice.current.systemName
        )
    }
}

// 🔒 Private extension – model identifier ("iPhone16,2")
extension UIDevice {
    fileprivate var modelIdentifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        return withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) { ptr in
                String(cString: ptr)
            }
        }
    }
    fileprivate var modelName: String {
        let identifier = modelIdentifier

        let map: [String: String] = [
            // MARK: - iPhone
            "iPhone6,1": "iPhone 5s",
            "iPhone6,2": "iPhone 5s",
            "iPhone7,2": "iPhone 6",
            "iPhone7,1": "iPhone 6 Plus",
            "iPhone8,1": "iPhone 6s",
            "iPhone8,2": "iPhone 6s Plus",
            "iPhone8,4": "iPhone SE (1st gen)",
            "iPhone9,1": "iPhone 7",
            "iPhone9,3": "iPhone 7",
            "iPhone9,2": "iPhone 7 Plus",
            "iPhone9,4": "iPhone 7 Plus",
            "iPhone10,1": "iPhone 8",
            "iPhone10,4": "iPhone 8",
            "iPhone10,2": "iPhone 8 Plus",
            "iPhone10,5": "iPhone 8 Plus",
            "iPhone10,3": "iPhone X",
            "iPhone10,6": "iPhone X",
            "iPhone11,2": "iPhone XS",
            "iPhone11,4": "iPhone XS Max",
            "iPhone11,6": "iPhone XS Max",
            "iPhone11,8": "iPhone XR",
            "iPhone12,1": "iPhone 11",
            "iPhone12,3": "iPhone 11 Pro",
            "iPhone12,5": "iPhone 11 Pro Max",
            "iPhone12,8": "iPhone SE (2nd gen)",
            "iPhone13,1": "iPhone 12 mini",
            "iPhone13,2": "iPhone 12",
            "iPhone13,3": "iPhone 12 Pro",
            "iPhone13,4": "iPhone 12 Pro Max",
            "iPhone14,4": "iPhone 13 mini",
            "iPhone14,5": "iPhone 13",
            "iPhone14,2": "iPhone 13 Pro",
            "iPhone14,3": "iPhone 13 Pro Max",
            "iPhone14,6": "iPhone SE (3rd gen)",
            "iPhone15,4": "iPhone 14",
            "iPhone15,5": "iPhone 14 Plus",
            "iPhone15,2": "iPhone 14 Pro",
            "iPhone15,3": "iPhone 14 Pro Max",
            "iPhone16,4": "iPhone 15",
            "iPhone16,5": "iPhone 15 Plus",
            "iPhone16,1": "iPhone 15 Pro",
            "iPhone16,2": "iPhone 15 Pro Max",

            // MARK: - iPad
            "iPad6,11": "iPad (5th gen)",
            "iPad6,12": "iPad (5th gen)",
            "iPad7,5": "iPad (6th gen)",
            "iPad7,6": "iPad (6th gen)",
            "iPad7,11": "iPad (7th gen)",
            "iPad7,12": "iPad (7th gen)",
            "iPad11,6": "iPad (8th gen)",
            "iPad11,7": "iPad (8th gen)",
            "iPad12,1": "iPad (9th gen)",
            "iPad12,2": "iPad (9th gen)",
            "iPad13,18": "iPad (10th gen)",
            "iPad13,19": "iPad (10th gen)",

            // MARK: - iPad Pro (some)
            "iPad8,1": "iPad Pro 11-inch (1st gen)",
            "iPad8,9": "iPad Pro 11-inch (2nd gen)",
            "iPad8,11": "iPad Pro 12.9-inch (4th gen)",
            "iPad13,4": "iPad Pro 11-inch (3rd gen)",
            "iPad13,8": "iPad Pro 12.9-inch (5th gen)",

            // MARK: - iPod
            "iPod9,1": "iPod touch (7th gen)",

            // MARK: - Simulator
            "i386": "Simulator",
            "x86_64": "Simulator",
            "arm64": "Simulator",
        ]

        return map[identifier] ?? identifier
    }
}
