//
//  ProfileTabView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 27/06/25.
//

import SwiftUI

struct ProfileTabView: View {
    var name: String = ""
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(.accentColor)
            VStack(alignment: .leading, spacing: 2) {
                Text("Ciao Ciaone")
                    .font(.headline)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Text("utente@email.com")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
        }
    }
}

#Preview {
    ProfileTabView()
}
