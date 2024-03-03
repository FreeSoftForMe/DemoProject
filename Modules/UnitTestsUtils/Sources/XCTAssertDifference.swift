//
//  UITestsUtils
//
//  Created by Dmitrii on 02/03/2024.
//

import Difference
import Foundation
import XCTest

//TODO: add documentation
public func XCTAssertEqual<T: Equatable>(_ expected: @autoclosure () throws -> T, _ received: @autoclosure () throws -> T, file: StaticString = #file, line: UInt = #line) {
    do {
        let expected = try expected()
        let received = try received()
        XCTAssertTrue(expected == received, "Found difference for \n" + diff(expected, received).joined(separator: ", "), file: file, line: line)
    } catch {
        XCTFail("Caught error while testing: \(error)", file: file, line: line)
    }
}
