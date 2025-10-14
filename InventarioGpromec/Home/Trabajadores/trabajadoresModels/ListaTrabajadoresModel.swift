//
//  Asignacion_trabajador_model.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 11/10/25.
//

import Foundation

struct ListaTrabajadoresModel: Codable, Identifiable {
    let id : Int
    let nombre : String
    let apellido : String
    let foto_url : String?
}
