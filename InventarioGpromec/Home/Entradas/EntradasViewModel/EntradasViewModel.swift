//
//  EntradasViewModel.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 4/10/25.
//

import Foundation
final class EntradasViewModel: ObservableObject {
    
    
    private let entradasService = EntradasService()
    
    
    func getubicacionID(id : Int) async -> Int? {
        do {
            let result = try await entradasService.consultardestinoItemScan(id: id)
            print(" viewmodel consiguiendo el id de la ubicacion : \(result)")
            return result
        }catch{
            let ns = error as NSError
            print("❌ Error al obtener el id: \(ns.domain) \(ns.code) \(ns.localizedDescription)")
            print("UserInfo: \(ns.userInfo)")
        }
        return nil
    }
    
    func actualizarEntrada(objetoEntrada: TallerObrasInsertEntrada) async -> Bool {
        // Paso 1: Insert
        do {
            let result = try await entradasService.insertEntrada(entrada: objetoEntrada)
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
            try await entradasService.actualizarDestinoItem(idItem: objetoEntrada.item_id)
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
    
    func actualizarItemMovimientoPerdidoAveriado(objItemAct: insertarItemsPerdidoAveriadoModel) async -> Bool {
        // 1 Insertar
        do{
            print("objeto a insertar : \(objItemAct)")
            let result = try await entradasService.insertarPeridoAveriadoMovimientos(entradaAveriadoPerdido: objItemAct)
            print("insertando en movimientos : \(result)")
        }catch{
            let ns = error as NSError
            print("❌ Error en INSERT movimientos")
            print("Domain: \(ns.domain) Code: \(ns.code)")
            print("Description: \(ns.localizedDescription)")
            print("UserInfo: \(ns.userInfo)")
            return false   // ya no seguimos al update        }
        }
        // 2 update
        do{
            let actualizaItem = ActualizarItemModels(estado: objItemAct.estado,
                                                     motivo_no_retorno: objItemAct.nota ?? "",
                                                     ubicacion_actual: objItemAct.ubicacion_destino
                                                     
            )
            
            try await entradasService.actualizarItemAveriadoPerdidoItems(idItem: objItemAct.item_id, objetoactualizaritem: actualizaItem)
            print("✅ Ubicación y Nota del item actualizada")
            return true
        }catch {
            let ns = error as NSError
            print("❌ Error en UPDATE item")
            print("Domain: \(ns.domain) Code: \(ns.code)")
            print("Description: \(ns.localizedDescription)")
            print("UserInfo: \(ns.userInfo)")
            return false
        }
    }
}
