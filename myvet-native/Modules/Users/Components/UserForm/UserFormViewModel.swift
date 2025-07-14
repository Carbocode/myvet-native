import Foundation
#if os(macOS)
import AppKit
#endif

class UserFormViewModel: ObservableObject {
    
    @Published var selectedImage: PlatformImage? = nil
    @Published var nome: String = ""
    @Published var cognome: String = ""
    @Published var email: String = ""
    @Published var telefono: String = ""
    @Published var password: String = ""
    @Published var codiceFiscale: String = ""
    @Published var newsletter: Bool = false
    @Published var tos: Bool = false
    @Published var condizioniGenerali: Bool = false
    @Published var codiceUtenteApple: String? = nil
    
    func createUser(completion: @escaping (Result<UserCreateResponse, Error>) -> Void) {
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
            Estensione: nil
        )
        UsersActions.create(userCreateRequest, image: selectedImage) { result in
            switch result {
            case .success(let response):
                AuthManager.shared.saveToken(response.jwt)
            case .failure(let error):
                print("Errore nella creazione dell'utente: \(error.localizedDescription)")
            }
        }
    }
}

