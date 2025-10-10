//
//  TallerObrasCardResponse.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 25/09/25.
//

import Foundation

struct TallerObrasCardResponse:Identifiable, Decodable {
    let id: Int
    let nombre: String
    let tipo: String
    let estado: Bool
    let items: [Items]
    let asignacion_trabajadores: [asignacion_trabajadores]
    
    struct Items: Identifiable,Decodable {
        let id: Int
        let nombre: String
        let foto_url: String
        let estado: String
    }
    
    struct asignacion_trabajadores: Identifiable,Decodable {
        let id: Int
        let trabajadores: Trabajadores
        
        struct Trabajadores: Identifiable,Decodable {
            let id: Int
            let foto_url: String
            let nombre: String
            let apellido: String
        }
    }
}
