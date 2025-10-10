//
//  ActualizarItemModels.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 10/10/25.
//

import Foundation

struct ActualizarItemModels: Encodable {
    let estado: String
    let motivo_no_retorno: String
    let ubicacion_actual: Int
}
