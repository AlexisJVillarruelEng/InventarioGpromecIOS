//
//  LoginviewModel.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 15/09/25.
//

import Foundation

@MainActor
final class LoginviewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    
    @Published var showalerta = false
    @Published var mensajealerta: String = ""
    
    private let loginservice = LoginService()
    
    
    func login() async -> Bool {
        print("usando vmlogin")
            do {
                try await loginservice.login(username: username, password: password)
                mensajealerta = "Bienvenido"
                showalerta = true
                return true
            }catch{
                let nsError = error as NSError
                mensajealerta = nsError.localizedDescription
                showalerta = true
                return false
            }
        
    }
}
