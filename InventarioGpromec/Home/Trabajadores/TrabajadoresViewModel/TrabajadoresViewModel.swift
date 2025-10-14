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
    
    
    private let trabajadoresService = TrabajadoresService()
    
    
    func getTrabajadores() async {
        do {
            let result = try await trabajadoresService.getTrabajadores()
            self.listaTrabajadores = result
            print("Viewmodel Trabajadores: \(String(describing: listaTrabajadores.first))")
            
        }catch{
            let ns = error as NSError
            print("❌ Error al obtener lista de Trabajadores : \(ns.domain) \(ns.code) \(ns.localizedDescription)")
            print("UserInfo: \(ns.userInfo)")
        }
    }
}
