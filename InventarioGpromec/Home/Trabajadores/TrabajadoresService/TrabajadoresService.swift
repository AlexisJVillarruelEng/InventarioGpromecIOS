//
//  TrabajadoresService.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 11/10/25.
//

import Foundation
final class TrabajadoresService {
    private let client = SupabasemManager.shared.client
    
    func getTrabajadores() async throws -> [ListaTrabajadoresModel] {
        let result: [ListaTrabajadoresModel] = try await client.from("trabajadores").select("*").execute().value
        print("Service Trabajadores: \(result.count)")
        
        return result
    }
    
}
