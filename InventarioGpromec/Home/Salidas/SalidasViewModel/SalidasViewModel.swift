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
    
    func actualizarTallerObra(objinsertar: TallerObrasInsert) async -> Bool {
        // Paso 1: Insert
        do {
            let result = try await salidaService.insertSalida(salida: objinsertar)
            print("✅ Insertado en movimientos: \(result)")
        } catch {
            let ns = error as NSError
            print("❌ Error en INSERT movimientos")
            print("Domain: \(ns.domain) Code: \(ns.code)")
            print("Description: \(ns.localizedDescription)")
            print("UserInfo: \(ns.userInfo)")
            return false   // ya no seguimos al update
        }

        // Paso 2: Update
        do {
            try await salidaService.actualizarOrigenItem(idItem: objinsertar.item_id, id_destino: objinsertar.ubicacion_destino)
            print("✅ Ubicación del item actualizada")
            return true
        } catch {
            let ns = error as NSError
            print("❌ Error en UPDATE ubicacion_actual")
            print("Domain: \(ns.domain) Code: \(ns.code)")
            print("Description: \(ns.localizedDescription)")
            print("UserInfo: \(ns.userInfo)")
            return false
        }
    }
}
