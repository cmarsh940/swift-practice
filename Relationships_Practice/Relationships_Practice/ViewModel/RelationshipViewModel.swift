//
//  RelationshipViewModel.swift
//  Relationships_Practice
//
//  Created by Cam on 8/19/21.
//

import Foundation
import CoreData

class RelationshipViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init() {
        getBusinesses()
        getDepartments()
        getEmployees()
    }
    
    func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")

//        Add Sorting the request in alphabetical order
        let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)
        request.sortDescriptors = [sort]
        
//        Add filter data
//        let filter = NSPredicate(format: "name == %@", "Apple")
//        request.predicate = filter
        
        do {
         businesses = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching businesses: \(error)")
        }
    }
    
    func getDepartments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        do {
         departments = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching businesses: \(error)")
        }
    }
    
    func getEmployees() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        do {
         employees = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching businesses: \(error)")
        }
    }
    
    func getEmployeesForBusiness(forBusiness business: BusinessEntity) {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
//        Only able to filter on relationship when entity relationship is to One not to Many
        let filter = NSPredicate(format: "business == %@", business)
        request.predicate = filter
        do {
         employees = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching businesses: \(error)")
        }
    }
    
    func updateBusiness() {
        let existingBusiness = businesses[2]
        
        existingBusiness.addToDepartments(departments[1])
        save()
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Facebook"

        //        Add existing departments to the new business
//                newBusiness.departments = [departments[0], departments[1]]
        
        //        Add existing employees to the new business
//                newBusiness.employees = [employees[1]]
        
        //        Add newbusiness to existing business
        //        newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        
        //        Add newbusiness to existing employee
        //        newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
        

        save()
    }
    
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        
        newDepartment.name = "Finance"
        newDepartment.businesses = [businesses[0], businesses[1], businesses[2]]
        
//        newDepartment.employees = [employees[1]]
        newDepartment.addToEmployees(employees[1])
        save()
    }
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.age = 28
        newEmployee.dateJoined = Date()
        newEmployee.name = "Jordan"
        
        newEmployee.business = businesses[2]
        newEmployee.department = departments[1]
        save()
    }
    
    func deleteDepartment() {
        let department = departments[2]
        manager.context.delete(department)
        save()
    }
    
    func save() {
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.manager.save()
            self.getBusinesses()
            self.getDepartments()
            self.getEmployees()
        }
    }
}
