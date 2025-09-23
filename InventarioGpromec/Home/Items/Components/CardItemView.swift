//
//  CardItemView.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 22/09/25.
//

import SwiftUI

struct CardItemView: View {
    @EnvironmentObject var itemvm: ItemsViewModel
    var item : ItemsModelResponse
    var onImprimirqr: (Int) -> Void
    
    private var estadoColor: Color {
        switch item.estado.lowercased() {
        case "activo":     return .green
        case "inactivo":   return .red
        case "reparacion": return .yellow
        default:           return .gray
        }
    }
    
    var body: some View {
        
        VStack{
            ZStack(alignment: .top) {
                AsyncImage(url: URL(string: item.foto_url)) {
                    image in image.resizable().scaledToFit().padding(.horizontal, 4).padding(.vertical, 10)
                }placeholder: {
                    ProgressView()
                }
                .frame( width: 160)
                .clipped()
                .cornerRadius(40)
                
                HStack {
                    Button(action: {
                        //detalle a Imprimir
                        print("id \(item.id)")
                        onImprimirqr( item.id)
                    }) {
                        Image(systemName: "qrcode")
                        
                    }.font(.system(size: 30)).background(Color.white).zIndex(1).padding(.horizontal, 4).padding(.vertical, 15).cornerRadius(40)
                    Spacer()
                    Text(item.estado).frame( height: 10, alignment: .center).foregroundColor(.white).padding().background(Capsule().fill(estadoColor))
                }.padding(.horizontal, 8).zIndex(1).padding(.top, 8)
                
                
            }
            Spacer().frame(height: 10)
            Text(item.nombre).frame(maxWidth: .infinity, alignment: .center)
            Text("Ubicacion").foregroundColor(.gray)
            Text(item.ubicacion_actual.nombre).frame(maxWidth: .infinity, alignment: .center)
            Spacer().frame(height: 15)
        }.frame(width: 160, height: 300, alignment: .top).background(.ultraThinMaterial).cornerRadius(30).shadow(radius: 5)
    }
}

#Preview {
    let vm = ItemsViewModel()
    // si necesitas simular lista, vm.itemscards = [ .mock, ... ]

    CardItemView(
        item: ItemsModelResponse(
                    id: 1,
                    nombre: "Taladro",
                    descripcion: "abc",
                    foto_url: "https://picsum.photos/seed/1/400",
                    estado: "reparacion",
                    ubicacion_actual: ItemsModelResponse.Ubicacion(nombre: "Rack A-3")
        ),
        onImprimirqr: { _ in }
    )
    .environmentObject(vm)  // si CardItemView usa @EnvironmentObject
}
