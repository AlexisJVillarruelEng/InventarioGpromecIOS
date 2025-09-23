//
//  LoginService.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 15/09/25.
//

import Foundation
import Supabase

final class LoginService {
    private let client = SupabasemManager.shared.client
    
    
    func getemail (for username: String) async throws -> String? {
        let result: [Perfil] = try await client.from("perfil").select("id, usuario, correo").eq("usuario", value: username).limit(1).execute().value
        
        guard let correo = result.first?.correo else {
            throw NSError(
                domain: "Login", code: 404, userInfo: [NSLocalizedDescriptionKey : "Usuario no encontrado con getemail"]
                )
        }
        print("correo: \(correo)")
        return correo
    }
    
    func login( username:  String, password: String) async throws {
        guard let email = try await getemail(for: username) else {
            throw NSError( domain: "Login", code: 404, userInfo: [NSLocalizedDescriptionKey : "Usuario no encontrado loginerror"] )
        }
        let session = try await client.auth.signIn(email: email, password: password)
        print("login exitoso: \(session.user.id)")
    }
    
    func logout() async throws {
        try await client.auth.signOut()
    }
    
    func getusertoolbar() async throws -> PerfilToolbarData {
        let result: PerfilToolbarData = try await client.from("perfil").select("id, usuario, rol, foto_url").single().execute().value
        print("service : \(result.id)")
        return result
    }
    
}
