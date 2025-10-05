//
//  EntradasView.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 4/10/25.
//

import SwiftUI

struct EntradasView: View {
    var idusuario: UUID?
    @EnvironmentObject var salidasvm : SalidasViewModel
    @EnvironmentObject var entradasvm : EntradasViewModel
    @State private var showScanner = false
    
    var body: some View {
        ZStack {  // 👈 1. Usamos ZStack para superponer el FAB sobre la vista principal
            VStack { // 👈 2. Tu contenido principal
                HStack(alignment: .center) {
                    Text("Talleres")
                        .padding(.leading)
                        .frame(maxWidth: .infinity)
                        .font(.title2)
                        .bold(true)
                    
                    Spacer()
                    
                    Text("Obras")
                        .padding(.trailing)
                        .frame(maxWidth: .infinity)
                        .font(.title2)
                        .bold(true)
                }
                .padding(.top, 16)
                
                Spacer().frame(height: 40)
                
                //lista de Talleres -----   Obras
                HStack(alignment: .center) {
                    ScrollView {
                        ForEach(salidasvm.talleres) { item in
                            TalleresObrasCard(item: item)
                        }
                    }
                    .scrollIndicators(.hidden) //listado de cards Talleres
                    
                    Spacer()
                    
                    Divider()
                        .frame(width: 3)
                        .background(Color.black.opacity(0.2))
                        .padding(.vertical)
                    
                    ScrollView {
                        ForEach(salidasvm.obras) { item in
                            TalleresObrasCard(item: item)
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                .padding(.horizontal)
            }
            
            // 👇 3. El FAB flotante
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    NavigationLink {
                        RegistrarSalidaView(userID: idusuario ?? UUID()
                        ,textoAlert: "Entrada")
                            .ignoresSafeArea()
                            .toolbar(.hidden, for: .tabBar)   // 👈 oculta los tabs
                            .navigationBarBackButtonHidden(false) // botón "back"
                    } label: {
                        Image(systemName: "qrcode.viewfinder")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }.padding(.top, 16)
                        .padding(.trailing, 16)
                }
            }
            .task {
                await salidasvm.gettalleres()
                await salidasvm.getobras()
            }
        }

    }
}

#Preview {
    EntradasView().environmentObject(SalidasViewModel()).environmentObject(EntradasViewModel())
}
