//  CardTrabajadores.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 24/09/25.
//

import SwiftUI

struct CardTrabajadores: View {
    var itemtrab: [TallerObrasCardResponse.asignacion_trabajadores]

    var body: some View {
        let shown = min(itemtrab.count,3)
        let extra = max(0, itemtrab.count - shown)

        HStack(spacing: -15) {
            ForEach(0..<shown, id: \.self) { i in
                let url = itemtrab[i].trabajadores.foto_url
                AsyncImage(url: URL(string: url)) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Color.secondary.opacity(0.15)
                }
                .frame(width: 44, height: 44)
                .clipShape(Circle())
                .overlay(Circle().stroke(.white, lineWidth: 2))
                .shadow(radius: 1)
                .zIndex(Double(100 - i))
            }

            if extra > 0 {
                burbujaconteo(count: extra).padding(.leading, 6)
                    .zIndex(200)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading) // 👈 ocupa todo el ancho del card
        .frame(height: 60) // 👈 altura fija limpia
        .padding(.horizontal, 4) // opcional: para respirar dentro del card
    }
}

struct burbujaconteo: View {
    let count: Int
    var body: some View {
        Text("+\(count)")
            .font(.subheadline.weight(.semibold))
            .padding(.horizontal, 8).frame(height: 28)
            .background(.ultraThinMaterial)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(.white, lineWidth: 2))
            .shadow(radius: 1)
    }
}

#Preview {
    VStack(spacing: 20) {
        CardTrabajadores(itemtrab: [
            .init(id: 1, trabajadores: .init(id: 11, foto_url: "https://picsum.photos/id/1005/200/200")),
            .init(id: 2, trabajadores: .init(id: 12, foto_url: "https://picsum.photos/id/1011/200/200"))
        ])

        CardTrabajadores(itemtrab: [
            .init(id: 1, trabajadores: .init(id: 11, foto_url: "https://picsum.photos/id/1005/200/200")),
            .init(id: 2, trabajadores: .init(id: 12, foto_url: "https://picsum.photos/id/1011/200/200")),
            .init(id: 3, trabajadores: .init(id: 13, foto_url: "https://picsum.photos/id/1012/200/200")),
            .init(id: 4, trabajadores: .init(id: 14, foto_url: "https://picsum.photos/id/1015/200/200"))
        ])
    }
}
