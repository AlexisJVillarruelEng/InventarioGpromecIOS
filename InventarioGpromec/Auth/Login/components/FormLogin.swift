//
//  FormLogin.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 20/09/25.
//

import SwiftUI

struct FormLogin: View {
    @Binding var usuario: String
    @Binding var contrasena: String
    var Login: () -> Void = { }
    
    var body: some View {
        
        
        VStack{
            TextField("Usuario", text: $usuario).padding().textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                    .padding(.horizontal, 16)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(.white.opacity(0.25), lineWidth: 1)
                    )
            
            
            
            SecureField("Contraseña", text: $contrasena).padding()
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .padding(.horizontal, 16)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(.white.opacity(0.25), lineWidth: 1)
                )
            
            Button(action: {
                Login()
            }) {
                Text("Ingresar")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(16)
            }.disabled(usuario.isEmpty || contrasena.isEmpty)
        }.padding(.horizontal)
    }
}

#Preview {
    FormLogin(
        usuario: .constant("Alex"), contrasena:.constant("1234")
    )
}
