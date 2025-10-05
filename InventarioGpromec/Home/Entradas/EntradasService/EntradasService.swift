//
//  EntradasService.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 4/10/25.
//

import Foundation
final class EntradasService {
    private let client = SupabasemManager.shared.client
    
    func consultardestinoItemScan(id: Int) async throws -> Int  {
        let result : UbicacionActualResponse = try await client.from("items").select("ubicacion_actual").eq("id", value: id).single().execute().value
        return result.ubicacion_actual
    }
    
    
    func insertEntrada(entrada: TallerObrasInsertEntrada) async throws -> TallerObrasInsertEntrada { // Movimientos registro
        let result: TallerObrasInsertEntrada = try await client
                .from("movimientos")
                .insert(entrada)
                .select()   // 👈 para que retorne los datos insertados
                .single()
                .execute()
                .value
        print("Añadiendo fila insert entrada service.... \(String(describing: result.nota))")
        
        return result
            
    }
    
    func actualizarDestinoItem(idItem: Int) async throws {
        let _: Void = try await client
            .from("items").update(["ubicacion_actual": 1]).eq("id", value: idItem).execute().value
    }
    
}
