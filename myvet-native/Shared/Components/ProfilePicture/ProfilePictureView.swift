//
//  ProfilePictureView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 27/06/25.
//

import SwiftUI

struct ProfilePictureView: View {
    let url: URL?
    let defaultUrl: URL?
    let name: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            ZStack {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        AsyncImage(url: url) { phase in
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
                .frame(maxWidth: .infinity, minHeight: 300)
                .clipShape(Rectangle())
                .blur(radius: 100)
                
                
                
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        AsyncImage(url: url) { phase in
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
                .frame(maxWidth: .infinity, minHeight: 300)
                .clipShape(Rectangle())
                
                VStack {
                    Spacer()
                    ZStack(alignment: .bottomLeading) {
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color.black.opacity(0.7), location: 0),
                                .init(color: Color.black.opacity(0.0), location: 1)
                            ]),
                            startPoint: .bottom, endPoint: .top)
                            .frame(height: 120)
                        Text(name)
                            .font(.title)
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .padding(.vertical, 10)
                            .shadow(radius: 4)
                            .padding([.leading, .bottom], 14)
                    }
                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
                }
                .frame(alignment: .bottom)
                .allowsHitTesting(false)
            }
            .frame(maxWidth: 700, maxHeight: 400)
            
            Spacer()
        }
        .backgroundExtensionEffect()
    }
}

#Preview {
    ProfilePictureView(url: nil, defaultUrl: nil, name: "Sample Name")
}
