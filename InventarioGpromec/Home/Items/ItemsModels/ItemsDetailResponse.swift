//
//  ItemsDetailResponse.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 23/09/25.
//

import Foundation
struct ItemsDetailResponse: Decodable {
        let id: Int
        let nombre: String
        let descripcion: String?
        let foto_url: String?
        let estado: String
        let motivo_no_retorno: String?
        let ubicacion_actual: Ubicacion?         // alias en la query

        struct Ubicacion: Decodable {
            let id: Int
            let nombre: String
            let tipo: String?
        }
    
}
