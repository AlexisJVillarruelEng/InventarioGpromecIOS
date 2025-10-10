
//  insertaritemPerdidoAveriadoModel.swift

import Foundation

struct insertarItemsPerdidoAveriadoModel: Codable {
    var item_id: Int
    var ubicacion_origen: Int
    var ubicacion_destino: Int
    var tipo: String
    var operador: UUID
    var estado: String
    var nota: String?
}
