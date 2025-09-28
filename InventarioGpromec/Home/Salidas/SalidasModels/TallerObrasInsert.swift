import Foundation


struct TallerObrasInsert: Codable {
    var id: Int
    var ubicacion_origen: Int
    var ubicacion_destino: Int
    var tipo: String
    var operador: UUID
    var estado: String
    var nota: String?
}
