import UIKit

protocol PersonProtocol {
    // get e set definem se a propriedade é somente leitura ou leitura e escrita
    var id: Int { get }
    var name: String { get set }
    
    func displayInfo() -> String
}

// Extensão para fornecer uma implementação padrão do método displayInfo
extension PersonProtocol {
    func displayInfo() -> String {
        return "ID: \(id), Name: \(name)"
    }
}
    
class Person: PersonProtocol {
    // para evitar que a propriedade id seja modificada fora da classe, usamos private(set)
    private(set) var id: Int
    var name: String
    
    init(name: String) {
        self.name = name
        self.id = 0
    }

}

let person = Person(name: "Marcos")

// person.id = 2
print(person.displayInfo()) // Person ID: 2, Name: Manoel


// Extensão para adicionar funcionalidade à classe String
extension String {
    
    // Propriedade computada para verificar se a string contém "manoel"
    var isManoel: Bool {
        return self.lowercased().contains("manoel")
    }
}

let manoel = "Manoel"

print(manoel.isManoel) // verdadeiro
