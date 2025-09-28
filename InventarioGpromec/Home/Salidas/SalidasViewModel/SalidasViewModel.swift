//
//  SalidasViewModel.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 24/09/25.
//

import SwiftUI

@MainActor
final class SalidasViewModel: ObservableObject {
    
    @Published var talleres: [TallerObrasCardResponse] = []
    @Published var obras: [TallerObrasCardResponse] = []
    
    @Published var tallerespicker:[TalleresObrasActivosModel] = []
    @Published var obraspicker:[TalleresObrasActivosModel] = []
    
    enum tipoubi: String{ case  taller, obra}
    
    private let salidaService = SalidasService()
    
    
    func gettalleres() async {
        do {
            let result = try await self.salidaService.getTalleresObrasSalidas(tipo: tipoubi.taller.rawValue)
            talleres = result
            print("viewmodel talleres cargados.. trayendo el 1er:\(String(describing: result.first))")

        }catch{
            let ns = error as NSError
            print("❌ Error al obtener los talleres: \(ns.domain) \(ns.code) \(ns.localizedDescription)")
            print("UserInfo: \(ns.userInfo)")
        }
    }
    
    func getobras() async {
        do {
            let result = try await self.salidaService.getTalleresObrasSalidas(tipo: tipoubi.obra.rawValue)
            obras = result
            print("viewmodel obras cargados.. trayendo el 1er: \(String(describing: result.first))")

        }catch{
            let ns = error as NSError
            print("❌ Error al obtener las obras: \(ns.domain) \(ns.code) \(ns.localizedDescription)")
            print("UserInfo: \(ns.userInfo)")
        }
    }
    
    func TalleresPicker() async {
        do{
            let result = try await self.salidaService.getTalleresActivos()
            tallerespicker = result
            print("Consiguiendo talleres lista.... \(String(describing: result.first))")
        }catch{
            let ns = error as NSError
            print("❌ Error al obtener la lista talleres: \(ns.domain) \(ns.code) \(ns.localizedDescription)")
            print("UserInfo: \(ns.userInfo)")
        }
    }
    
    func ObrasPicker() async {
        do{
            let result = try await self.salidaService.getObrasActivas()
            obraspicker = result
            print("Consiguiendo talleres lista.... \(String(describing: result.first))")
        }catch{
            let ns = error as NSError
            print("❌ Error al obtener la lista obras: \(ns.domain) \(ns.code) \(ns.localizedDescription)")
            print("UserInfo: \(ns.userInfo)")
        }
    }
    
    func actualizarTallerObra(objinsertar: TallerObrasInsert) async {
        do{
            let result = try await self.salidaService.insertSalida(salida: objinsertar)
            print("insertando viewmodel..... respuesta: \(String(describing: result))")
            
        }catch{
            let ns = error as NSError
            print("❌ Error al insertar movimientos \(ns.domain) \(ns.code) \(ns.localizedDescription)")
            print("UserInfo: \(ns.userInfo)")
        }
        
    }
}
