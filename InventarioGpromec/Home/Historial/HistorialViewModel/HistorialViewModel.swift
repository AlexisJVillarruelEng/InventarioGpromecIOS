//
//  HistorialViewModel.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 16/10/25.
//

import Foundation

@MainActor
final class HistorialViewModel: ObservableObject {
    
    @Published var Historial: [Historial] = []
    
    private let HistorialServ: HistorialProtocol
    
    init( HistorialServ: HistorialProtocol = HistorialService() ) {
        self.HistorialServ = HistorialServ
    }
    
    func getHistorial() async  {
        do {
            let result =  try await HistorialServ.getHistorial()
            Historial = result
        }catch{
            let ns = error as NSError
            print("❌ Error al obtener HISTORIAL : \(ns.domain) \(ns.code) \(ns.localizedDescription)")
            print("UserInfo: \(ns.userInfo)")
        }
    }
}
