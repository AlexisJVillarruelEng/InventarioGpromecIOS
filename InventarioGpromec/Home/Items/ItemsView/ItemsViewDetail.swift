//
//  ItemsViewDetail.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 23/09/25.
//

import SwiftUI

struct ItemsViewDetail: View {
    @EnvironmentObject var itemsvm: ItemsViewModel
    
    var iditemseleccionado : Int
    var onImprimirqr: (Int) -> Void


    private var estadoColor: Color {
        switch itemsvm.itemIDDetails?.estado.lowercased() {
            case "activo":     return .green
            case "inactivo":   return .red
            case "reparacion": return .yellow
            default:           return .gray
            }
        }
    
    var body: some View {
        VStack(spacing: 30){
            ZStack(alignment: .top) {
                AsyncImage(url: URL(string: itemsvm.itemIDDetails?.foto_url ?? "")) {
                    image in image.resizable().scaledToFit().cornerRadius(20).padding(.horizontal, 4).padding(.vertical, 10)
                }placeholder: {
                    ProgressView()
                }
                .frame( height: 300)
                .clipped()
                .cornerRadius(40)
                Button(action: {
                    //detalle a Imprimir
                    let id = itemsvm.itemIDDetails?.id
                    onImprimirqr(id!)
                }) {
                    Image(systemName: "qrcode")
                    
                }.frame(maxWidth: .infinity , alignment: .topTrailing).font(.system(size: 40)).zIndex(1).padding(.horizontal, 10).padding(.vertical, 40).cornerRadius(40)
            }
            Divider().padding(.horizontal, 16)
            Text(itemsvm.itemIDDetails?.nombre ?? "No hay nombre").font(.largeTitle).fontWeight(.bold)
            Text(itemsvm.itemIDDetails?.estado ?? "no hay estado encontrado").frame( height: 10, alignment: .center).foregroundColor(.white).padding().background(Capsule().fill(estadoColor))
            Text(itemsvm.itemIDDetails?.descripcion ?? "no hay descripcion").font(.body).lineLimit(3)
            Text("Ubicacion actual: \(itemsvm.itemIDDetails?.ubicacion_actual?.nombre ?? "") - \( itemsvm.itemIDDetails?.ubicacion_actual?.tipo ?? "No hay tipo")")
            Text("Motivo no retorno: \(itemsvm.itemIDDetails?.motivo_no_retorno ?? "No Hay motivo registrado")").lineLimit(2)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity).padding(16)
        .task {
            print("id: \(iditemseleccionado) ")
            await itemsvm.getitemsID(iditemseleccionado)
        }
    }
}


#Preview {
    let vm = ItemsViewModel()
    vm.itemIDDetails = ItemsDetailResponse(
        id: 12,
        nombre: "Taladro Industrial",
        descripcion: "Taladro percutor 800W, serie XR-200",
        foto_url: "https://picsum.photos/seed/taladro/600/400",
        estado: "activo",
        motivo_no_retorno: nil,
        ubicacion_actual: ItemsDetailResponse.Ubicacion(
            id: 3,
            nombre: "Rack A-3",
            tipo: "almacen"
        )
    )
    
    return ItemsViewDetail(
        iditemseleccionado: 12,
        onImprimirqr: { _ in }
    )
    .environmentObject(vm)
}
