//
//  SalidasView.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 24/09/25.
//

import SwiftUI



struct SalidasView: View {
    var idusuario: UUID?
    @EnvironmentObject var salidasvm: SalidasViewModel
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
                        RegistrarSalidaView(userID: idusuario ?? UUID(),
                                            textoAlert: "Salida")
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
    let vm = SalidasViewModel()

    vm.talleres = [
        .init(
            id: 1,
            nombre: "Taller Central",
            tipo: "taller",
            estado: true,
            items: [
                .init(id: 101, nombre: "Taladro XR-200",  foto_url: "https://picsum.photos/seed/taladro/200"),
                .init(id: 102, nombre: "Martillo Pro",    foto_url: "https://picsum.photos/seed/martillo/200"),
                .init(id: 103, nombre: "Sierra Circular", foto_url: "https://picsum.photos/seed/sierra/200"),
                .init(id: 104, nombre: "Compresora",      foto_url: "https://picsum.photos/seed/compresora/200"),
                .init(id: 105, nombre: "Escalera",        foto_url: "https://picsum.photos/seed/escalera/200"),
                .init(id: 106, nombre: "Generador",       foto_url: "https://picsum.photos/seed/generador/200"),
                .init(id: 107, nombre: "Taladro Chico",   foto_url: "https://picsum.photos/seed/taladro2/200"),
                .init(id: 108, nombre: "Pulidora",        foto_url: "https://picsum.photos/seed/pulidora/200"),
                .init(id: 109, nombre: "Llave Inglesa",   foto_url: "https://picsum.photos/seed/llave/200"),
                .init(id: 110, nombre: "Soldadora",       foto_url: "https://picsum.photos/seed/soldadora/200")
            ],
            asignacion_trabajadores: [
                .init(id: 1, trabajadores: .init(id: 11, foto_url: "https://picsum.photos/seed/user1/200")),
                .init(id: 2, trabajadores: .init(id: 12, foto_url: "https://picsum.photos/seed/user2/200")),
                .init(id: 3, trabajadores: .init(id: 13, foto_url: "https://picsum.photos/seed/user3/200")),
                .init(id: 4, trabajadores: .init(id: 14, foto_url: "https://picsum.photos/seed/user4/200")),
                .init(id: 5, trabajadores: .init(id: 15, foto_url: "https://picsum.photos/seed/user5/200")),
                .init(id: 6, trabajadores: .init(id: 16, foto_url: "https://picsum.photos/seed/user6/200"))
            ]
        )    ]

    vm.obras = [
        .init(
            id: 2,
            nombre: "Obra Avenida 9",
            tipo: "obra",
            estado: true,
            items: [
                .init(id: 201, nombre: "Andamio", foto_url: "https://picsum.photos/seed/andamio/200"),
                .init(id: 202, nombre: "Casco",   foto_url: "https://picsum.photos/seed/casco/200"),
                .init(id: 203, nombre: "Guantes", foto_url: "https://picsum.photos/seed/guantes/200"),
                .init(id: 204, nombre: "Arnés",   foto_url: "https://picsum.photos/seed/arnes/200")
            ],
            asignacion_trabajadores: [
                .init(id: 7, trabajadores: .init(id: 17, foto_url: "https://picsum.photos/seed/user7/200")),
                .init(id: 8, trabajadores: .init(id: 18, foto_url: "https://picsum.photos/seed/user8/200")),
                .init(id: 9, trabajadores: .init(id: 19, foto_url: "https://picsum.photos/seed/user9/200")),
                .init(id: 10, trabajadores: .init(id: 20, foto_url: "https://picsum.photos/seed/user10/200"))
            ]
        )
    ]

    return NavigationStack {
        SalidasView(idusuario: UUID())
            .environmentObject(vm).environmentObject(EntradasViewModel())
            .padding()
    }
}
