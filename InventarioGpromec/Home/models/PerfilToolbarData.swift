//
//  PerfilToolbarData.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 21/09/25.
//

import Foundation

struct PerfilToolbarData: Codable {
    let id: UUID
    var usuario: String
    var rol: String
    var foto_url: String?
}
