//
//  TalleresActivosModel.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 27/09/25.
//

import Foundation
struct TalleresObrasActivosModel: Identifiable,Codable {
    let id: Int
    let nombre: String
    let tipo: String
    let estado: Bool
}
