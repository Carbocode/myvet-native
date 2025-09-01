import SwiftUI

struct SearchResultView: View {
    @State var viewModel: SearchResultViewModel
    
    init(vet: Vet) {
        self.viewModel = .init(vet: vet)
    }
    
    var body: some View {
        HStack {
            let fullURL = Config.vetURL.appendingPathComponent("/" + viewModel.vet.immagine)
            let defaultURL = Config.vetURL.appendingPathComponent("/default.png")
            AsyncImage(url: fullURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    AsyncImage(url: defaultURL) {phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                            case .failure:
                                ProgressView()
                            @unknown default:
                                ProgressView()
                            }
                    }
                @unknown default:
                    ProgressView()
                }
            }
            .frame(width: 35, height: 35)
            .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(viewModel.vet.nome)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                HStack{
                    Text(String(format: "%.2f km", Double(0)) + " " + (viewModel.vet.indirizzo ?? ""))
                        .font(.caption)
                    
                }
            }
            Spacer()
        }
    }
}

#Preview {
    SearchResultView(vet: Vet.example)
}
