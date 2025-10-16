//
//  TrabajadoresViewModel.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 11/10/25.
//

import Foundation

@MainActor
final class TrabajadoresViewModel: ObservableObject {
    
    @Published var listaTrabajadores: [ListaTrabajadoresModel] = []
    @Published var esValidado : Bool = false
    
    private let trabajadoresService: protocolTrabajadores
    
    init( trabajadoresService: protocolTrabajadores = TrabajadoresService()){
        self.trabajadoresService = trabajadoresService
    }
    
    
    func getTrabajadores() async {
        do {
            self.listaTrabajadores = try await trabajadoresService.getTrabajadores()
            
            print("Viewmodel Trabajadores: \(String(describing: listaTrabajadores.first))")
            
        }catch{
            listaTrabajadores = []
            let ns = error as NSError
            print("❌ Error al obtener lista de Trabajadores : \(ns.domain) \(ns.code) \(ns.localizedDescription)")
            print("UserInfo: \(ns.userInfo)")
        }
    }
    
    func validarAsignacion(idTrabajador: Int) async -> Bool {
        do {
            let estaAsignado = try await trabajadoresService.verificarAsignacionID(idtrabajador: idTrabajador)
            esValidado = estaAsignado
            return estaAsignado
            
        }catch{
            esValidado = false
            return false
        }
    }
    
    func AsignacionTrabajadores(idTrabajador: Int, idDestino: Int) async -> Bool {
        do {
            //validar si esta asignado
            let estaAsignado = try await trabajadoresService.verificarAsignacionID(idtrabajador: idTrabajador)
            // si esta asignado llamar a update
            if estaAsignado {
                try await trabajadoresService.actualizarAsignacion(idtrabajador: idTrabajador, ubicacion: idDestino)
                esValidado = true
            }else{
                // si no lo esta insertar
                esValidado = false
                let asignado = insertAsignacion(
                    trabajador_id: idTrabajador, ubicacion_id: idDestino
                )
                _ = try await trabajadoresService.insertAsignacion(asignadoInsert: asignado)
            }
            return true
        }catch{
            let ns = error as NSError
            print("❌ Error al asignar o Actualizar a Trabajador : \(ns.domain) \(ns.code) \(ns.localizedDescription)")
            print("UserInfo: \(ns.userInfo)")
            return false
        }
    }
}
