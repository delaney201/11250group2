//
//  Root4FloridaTests.swift
//  Root4FloridaTests
//
//  Created by Catherine  Healy on 10/26/21.
//

import XCTest
@testable import Root4Florida

class Root4FloridaTests: XCTestCase {
    
    var coralGablesZipCode:Zone!
    var freeholdZipCode:Zone!
    
    

    override func setUpWithError() throws {
        super.setUp()
        coralGablesZipCode = Zone(zone: "33134")
        freeholdZipCode = Zone(zone: "12431")
    }

    override func tearDownWithError() throws {
        super.tearDown()
        coralGablesZipCode = nil
        freeholdZipCode = nil

    }

    func testExample() throws {
    
    }

    func testPerformanceExample() throws {
        let zone = Zone(zone: "32608")
        self.measure {
            zone.numberOnly()
        }
    }
    
    
    func testZone() throws{

        let z = Zone(zone: "3313a")
        let zipCode = z.numberOnly().zone
        let none = "None"
        XCTAssertEqual(none,zipCode)

    }


}
