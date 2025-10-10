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
            foto_url,
            estado
        ),
        asignacion_trabajadores(
            id,
            trabajadores(
                id,
                foto_url,
                nombre,
                apellido
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
    
    func insertSalida(salida: TallerObrasInsert) async throws -> TallerObrasInsert { // Movimientos registro
        let result: TallerObrasInsert = try await client
                .from("movimientos")
                .insert(salida)
                .select()   // 👈 para que retorne los datos insertados
                .single()
                .execute()
                .value
        print("Añadiendo fila insert service.... \(String(describing: result.nota))")
        
        return result
            
    }
    
    func actualizarOrigenItem(idItem: Int, id_destino: Int) async throws {
        let _: Void = try await client
            .from("items").update(["ubicacion_actual": id_destino]).eq("id", value: idItem).execute().value
    }
    
}
