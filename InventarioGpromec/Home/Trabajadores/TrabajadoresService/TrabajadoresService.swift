//
//  TrabajadoresService.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 11/10/25.
//

import Foundation
import Supabase

final class TrabajadoresService : protocolTrabajadores {
    
    
    private let client: SupabaseClient
    
    init(client: SupabaseClient = SupabasemManager.shared.client) {
            self.client = client
        }
    
    func getTrabajadores() async throws -> [ListaTrabajadoresModel] {
        let result: [ListaTrabajadoresModel] = try await client.from("trabajadores").select("*").execute().value
        print("Service Trabajadores: \(result.count)")
        
        return result
    }
    
    func insertAsignacion(asignadoInsert: insertAsignacion) async throws -> insertAsignacion {
        let result: insertAsignacion = try await client.from("asignacion_trabajadores").insert(asignadoInsert).execute().value
        return result
    }
    
    func verificarAsignacionID(idtrabajador: Int) async throws -> Bool {
        var resultado = false
        do {
            let data: [insertAsignacion] = try await client
                .from("asignacion_trabajadores")
                .select("trabajador_id, ubicacion_id")
                .eq("trabajador_id", value: idtrabajador)
                .execute()
                .value
            resultado = !data.isEmpty
        } catch {
            resultado = false
        }
        return resultado
    }
    
    
    func actualizarAsignacion(idtrabajador: Int, ubicacion: Int) async throws  {
        let _ : Void = try await client.from("asignacion_trabajadores").update(["trabajador_id" : idtrabajador, "ubicacion_id" : ubicacion]).eq("trabajador_id", value: idtrabajador).execute().value
    }
}
