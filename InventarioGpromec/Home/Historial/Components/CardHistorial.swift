//
//  CardHistorial.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 16/10/25.
//

import SwiftUI

struct CardHistorial: View {
    let historia: Historial
    
    private var colorEstado : Color {
        switch historia.estado.lowercased() {
                case "activo":
                    return .green
                case "inactivo":
                    return .yellow
                default:
                    return .red
                }
    }
    
    var body: some View {
        
        VStack {
            HStack{
                Text("fecha de registro").frame(maxWidth: .infinity, alignment: .leading)
                Text(historia.fecha.formatted(date: .abbreviated, time: .standard))
                                    .font(.subheadline)
                                    .bold().frame(maxWidth: .infinity, alignment: .trailing)
            }.padding(.horizontal).padding(10)
            HStack{
                Text("Id Item").frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
                Text("\(historia.item_id.id)").frame(maxWidth: .infinity, alignment: .center).font(Font.title.bold())
            }
            HStack{
                Text("Nombre Item").frame(maxWidth: .infinity, alignment: .leading)
                Text(historia.item_id.nombre).frame(maxWidth: .infinity, alignment: .trailing)
            }.padding(.horizontal)
            HStack{
                Text("Ubicacion Origen").frame(maxWidth: .infinity, alignment: .leading)
                Text(historia.ubicacion_origen.nombre).frame(maxWidth: .infinity, alignment: .trailing)
            }.padding(.horizontal)
            HStack{
                Text("Ubicacion Destino").frame(maxWidth: .infinity, alignment: .leading)
                Text(historia.ubicacion_destino.nombre).frame(maxWidth: .infinity, alignment: .trailing)
            }.padding(.horizontal)
            Button(action: {
                
            }){
                Text(historia.estado).padding(.horizontal).background(colorEstado).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal).foregroundStyle(Color.black).frame(maxWidth: .infinity, alignment: .trailing) // cambiar color por estado
            }.padding(20)
            HStack{
                Text("Tipo de Movimiento").frame(maxWidth: .infinity, alignment: .leading)
                Text(historia.tipo).frame(maxWidth: .infinity, alignment: .trailing)
            }.padding()
        }.background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.45))).padding(.vertical).padding(16).onTapGesture {
            
        }.contextMenu{
            HStack{
                Text("Nota")
                Text(historia.nota)
            }
            HStack{
                Text("Operador")
                Text(historia.operador.usuario)
            }
        }
        
    }
}

#Preview {
    // ✅ Ejemplo de datos para probar el diseño
    let ejemplo = Historial(
        id: 1,
        item_id: Historial.ItemG(id: 25, nombre: "Taladro percutor"),
        ubicacion_origen: Historial.Ubicaciones(id: 2, nombre: "Taller Central"),
        ubicacion_destino: Historial.Ubicaciones(id: 5, nombre: "Obra Sur"),
        fecha: Date(),
        tipo: "Salida",
        operador: Historial.Operador(id: UUID(), usuario: "alexis.villarruel"),
        estado: "Activo",
        nota: "Equipo enviado para mantenimiento"
    )
    
    return CardHistorial(historia: ejemplo)
}
