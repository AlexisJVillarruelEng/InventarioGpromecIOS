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
    
    
    
}
