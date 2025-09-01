import Foundation
#if os(macOS)
import AppKit
#endif

@Observable @MainActor
class UserFormViewModel {
    
    var selectedImage: PlatformImage? = nil
    var nome: String
    var cognome: String
    var email: String
    var telefono: String = ""
    var password: String = ""
    var codiceFiscale: String = ""
    var newsletter: Bool = false
    var tos: Bool = false
    var condizioniGenerali: Bool = false
    var codiceUtenteApple: String? = nil
    
    // Costruttore custom per input esterni
    init(nome: String = "", cognome: String = "", email: String = "") {
        self.nome = nome
        self.cognome = cognome
        self.email = email
    }
    
    func createUser() {
        Task{
            let userCreateRequest = UserCreateRequest(
                Nome: nome,
                Cognome: cognome,
                Email: email,
                Password: password,
                CodiceFiscale: codiceFiscale,
                Telefono: telefono,
                Tipo: "Utente",
                Newsletter: newsletter,
                TOS: tos,
                CondizioniGenerali: condizioniGenerali,
                Immagine: nil,
                Estensione: nil,
                CodiceUtenteApple: codiceUtenteApple
            )
            do{
                let response = try await UsersActions.create(userCreateRequest, image: selectedImage)
                AuthManager.shared.saveToken(response.jwt)
            }catch{
                print("Errore nella creazione dell'utente: \(error.localizedDescription)")
            }
        }
    }
}
