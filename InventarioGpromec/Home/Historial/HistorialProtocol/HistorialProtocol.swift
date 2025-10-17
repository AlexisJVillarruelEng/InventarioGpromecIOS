//
//  HistorialProtocol.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 16/10/25.
//

import Foundation

protocol HistorialProtocol {
    
    func getHistorial() async throws -> [Historial]
    
}
