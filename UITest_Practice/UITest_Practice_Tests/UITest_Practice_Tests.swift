//
//  UITest_Practice_Tests.swift
//  UITest_Practice_Tests
//
//  Created by Cam on 8/11/21.
//

import XCTest

class when_the_user_types_and_taps_button: XCTestCase {
    
    private var app: XCUIApplication!
    
    
    override func setUp() {
        super.setUp()
        
        self.app = XCUIApplication()
        self.app.launch()
    }
    
    func test_should_add_task_to_list() {
//        Find the Text field on the contentView that has the accessibility identifier of "taskNameTextField"
        let taskNameTextField = self.app.textFields["taskNameTextField"]
//        initialize a tap gester
        taskNameTextField.tap()
//        write the task in the text field
        taskNameTextField.typeText("Do the dishes \n")
        
        
        
//        Find the button on the contentView that has the accessibility identifier of "addTaskButton"
        let addTaskButton = self.app.buttons["addTaskButton"]
//        initialize a tap gester
        addTaskButton.tap()
        
//        assign a count of tasks on the list in contentView
        let taskCount = self.app.tables.children(matching: .cell).count
        
//        Counts to make sure that only one task was added to the taskCount
        XCTAssertEqual(1, taskCount)
    }
    
}
