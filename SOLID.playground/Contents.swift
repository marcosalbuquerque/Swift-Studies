import UIKit

// MARK: SOLID

// S - Single Responsibility Principle

// Problemática:
// Esta classe tem muitas responsabilidades, violando o princípio da responsabilidade única.
// Cada método deveria estar em uma classe separada, cada uma com uma única responsabilidade.

class GerenciadorDeFuncionarios {
    func conectarAPI() {}
    func criarTarefa() {}
    func produzirRelatorio() {}
    func enviarNotificacao() {}
    func removerTarefas() {}
    
}

// Solução:
// Dividir as responsabilidades em várias classes
// para seguir o princípio da responsabilidade única.

class GerenciadorTarefas {
    func criarTarefa() {}
    func removerTarefas() {}
}

class GerenciadorRelatorios {
    func produzirRelatorio() {}
}

class GerenciadorNotificacoes {
    func enviarNotificacao() {}
}

// O - Open/Closed Principle
// Classes devem estar abertas para extensão, mas fechadas para modificação.
// Isso significa que devemos ser capazes de adicionar novas funcionalidades sem alterar o código existente.

// Problemática:
// Esta classe viola o princípio aberto/fechado,
// pois cada vez que um novo tipo de funcionário é adicionado, ela precisa ser modificada.
// Isso pode levar a erros e tornar o código difícil de manter.

class FolhaDePagamento01 {
    private var saldo: Double? = nil
    
    func renumeracao<T>(_ funcionario: T) {
        if funcionario is CLT {
            saldo = CLT().remuneracao()
        } else if funcionario is Estagiario {
            saldo = Estagiario().remuneracao()
        }
    }
}

// Solução:
// Usar polimorfismo para permitir a extensão sem modificar o código existente.
// Definir um protocolo que todos os tipos de funcionários devem implementar.
// Assim, novos tipos de funcionários podem ser adicionados sem alterar a classe FolhaDePagamento.

protocol Remuneravel {
    func remuneracao() -> Double
}

class CLT: Remuneravel {
    func remuneracao() -> Double {
        return 3000.0
    }
}

class Estagiario: Remuneravel {
    func remuneracao() -> Double {
        return 1500.0
    }
}

class PJ: Remuneravel {
    func remuneracao() -> Double {
        return 4000.0
    }
}

class FolhaDePagamento02 {
    private var saldo: Double? = nil
    
    public func calcular(funcionario: Remuneravel) {
        saldo = funcionario.remuneracao()
    }
    
}

// L - Liskov Substitution Principle
// Subtipos devem ser substituíveis por seus tipos base.
// Isso significa que objetos de uma classe derivada devem poder substituir objetos da classe base sem alterar a funcionalidade do programa.

// Problemática:
// A classe Quadrado viola o princípio de substituição de Liskov,
// pois altera o comportamento esperado da classe Retangulo.
// Isso pode levar a resultados inesperados ao usar um Quadrado onde um Retangulo é esperado.


class Retangulo {
    var largura: Double
    var altura: Double
    init(largura: Double, altura: Double) {
        self.largura = largura
        self.altura = altura
    }
    func area() -> Double {
        return largura * altura
    }
}

class Quadrado: Retangulo {
    override var largura: Double {
        didSet {
            altura = largura
        }
    }
    override var altura: Double {
        didSet {
            largura = altura
        }
    }
    init(lado: Double) {
        super.init(largura: lado, altura: lado)
    }
}

// Solução:
// Evitar herança inadequada e usar composição ou interfaces para garantir que o comportamento esperado seja mantido.

class Forma {
    func area() -> Double {
        return 0.0
    }
}

class RetanguloCorreto: Forma {
    var largura: Double
    var altura: Double
    
    init(largura: Double, altura: Double) {
        self.largura = largura
        self.altura = altura
    }
    
    override func area() -> Double {
        return largura * altura
    }
}

class QuadradoCorreto: Forma {
    var lado: Double
    
    init(lado: Double) {
        self.lado = lado
    }
    
    override func area() -> Double {
        return lado * lado
    }
}


// I - Interface Segregation Principle
// Muitas interfaces específicas são melhores do que uma interface única e geral.

// Problemática:
// A interface Funcionario força todas as classes que a implementam
// a definir métodos que podem não ser relevantes para elas.

protocol Funcionario {
    func trabalhar()
    func tirarFerias()
    func fazerRelatorio()
}

class Limpador: Funcionario {
    func trabalhar() {}
    func tirarFerias() {}
    func fazerRelatorio() {
        // Limpeza não precisa fazer relatórios
    }
}

// Solução:
// Dividir a interface em várias interfaces específicas,
// permitindo que as classes implementem apenas os métodos relevantes.

protocol Trabalhador {
    func trabalhar()
    func tirarFerias()
}

class LimpadorCorreto: Trabalhador {
    func trabalhar() {}
    func tirarFerias() {}
}

class Gerente: Trabalhador {
    func trabalhar() {}
    func tirarFerias() {}
    func fazerRelatorio() {}
}

// D - Dependency Inversion Principle
// Módulos de alto nível não devem depender de módulos de baixo nível.
// Ambos devem depender de abstrações.
// Abstrações não devem depender de detalhes. Detalhes devem depender de abstrações.

// Problemática:
// A classe GerenciadorDePedidos depende diretamente da classe MySQLDatabase,
// o que torna difícil trocar o banco de dados sem modificar o código do gerenciador de pedidos.

class MySQLDatabase {
    func conectar() {
        // MySQL conexão
    }
}

class GerenciadorDePedidos {
    private let database = MySQLDatabase()
    
    init() {
        database.conectar()
    }
}

// Solução:
// Introduzir uma abstração (protocolo) para o banco de dados,
// permitindo que o gerenciador de pedidos dependa dessa abstração em vez de uma implementação concreta.

protocol Database {
    func conectar()
}

class MySQLDatabaseCorreto: Database {
    func conectar() {
        // MySQL conexão
    }
}

class PostgreSQLDatabase: Database {
    func conectar() {
        // PostgreSQL conexão
    }
}

class GerenciadorDePedidosCorreto {
    private let database: Database
    
    init(database: Database) {
        self.database = database
        self.database.conectar()
    }

}

// Exemplo de uso

let mysqlDB = MySQLDatabaseCorreto()
let postgresDB = PostgreSQLDatabase()

let gerenciadorPedidos = GerenciadorDePedidosCorreto(database: mysqlDB)
let gerenciadorPedidosPostgres = GerenciadorDePedidosCorreto(database: postgresDB)





