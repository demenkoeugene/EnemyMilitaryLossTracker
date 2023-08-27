//
//  APIManagerTests.swift
//  MacPawBootCampDemenkoTests
//
//  Created by Eugene Demenko on 26.08.2023.
//

import XCTest
import CoreData
@testable import MacPawBootCampDemenko

class APIManagerTests: XCTestCase {

    func testGetPersonnelLosses() {
        let apiManager = APIManager.shared
        let expectation = expectation(description: "Personnel Losses Fetch")
        
        apiManager.getPersonnelLosses(viewContext: PersistenceController.shared.container.viewContext) { error in
            XCTAssertNil(error, "Error fetching personnel losses: \(error?.localizedDescription ?? "Unknown error")")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetEquipmentLosses() {
        let apiManager = APIManager.shared
        let expectation = expectation(description: "Equipment Losses Fetch")
        
        apiManager.getEquipmentLosses(viewContext: PersistenceController.shared.container.viewContext) { error in
            XCTAssertNil(error, "Error fetching equipment losses: \(error?.localizedDescription ?? "Unknown error")")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetEquipmentLossesOryx() {
        let apiManager = APIManager.shared
        let expectation = expectation(description: "Equipment Losses Oryx Fetch")
        
        apiManager.getEquipmentLossesOryx(viewContext: PersistenceController.shared.container.viewContext) { error in
            XCTAssertNil(error, "Error fetching equipment losses oryx: \(error?.localizedDescription ?? "Unknown error")")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testParseDonationJSON() {
        let apiManager = APIManager.shared
        let expectation = expectation(description: "Donation JSON Parsing")
        
        apiManager.parseDonationJSON { result in
            switch result {
            case .success(let donations):
                XCTAssertGreaterThan(donations.count, 0, "No donation data parsed.")
            case .failure(let error):
                XCTFail("Error parsing donation JSON: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
