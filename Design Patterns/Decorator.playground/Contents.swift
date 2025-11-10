protocol Cafe: AnyObject {
    func custo() -> Double
    func descricao() -> String
}

class CafeSimples: Cafe {
    func custo() -> Double {
        return 10
    }
    
    func descricao() -> String {
        return "Café Simples top"
    }
    
}


// Decorator serve para adicionar funcionalidades a um objeto de forma dinâmica, sem alterar sua estrutura original.
class CafeDecorator: Cafe {
    private let cafeBase: Cafe
    
    init(cafe: Cafe) {
        self.cafeBase = cafe
    }
    
    func custo() -> Double {
        cafeBase.custo()
    }
    
    func descricao() -> String {
        cafeBase.descricao()
    }
    
}

class CafeComLeite: CafeDecorator {
    override func custo() -> Double {
        return super.custo() + 5
    }
    
    override func descricao() -> String {
        return super.descricao() + ", com leite"
    }

}

class CafeGelado: CafeDecorator {
    override func custo() -> Double {
        return super.custo() + 5
    }
    
    override func descricao() -> String {
        return super.descricao() + ", gelado"
    }
}

let cafeSimples = CafeSimples()
print("Descrição: \(cafeSimples.descricao()) - Custo: \(cafeSimples.custo())")

let cafeComLeite = CafeComLeite(cafe: cafeSimples)
print("Descrição: \(cafeComLeite.descricao()) - Custo: \(cafeComLeite.custo())")

let cafeGelado = CafeGelado(cafe: cafeSimples)
print("Descrição: \(cafeGelado.descricao()) - Custo: \(cafeGelado.custo())")
