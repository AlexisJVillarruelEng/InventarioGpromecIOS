//
//  TalleresCard.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 24/09/25.
//

import SwiftUI

struct TalleresObrasCard: View {
    var item: TallerObrasCardResponse
    
    var body: some View {
        VStack{
            Text("\(item.nombre) tipo: \(item.tipo)")
            ScrollView{
                ForEach(item.items){ itemcard in //scroll de cards items vertical
                    CardItemsEyS(itemscards: itemcard)
                }
            }.frame(height: 280)
            CardTrabajadores(itemtrab: item.asignacion_trabajadores)
            
        }.frame(width: 150) // 👈 aquí tu card controla el ancho
            .padding()
            .background(.secondary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    TalleresObrasCard(
        item: .init(
            id: 1,
            nombre: "Taller Central",
            tipo: "taller",
            estado: true,
            items: [
                .init(id: 101, nombre: "Taladro XR-200",  foto_url: "https://picsum.photos/seed/taladro/200", estado: "activo"),
                .init(id: 102, nombre: "Martillo Pro",    foto_url: "https://picsum.photos/seed/martillo/200", estado: "activo"),
                .init(id: 103, nombre: "Sierra Circular", foto_url: "https://picsum.photos/seed/sierra/200", estado: "activo"),
            ],
            asignacion_trabajadores: [
                .init(id: 1, trabajadores: .init(id: 11, foto_url: "https://picsum.photos/seed/user1/200",nombre: "Juan", apellido: "Perez"))
            ]
        )
    )
}
