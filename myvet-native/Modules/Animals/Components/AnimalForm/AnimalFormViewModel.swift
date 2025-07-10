import Foundation
#if os(macOS)
import AppKit
#endif

class AnimalFormViewModel: ObservableObject {
    
    @Published var selectedImage: PlatformImage? = nil
    @Published var nome: String = ""
    @Published var microchip: String = ""
    @Published var passaporto: String = ""
    @Published var dataNascita: Date = Date()
    @Published var luogoNascita: String = ""
    @Published var sesso: String = "M"
    @Published var idTaglia: Int? = nil
    @Published var idAttivita: Int? = nil
    @Published var idCorporatura: Int? = nil
    @Published var peso: Double? = nil
    @Published var sterilizzato: Bool = false
    @Published var assicurato: Bool = false
    @Published var idSpecie: Int = 2{
        didSet {
            getRaces()
        }
    }
    @Published var idRazza: Int? = nil
    @Published var mantello: String = ""
    @Published var descrizione: String = ""
    
    @Published var species: [Species] = []
    @Published var bcs: [Bcs] = []
    @Published var activityLevels: [ActivityLevel] = []
    @Published var sizes: [Size] = []
    @Published var races: [Race] = []
    
    init(){
        getSpecies()
        getRaces()
        getSizes()
        getBcs()
        getActivityLevels()
    }
    
    func createAnimal(completion: @escaping (Result<AnimalCreateResponse, Error>) -> Void) {
        let animalRequest = AnimalCreateRequest(
            Nome: nome,
            Microchip: microchip,
            Passaporto: passaporto,
            DataNascita: ISO8601DateFormatter().string(from: dataNascita),
            LuogoNascita: luogoNascita,
            Sesso: sesso,
            IDTaglia: idTaglia,
            IDAttivita: idAttivita,
            IDCorporatura: idCorporatura,
            Peso: peso,
            Sterilizzato: sterilizzato,
            Assicurato: assicurato,
            IDRazza: idRazza ?? 1,
            Mantello: mantello,
            Descrizione: descrizione,
        )
        AnimalsActions.create(animalRequest, image: selectedImage) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func getSpecies() {
        SpeciesActions.read { result in
            switch result {
            case .success(let data): self.species = data
            case .failure: self.species = []
            }
        }
    }
    
    func getBcs() {
        BcsActions.read { result in
            switch result {
            case .success(let data): self.bcs = data
            case .failure: self.bcs = []
            }
        }
    }
    
    func getSizes() {
        SizesActions.read { result in
            switch result {
            case .success(let data): self.sizes = data
            case .failure: self.sizes = []
            }
        }
    }
    
    func getActivityLevels() {
        ActivityLevelsActions.read { result in
            switch result {
            case .success(let data): self.activityLevels = data
            case .failure: self.activityLevels = []
            }
        }
    }
    
    func getRaces() {
        RacesActions.read(idSpecie: idSpecie) { result in
            switch result {
            case .success(let data): self.races = data
            case .failure: self.races = []
            }
        }
    }
}

