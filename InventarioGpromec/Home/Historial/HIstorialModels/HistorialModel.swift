//
//  HistorialModel.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 16/10/25.
//

import Foundation

struct Historial : Decodable, Identifiable {
    let id: Int
    let item_id: ItemG //deriva en nombre del item
    let ubicacion_origen: Ubicaciones // sacar el nombre ubi
    let ubicacion_destino: Ubicaciones //sacar nombre ubi destino
    let fecha: Date
    let tipo: String
    let operador: Operador // nombre operador
    let estado: String
    let nota: String
    
    struct ItemG : Decodable {
        let id: Int
        let nombre: String
    }
    
    struct Ubicaciones : Decodable {
        let id: Int
        let nombre: String
    }
    
    struct Operador : Decodable {
        let id: UUID
        let usuario: String
    }
    
}
