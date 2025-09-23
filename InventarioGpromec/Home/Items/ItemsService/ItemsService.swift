//
//  ItemsViewModel.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 22/09/25.
//

import Foundation

final class ItemsService {
    private let client = SupabasemManager.shared.client
    
    
    //conseguir datos para cards
    func getItems() async throws -> [ItemsModelResponse] {
        let result: [ItemsModelResponse] = try await client
            .from("items")
            .select("""
                id,
                nombre,
                descripcion,
                foto_url,
                estado,
                motivo_no_retorno,
                ubicacion_actual:ubicacion_actual(nombre)
            """)
            .execute()
            .value
        print("service consiguiendo items")
        return result
    }
    //datos para detalle de card
    func getItemDetail(id: Int) async throws -> ItemsDetailResponse {
        let result: ItemsDetailResponse = try await client
            .from("items")
            .select("""
                id,
                nombre,
                descripcion,
                foto_url,
                estado,
                motivo_no_retorno,
                ubicacion_actual:ubicacion_actual(id,nombre,tipo)
            """)
            .eq("id", value: id)
            .single()                      // ← esperas una sola fila
            .execute()
            .value
        print("service consiguiendo itemDetail")
        return result
    }
    
    func buscaritems(nombre: String, estado: String) async throws -> [ItemsModelResponse] {
        let q = nombre.trimmingCharacters(in: .whitespacesAndNewlines)

        let result: [ItemsModelResponse] = try await client
            .from("items")
            .select("""
                id,
                nombre,
                descripcion,
                foto_url,
                estado,
                motivo_no_retorno,
                ubicacion_actual:ubicacion_actual(id,nombre,tipo)
            """)
            .or("nombre.ilike.%\(q)%,estado.ilike.%\(q)%")   // OR simple
            .execute()
            .value

        print("service buscando items (OR): \(result.count)")
        return result
    }
    
}
