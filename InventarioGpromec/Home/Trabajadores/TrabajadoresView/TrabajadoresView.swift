//
//  TrabajadoresView.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 11/10/25.
//

import SwiftUI

struct TrabajadoresView: View {
    @EnvironmentObject var salidasvm: SalidasViewModel
    @EnvironmentObject var trabajadoresvm: TrabajadoresViewModel
    @State private var isTaller = true
    @State var idtrabajadorSeleccionado : Int = 0
    @State private var idtalleres: Int? = nil
    @State private var idobras: Int? = nil
    @State private var mostrarAlerta = false
    
    private var destinoSeleccionado: Int? {
        isTaller ? idtalleres : idobras
    }
    
    var body: some View {
        
        VStack {
            Text("Asignacion de trabajadores").frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 30).foregroundStyle(.secondary)
            
            List(trabajadoresvm.listaTrabajadores , id: \.id) { trabajador in
                listTrabajadores(trabajadores: trabajador).onTapGesture {
                    trabajadoresvm.esValidado = false // reset antes de asignar
                    idtrabajadorSeleccionado = trabajador.id
                    print("id Seleccionado  -> \(idtrabajadorSeleccionado)")
                    Task{
                        let esValido = await trabajadoresvm.validarAsignacion(idTrabajador: idtrabajadorSeleccionado)
                        print("Respuesta de verificacion : \(esValido)")
                    }
                }
            }.frame(height : 400)
            Text("ID seleccionado: \(idtrabajadorSeleccionado)").frame(maxWidth: .infinity, alignment: .leading).padding().foregroundStyle(.secondary)
            PickerDestino(istaller: $isTaller,
                          tallerseleccionado: $idtalleres,
                          obraseleccionado: $idobras,
                          talleres: salidasvm.tallerespicker,
                          obras: salidasvm.obraspicker)
            Button(action: {
                Task{
                   _ = await trabajadoresvm.AsignacionTrabajadores(idTrabajador: idtrabajadorSeleccionado, idDestino: destinoSeleccionado!)
                    mostrarAlerta = true
                }
            }){
                Text(trabajadoresvm.esValidado ? "Actualizar" : "Asignar").frame(width: 150, height: 50).background((destinoSeleccionado == nil) ? Color.gray : Color.blue).foregroundColor(.white).clipShape(.capsule)
            }.disabled(destinoSeleccionado == nil )
        }.task {
            await trabajadoresvm.getTrabajadores()
        }.alert("Trabajador actualizado o Asignado", isPresented: $mostrarAlerta){
            Button("Ok", role: .cancel){}
        } message: {
            Text("actulizado o Asignado")
        }
    }
}

#Preview {
    let previewVM = TrabajadoresViewModel()
    previewVM.listaTrabajadores = [
        ListaTrabajadoresModel(id: 1, nombre: "Ana", apellido: "Quispe", foto_url: "https://randomuser.me/api/portraits/women/44.jpg"),
        ListaTrabajadoresModel(id: 2, nombre: "Luis", apellido: "Pérez", foto_url: "https://randomuser.me/api/portraits/men/32.jpg"),
        ListaTrabajadoresModel(id: 3, nombre: "María", apellido: "García", foto_url: "https://randomuser.me/api/portraits/women/65.jpg")
    ]
    
    return TrabajadoresView( idtrabajadorSeleccionado: 2 )
        .environmentObject(previewVM).environmentObject(SalidasViewModel())
}
