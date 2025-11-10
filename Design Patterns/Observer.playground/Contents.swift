import UIKit

// Observer Pattern Protocols

// Observer é um protocolo que define o método update que os observadores devem implementar
protocol Observer: AnyObject {
    func update(subject: Subject)
}

// Subject é um protocolo que define os métodos para adicionar, remover e notificar observadores
protocol Subject {
    func addObserver(_ observer: Observer)
    func removeObserver(_ observer: Observer)
    func notifyObservers()
    
}

// Concrete Subject
// Serve como o objeto que mantém o estado e notifica os observadores sobre mudanças
class WeatherStation: Subject {
    private var observers = [Observer]()
    private var temperatura: Double = 0.0
    
    func setTemperatura(_ temperatura: Double) {
        self.temperatura = temperatura
        notifyObservers()
    }
    
    func getTemperatura() -> Double {
        return temperatura
    }
    
    func addObserver(_ observer: any Observer) {
        observers.append(observer)
    }
    
    func removeObserver(_ observer: any Observer) {
        if let index = observers.firstIndex(where: { $0 === observer }) {
            observers.remove(at: index)
        }
    }
    
    func notifyObservers() {
        for observer in observers {
            observer.update(subject: self)
        }
    }

}

class TemperatureDisplay: Observer {
    func update(subject: Subject) {
        if let weatherStation = subject as? WeatherStation {
            print("Temperatura atualizada: \(weatherStation.getTemperatura())°C")
        }
    }
}

let weatherStation = WeatherStation()
let display1 = TemperatureDisplay()
let display2 = TemperatureDisplay()
weatherStation.addObserver(display1)
weatherStation.addObserver(display2)
weatherStation.setTemperatura(25.0)
weatherStation.setTemperatura(30.0)
