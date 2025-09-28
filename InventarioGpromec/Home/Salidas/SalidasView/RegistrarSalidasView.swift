//
//  CamaraSalidasView.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 26/09/25.
//

import Foundation
import SwiftUI

struct RegistrarSalidaView: View {
    @EnvironmentObject var salidasvm: SalidasViewModel
    
    @State private var scanned = "" // id escaneado
    @State private var isTaller = true //si es seleccionado para bloquear el otro boton
    @State private var idtaller: Int? = nil   // selecciono taller
    @State private var idobra : Int? = nil    //seleccion obra
    @State private var nota = ""    //nota para guardar
    let userID: UUID// id perfil usuario
    
    // MARK: - Computados de validación
    private var itemID: Int? { Int(scanned.trimmingCharacters(in: .whitespacesAndNewlines)) }
    private var destinoID: Int? { isTaller ? idtaller : idobra }


    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Salida de almacen").frame(maxWidth: .infinity)
                .font(.system(size: 35, weight: .bold))
                .padding(.horizontal).padding(.top,80)

            // Cámara con máscara y ROI
            ScanBoxView(scannedText: $scanned)

            // Resultado del escaneo
            HStack{
                Text("ID escaneado:")
                Text(scanned.isEmpty ? "No Id escaneado" : scanned).font(.caption)
            }.padding(.horizontal)

            // Selector Taller / Obra y picker destino
            PickerDestino(istaller: $isTaller
                          ,tallerseleccionado: $idtaller
                          ,obraseleccionado: $idobra
                          ,talleres: salidasvm.tallerespicker
                          ,obras: salidasvm.obraspicker
            )
            
            // Nota
            TextEditor(text: $nota)
                .frame(minHeight: 90)
                .padding(10)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Listo") {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                            to: nil, from: nil, for: nil)
                        }
                    }
                }

            // Botón
            Button {
                let itemAEnviar = TallerObrasInsert(
                    id: Int(scanned)!
                    , ubicacion_origen: 1
                    , ubicacion_destino: destinoID!
                    , tipo: "salida"
                    , operador: userID
                    , estado: "abierto"
                    , nota: nota.isEmpty ? nil : nota
                )
                Task{
                    await salidasvm.actualizarTallerObra(objinsertar: itemAEnviar)
                }
            } label: {
                Text("Registrar salida del Item")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.blue, in: Capsule())
                    .foregroundStyle(.white)
            }
            .padding(.horizontal)

            Spacer(minLength: 8)
        }
        .ignoresSafeArea(.keyboard)
    }
}
#Preview("RegistrarSalidaView") {
    RegistrarSalidaView(userID: UUID()).environmentObject(SalidasViewModel())
        .padding()
        .background(Color(.systemGroupedBackground))
}
