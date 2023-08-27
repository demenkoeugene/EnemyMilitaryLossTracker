//
//  EquipmentControllerTests.swift
//  MacPawBootCampDemenkoTests
//
//  Created by Eugene Demenko on 27.08.2023.
//

import XCTest
@testable import MacPawBootCampDemenko 

class EquipmentControllerTests: XCTestCase {

    var equipmentController: EquipmentController!

    override func setUpWithError() throws {
        try super.setUpWithError()

        equipmentController = EquipmentController()
        // Load the view explicitly to trigger viewDidLoad and setup UI components
        equipmentController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        equipmentController = nil
        try super.tearDownWithError()
    }

    func testTableViewDataSource() {
        let tableView = equipmentController.tableView

        // Test that the data source is set correctly
        XCTAssertTrue(tableView.dataSource === equipmentController)
    }

    func testTableViewDelegate() {
        let tableView = equipmentController.tableView

        // Test that the delegate is set correctly
        XCTAssertTrue(tableView.delegate === equipmentController)
    }

    func testTableViewNumberOfRowsInSection() {
        let numberOfRows = equipmentController.tableView(equipmentController.tableView, numberOfRowsInSection: 0)

        // Test the number of rows based on test data
        XCTAssertEqual(numberOfRows, equipmentController.categoriesEquipment.allArrays.count)
    }

  

}
