  
  import UIKit
  
  protocol Person: AnyObject {
    var firstName: String { get }
    var lastName: String { get }
    
    var fullNAme: String { get }
    var age: Int { get set }
    var passport: Passport? { get set }
  }
  
  protocol Passport {
    // серия может содержать буквы и форматирование
    var series: String { get }
    var number: Int { get }
    
    var dateOfIssue: Date { get }
    // паспорт не может сущестоввать самостоятельно
    var person: Person { get }
    
    init(series: String, number: Int, person: Person)
  }
  
  class RussianPerson: Person {
    var age: Int
    
    let firstName: String
    
    let lastName: String
    
    var fullNAme: String {
        return "\(firstName) \(lastName)"
    }
    
    var passport: Passport?
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    deinit { print("\(fullNAme) деинициализируется") }
  }
  
  class RussianPassport: Passport {
    
    var series: String
    
    var number: Int
    
    //текущая дата для примера
    var dateOfIssue: Date {
        return Date()
    }
    
    unowned var person: Person
    
    required init(series: String, number: Int, person: Person) {
        self.series = series
        self.number = number
        self.person = person
    }
    deinit { print("Паспорт \(number) деинициализируется") }
  }
  
  var guy: Person?
  guy = RussianPerson(firstName: "Egor", lastName: "Ivanov", age: 31)
  // явное извлечение только в рамках песочницы
  guy!.passport = RussianPassport(series: "74 67", number: 289284, person: guy!)
  guy = nil
