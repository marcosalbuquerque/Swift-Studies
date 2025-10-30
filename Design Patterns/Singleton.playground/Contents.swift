// MARK: - Singleton Pattern

// MainActor garante que todas as operações sejam executadas na thread principal.
@MainActor
// final é para impedir herança, garantindo que haja apenas uma instância.
final class AudioManager {
    // nonisolated(unsafe) é usado para evitar problemas de concorrência em singletons, mas deve ser usado com cuidado.
    static let shared = AudioManager()
    
    func playSound(named name: String) {
        print("Playing sound: \(name)")
    }
    
    private init() {}
}

// Uso do Singleton
AudioManager.shared.playSound(named: "background-music.mp3")
