//
//  ItemsModelResponse.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 22/09/25.
//

import Foundation
struct ItemsModelResponse: Identifiable, Decodable {
    var id: Int
    var nombre: String
    var descripcion: String
    var foto_url: String
    var estado: String
    var motivo_no_retorno: String?
    var ubicacion_actual: Ubicacion
    // en tabla es ID int
    struct Ubicacion: Decodable {
        var nombre: String
    }
}
