//
//  LoginView.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 19/09/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject var login = LoginviewModel()
    @State private var estalogueado = false // controla si es correcto navegar
    
    var body: some View {
        ZStack{
            Background()
            VStack{
                FormLogin(usuario: $login.username, contrasena: $login.password
                ,Login: {
                    Task{
                        let okey = await  login.login()
                        if okey {
                            estalogueado = true
                            }
                        }
                    }
                )
            }
            ToastView(texto: login.mensajealerta, esmostrar: $login.showalerta)
            
        }
        .fullScreenCover(isPresented: $estalogueado){
            HomeMenuView(
                onlogout: {
                    estalogueado = false
                }
            )
                .interactiveDismissDisabled(true) //sin gesto
                .environmentObject(login)
        }
//        .alert("AVISO", isPresented: $login.showalerta){
//            Button("OK", role: .cancel){
//            }
//        } message: {
//            Text(login.mensajealerta)
//        }
    }
}

#Preview {
    LoginView()
}
