//
//  HistorialView.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 16/10/25.
//

import SwiftUI

struct HistorialView: View {
    @EnvironmentObject var historialvm: HistorialViewModel
    
    var body: some View {
        ScrollView{
            LazyVStack(spacing: 10) {
                ForEach(historialvm.Historial){ historia in
                    CardHistorial(historia: historia)
                    
                }
            }
        }.task {
            await historialvm.getHistorial()
        }
    }
}

#Preview {
    HistorialView()
        .environmentObject({
            let vm = HistorialViewModel()
            vm.Historial = [
                Historial(
                    id: 1,
                    item_id: .init(id: 25, nombre: "Taladro percutor"),
                    ubicacion_origen: .init(id: 2, nombre: "Taller Central"),
                    ubicacion_destino: .init(id: 5, nombre: "Obra Sur"),
                    fecha: Date(),
                    tipo: "Salida",
                    operador: .init(id: UUID(), usuario: "alexis.villarruel"),
                    estado: "activo",
                    nota: "Equipo enviado para mantenimiento"
                ),
                Historial(
                    id: 2,
                    item_id: .init(id: 33, nombre: "Compresor Industrial"),
                    ubicacion_origen: .init(id: 1, nombre: "Almacén Principal"),
                    ubicacion_destino: .init(id: 4, nombre: "Obra Norte"),
                    fecha: Date().addingTimeInterval(-3600),
                    tipo: "Entrada",
                    operador: .init(id: UUID(), usuario: "carlos.ramos"),
                    estado: "inactivo",
                    nota: "Pendiente de revisión"
                ),
                Historial(
                    id: 3,
                    item_id: .init(id: 47, nombre: "Sierra Circular"),
                    ubicacion_origen: .init(id: 3, nombre: "Obra Sur"),
                    ubicacion_destino: .init(id: 2, nombre: "Taller Central"),
                    fecha: Date().addingTimeInterval(-7200),
                    tipo: "Salida",
                    operador: .init(id: UUID(), usuario: "maria.quezada"),
                    estado: "cerrado",
                    nota: "No autorizado para envío"
                )
            ]
            return vm
        }())
}

