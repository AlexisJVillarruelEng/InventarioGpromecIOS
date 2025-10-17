//
//  HistorialService.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 16/10/25.
//

import Foundation
import Supabase

final class HistorialService: HistorialProtocol {
    
    private let client: SupabaseClient
    
    init(client: SupabaseClient = SupabasemManager.shared.client) {
            self.client = client
        }
    
    func getHistorial() async throws -> [Historial] {
        let result: [Historial] = try await client
          .from("movimientos")
          .select("""
            id,
            fecha,
            tipo,
            estado,
            nota,
            item_id:items ( id, nombre ),
            ubicacion_origen:ubicaciones!movimientos_ubicacion_origen_fkey ( id, nombre ),
            ubicacion_destino:ubicaciones!movimientos_ubicacion_destino_fkey ( id, nombre ),
            operador:perfil ( id, usuario )
          """)
          .order("fecha", ascending: false)
          .execute()
          .value
        return result
    }
}
