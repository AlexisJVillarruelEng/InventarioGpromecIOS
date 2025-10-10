//
//  EntradasModel.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 4/10/25.
//

import Foundation

struct TallerObrasInsertEntrada: Codable {
    var item_id: Int
    var ubicacion_origen: Int
    var ubicacion_destino: Int
    var tipo: String
    var operador: UUID
    var estado: String
    var nota: String?
}
