//
//  SalidasService.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 24/09/25.
//

import Foundation
final class SalidasService {
    private let client = SupabasemManager.shared.client
    
    func getTalleresObrasSalidas(tipo: String) async throws -> [TallerObrasCardResponse] {
        let result: [TallerObrasCardResponse] = try await client.from("ubicaciones").select("""
        id,
        nombre,
        tipo,
        estado,
        items(
            id,
            nombre,
            foto_url
        ),
        asignacion_trabajadores(
            id,
            trabajadores(
                id,
                foto_url
            )
        )
    """).eq("estado", value: true)
            .eq("tipo", value: tipo)
            .execute()
            .value
        print("Consiguiendo talleres y obras de service ....")
        return result
    }
    
    func getTalleresActivos() async throws -> [TalleresObrasActivosModel] {
        let result: [TalleresObrasActivosModel] = try await client.from("ubicaciones").select("id,nombre,tipo,estado").eq("tipo",value: "taller").eq("estado",value: true).execute().value
        print("Consiguiendo talleres service ....")
        return result
    }
    
    func getObrasActivas() async throws -> [TalleresObrasActivosModel] {
        let result: [TalleresObrasActivosModel] = try await client.from("ubicaciones").select("id,nombre,tipo,estado").eq("tipo",value: "obra").eq("estado",value: true).execute().value
        print("Consiguiendo obras service ....")
        return result
    }
    
    func insertSalida(salida: TallerObrasInsert) async throws -> TallerObrasInsert {
        let result: TallerObrasInsert = try await client
                .from("movimientos")
                .insert(salida)
                .select()   // 👈 para que retorne los datos insertados
                .execute()
                .value
        print("Añadiendo fila insert service.... \(String(describing: result.nota))")
        
        return result
            
    }
    //para devolver si actualiza nota
//    func actualizar_item_noRetorno(nota: String, iditem: Int)async throws -> UpdateNotaItem  {
//        let result : UpdateNotaItem = try await client.from( "items").update(["nota": nota]).eq("id",value: iditem).select().execute().value
//        print("Actualizando nota de item service .... \(String(describing: result.nota)) e id item: \(String(describing: iditem))")
//        return result
//    }
}
