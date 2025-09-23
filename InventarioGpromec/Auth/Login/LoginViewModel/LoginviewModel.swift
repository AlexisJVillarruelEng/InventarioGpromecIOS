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
    
    @Published var usertoolbar: PerfilToolbarData?
    
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
    
    func logout() async -> Bool {
        do{
            try await loginservice.logout()
            username = ""
            password = ""
            usertoolbar = nil
            return true
        }catch {
            let nsError = error as NSError
            mensajealerta = nsError.localizedDescription
            return false
        }
    }
    
    func getusertoolbar() async {
        print("usando vmlogin get user rol")
        do {
            usertoolbar = try await loginservice.getusertoolbar()
        }catch {
            let nsError = error as NSError
            mensajealerta = nsError.localizedDescription
        }
    }
    
}
