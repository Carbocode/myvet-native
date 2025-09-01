import Foundation
#if os(macOS)
import AppKit
#endif

enum SaveResult: Equatable {
    case success
    case failure(message: String)    // errori rete/server generici
}

@Observable @MainActor
class AnimalFormViewModel {
    
    var selectedImage: PlatformImage? = nil
    var nome: String = ""
    var microchip: String = ""
    var passaporto: String = ""
    var dataNascita: Date = Date()
    var luogoNascita: String = ""
    var sesso: String = "M"
    var idTaglia: Int? = nil
    var idAttivita: Int? = nil
    var idCorporatura: Int? = nil
    var peso: Double? = nil
    var sterilizzato: Bool = false
    var assicurato: Bool = false
    var idSpecie: Int = 2{
        didSet {
            Task{
                await getRaces()
            }
            
        }
    }
    var idRazza: Int? = nil
    var mantello: String = ""
    var descrizione: String = ""
    
    var species: [Species] = []
    var bcs: [Bcs] = []
    var activityLevels: [ActivityLevel] = []
    var sizes: [Size] = []
    var races: [Race] = []
    
    init(){
        Task{
            await getSpecies()
            await getRaces()
            await getSizes()
            await getBcs()
            await getActivityLevels()
        }
    }
    
    func createAnimal() async -> SaveResult {
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
        
        do{
            let _ = try await AnimalsActions.create(animalRequest, image: selectedImage)
            return .success
        }catch{
            return .failure(message: error.localizedDescription)
        }
    }
    
    func getSpecies() async {
        do{
            species = try await SpeciesActions.read()
        }catch{
            
        }
    }
    
    func getBcs() async {
        do{
            bcs = try await BcsActions.read()
        }catch{
            
        }
    }
    
    func getSizes() async {
        do{
            sizes = try await SizesActions.read()
        }catch{
            
        }
    }
    
    func getActivityLevels() async {
        do{
            activityLevels = try await ActivityLevelsActions.read()
        }catch{
            
        }
    }
    
    func getRaces() async {
        do{
            races = try await RacesActions.read(idSpecie: idSpecie)
        }catch{
            
        }
    }
}
