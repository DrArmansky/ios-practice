
import UIKit

enum GetPeronError: Error {
    case personInfo(String)
    case genderIndex(String)
}

func getPersonBy(firstLetter: Character, genderTypeIndex: Int) throws -> String {
    
    let genderTypes = ["female", "male"];
    
    guard personInfo?.isEmpty == false else { throw GetPeronError.personInfo("Person info is empty or uderfined") }
    guard genderTypes.indices.contains(genderTypeIndex) else { throw GetPeronError.personInfo("Wrong gender type index, max is \(String(describing: genderTypes.indices.last))") }
    
    let result = personInfo?.filter({ (arg0) -> Bool in
        let (name, gender) = arg0
        return name.first?.lowercased() == firstLetter.lowercased() && gender == genderTypes[genderTypeIndex]
    }) ?? []
    
    if result.isEmpty {
        return ""
    } else {
        let personsName = result.map { (arg0) -> String in
            let (name, _) = arg0
            return name
        }
        
        return personsName.joined(separator: ", ")
    }
}

let personInfo : [(name: String, gender: String)]?

personInfo = [
    (name: "Mike", gender: "male"),
    (name: "Eliza", gender: "female"),
    (name: "Ebigale", gender: "female")
]

do {
    try print(getPersonBy(firstLetter: "e", genderTypeIndex: 0))
} catch {
    print(error)
}

