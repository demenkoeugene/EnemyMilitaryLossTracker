//
//  LossesControllerTests.swift
//  MacPawBootCampDemenkoTests
//
//  Created by Eugene Demenko on 27.08.2023.
//

import XCTest
@testable import MacPawBootCampDemenko

class LossesControllerTests: XCTestCase {

    func testClickAllDatesInDatePicker() {
        // Create a date formatter to convert dates to strings
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        // Create an instance of LossesController
        let lossesController = LossesController()

        // Create a UIDatePicker object (if needed)
        let datePicker = UIDatePicker()

        // Define a date range for testing
        let startDate = dateFormatter.date(from: "2022-02-24")!
        let endDate = dateFormatter.date(from: "2023-12-31")!
        let dateRange = DateInterval(start: startDate, end: endDate)

        // Iterate over all the dates in the date range and simulate selecting them
        var currentDate = dateRange.start
        while currentDate <= dateRange.end {
            datePicker.date = currentDate
            lossesController.datePickerValueChanged(datePicker)

            
            // Move to the next date
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        }
    }
}
