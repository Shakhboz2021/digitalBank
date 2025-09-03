//
//  XCTTestCase+MemoryLeaks.swift
//  DigitalBankTests
//
//  Created by Muhammad on 03/09/25.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(
        _ instance: AnyObject,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "Potential memory leak: \(String(describing: instance)) should have been deallocated. Check retain cycles.",
                file: file,
                line: line
            )
        }
    }
}
