//
//  listTrabajadores.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 11/10/25.
//

import SwiftUI

struct listTrabajadores: View {
    let trabajadores: ListaTrabajadoresModel
    
    var body: some View {
        
        HStack{
            AsyncImage(url: URL(string: trabajadores.foto_url ?? "")) { image in image.resizable().scaledToFill().frame(width: 60, height: 60)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }.frame(width: 100, height: 100).padding(.leading, 10)
            
            Spacer().frame(width: 40)
            
            VStack {
                Text(trabajadores.nombre ).frame(maxWidth: .infinity, alignment: .leading)
                Text(trabajadores.apellido).frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
            
            Text("\(trabajadores.id)").padding(.trailing, 10).font(.title2).bold(true)
            Spacer()
            
        }.frame(maxWidth: .infinity).padding(.horizontal, 10)
        
    }
}

#Preview {
    listTrabajadores(trabajadores: ListaTrabajadoresModel(
        id: 1,
        nombre: "Ana",
        apellido: "Quispe",
        foto_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQs7BqBnclkqNNhHlvsA1x6ZezIn45z5O38og&s"
    ))
}
