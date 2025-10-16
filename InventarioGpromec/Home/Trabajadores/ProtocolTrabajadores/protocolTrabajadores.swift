//
//  protocolTrabajadores.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 15/10/25.
//

import Foundation

protocol protocolTrabajadores {
    
    func getTrabajadores() async throws -> [ListaTrabajadoresModel]
    
    func insertAsignacion(asignadoInsert: insertAsignacion) async throws -> insertAsignacion
    
    func verificarAsignacionID(idtrabajador: Int) async throws -> Bool
    
    func actualizarAsignacion(idtrabajador: Int, ubicacion: Int) async throws
}
