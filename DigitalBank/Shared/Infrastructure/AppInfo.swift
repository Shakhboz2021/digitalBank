//
//  AppInfo.swift
//  DigitalBank
//
//  Created by Muhammad on 27/08/25.
//

import Foundation

enum AppInfo {
    static var releaseVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            ?? "0.0"
    }

    static var buildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "0"
    }

    static var bundleIdentifier: String {
        Bundle.main.bundleIdentifier ?? "unknown.bundle"
    }

    static var displayName: String {
        Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? Bundle
            .main.infoDictionary?["CFBundleName"] as? String ?? "Unknown App"
    }
}
