//
//  DetailView.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 7/10/25.
//

import SwiftUI

struct DetailView: View {
    var itemdetail: TallerObrasCardResponse
    var txthabboton: String
    var uid: UUID
    
    var body: some View {
        
        VStack { // hacer el borde redondeado
            Text(itemdetail.nombre).font(.title).bold()
            Spacer()
            Text("Herramientas").frame(maxWidth: .infinity ,alignment: .leading).foregroundStyle(.secondary)
            //scroll items
            ScrollView{
                LazyVStack(){
                    ForEach(itemdetail.items){ itemherramientas in
                        cardherramientasdetail(itemh: itemherramientas,textobotonhabilitado: txthabboton, uuid : uid)
                    }
                }
            }.frame(height: 300)
            
            Text("Trabajadores").frame(maxWidth: .infinity ,alignment: .leading).foregroundStyle(.secondary)
            //scroll trabajadores
            ScrollView{
                LazyVStack(){
                    ForEach(itemdetail.asignacion_trabajadores){ trab in
                        cardtrabajadoresSalidaEntradaDetail(trabajador: trab)
                        
                    }
                    
                }
            }.frame(height: 300)
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(.vertical, 20).padding(.horizontal)
        
    }
}

struct cardherramientasdetail: View {
    let itemh: TallerObrasCardResponse.Items
    var textobotonhabilitado: String = ""
    @State var showsheet = false
    let uuid: UUID
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: itemh.foto_url)){
                caso in
                switch caso {
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                default:
                    Color.gray.opacity(0.2)
                }
            }.frame(width: 56, height: 56).clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack {
                Text("\(itemh.id)").font(.headline).frame(maxWidth: .infinity, alignment: .leading)
                Text(itemh.nombre).font(.caption).frame(maxWidth: .infinity, alignment: .leading)
            }.padding()
            
            if textobotonhabilitado == "Entrada" {
                Button(action: {
                    showsheet = true
                }) {
                    Text("Click si esta Perdido o Averiado").frame(maxWidth: .infinity).background(RoundedRectangle(cornerRadius: 10).fill(Color.blue)).foregroundStyle(.white)
                }
            }
        }.padding().sheet(isPresented: $showsheet) {
            SheetViewDetail(item: itemh,userID : uuid ).presentationDetents([.medium])
        }
    }
}

struct cardtrabajadoresSalidaEntradaDetail: View {
    let trabajador: TallerObrasCardResponse.asignacion_trabajadores
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: trabajador.trabajadores.foto_url)){
                caso in
                switch caso {
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                default: Color.gray.opacity(0.2)
                }
            }.frame(width: 56, height: 56).clipShape(RoundedRectangle(cornerRadius: 20))
            Text("\(trabajador.trabajadores.nombre) \(trabajador.trabajadores.apellido)").frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
        }.padding()
    }
}

#Preview {
    DetailView(itemdetail: .init(
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
    ), txthabboton: "Entrada", uid: UUID())
}
