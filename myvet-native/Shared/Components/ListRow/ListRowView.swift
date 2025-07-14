//
//  ListRow.swift
//  myvet-native
//
//  Created by Ligmab Allz on 10/07/25.
//

import SwiftUI

struct ListRowView: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title).fontWeight(.semibold)
            Spacer()
            Text(value).foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ListRowView(title: "ciao", value: "ciao")
}
