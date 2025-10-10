//
//  SheetViewDetail.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 8/10/25.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


struct SheetViewDetail: View {
    @EnvironmentObject var entradasvm: EntradasViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State var nota: String = ""
    @FocusState private var notaFocused: Bool   // 👈 foco

    @State var estadoSeleccionado: String
    @State private var showResultAlert = false
    @State private var wasSuccess = false
    
    let userID: UUID
    let item : TallerObrasCardResponse.Items
    
    
    // inicializas el estadoSeleccionado con el valor inicial del item
    init(item: TallerObrasCardResponse.Items, userID: UUID) {
        self.item = item
        self.userID = userID
        _estadoSeleccionado = State(initialValue: item.estado)
    }
    
    private var estadoColor: Color {
        switch estadoSeleccionado {
            case "activo":     return .green
            case "inactivo":   return .red
            case "reparacion": return .yellow
            default:           return .gray
            }
        }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Id seleccionado: \(item.id)")
            Text("Nombre Item: \(item.nombre)")
            Text("Comenta el motivo de NO Retorno o Avería").foregroundStyle(.secondary)
            ZStack(alignment: .topLeading) {
                if nota.isEmpty {
                    Text("Agrega tu comentario")
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                        .padding(.leading, 6) // alineado al contenido real
                }
                
                TextEditor(text: $nota)
                    .frame(height: 120) // altura inicial
                    .padding(6)
                    .background(Color.clear)
                    .scrollContentBackground(.hidden) // quita fondo por defecto
                    .autocorrectionDisabled()
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.secondary.opacity(0.4), lineWidth: 1)
            )
            HStack{
                Text("Cambiar estado")
                Spacer()
                Button(action: {
                    // ciclo entre los 3 estados
                    withAnimation(.easeInOut(duration: 0.4)) {
                        switch estadoSeleccionado { //cambiar estado por el vm
                        case "activo":
                            estadoSeleccionado = "inactivo"
                        case "inactivo":
                            estadoSeleccionado = "reparacion"
                        default:
                            estadoSeleccionado = "activo"
                        }
                    }
                }) {
                    Text(estadoSeleccionado)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 120, height: 32)
                        .background(estadoColor)
                        .cornerRadius(8)
                }.animation(.easeInOut(duration: 0.4),value: estadoColor)//cambiar estado por el vm
            }.frame(maxWidth: .infinity)
            Button(
                action : {
                    // guardar
                    Task{
                        guard let origenItemSeleccionado = await entradasvm.getubicacionID(id: item.id)else {
                            return
                        }
                            
                        let objetoInsertarMovimientos = insertarItemsPerdidoAveriadoModel(
                                item_id: item.id,
                                ubicacion_origen: origenItemSeleccionado ,
                                ubicacion_destino: 1 ,
                                tipo: "entrada",
                                operador: userID,
                                estado: estadoSeleccionado,
                                nota: nota
                            )
                            
                            
                        let ok = await entradasvm.actualizarItemMovimientoPerdidoAveriado(objItemAct: objetoInsertarMovimientos)
                        await MainActor.run {
                            wasSuccess = ok
                            showResultAlert = true
                        }
                    }
                }
            ){
                Text(" Click Para REGISTRAR").frame(maxWidth: .infinity, maxHeight: 30 ).background(Color.blue).clipShape(.capsule).foregroundColor(.white).padding()
            }
        }.onTapGesture {
            UIApplication.shared.endEditing() //oculta teclado
        }
        .padding()
        .alert(isPresented: $showResultAlert) {
            Alert(
                title: Text(wasSuccess ? "Registrado correctamente" : "Error al registrar"),
                message: Text(wasSuccess ? "El movimiento se guardó con éxito." : "Hubo un problema. Intenta nuevamente."),
                dismissButton: .default(Text("OK")) {
                    if wasSuccess {
                        dismiss()
                    }
                }
            )
        }
    }
}


#Preview {
    SheetViewDetail(
        item: .init(
            id: 101,
            nombre: "Taladro XR-200",
            foto_url: "https://picsum.photos/seed/taladro/200",
            estado: "activo"
        ), userID: UUID()
    ).environmentObject(EntradasViewModel())
}
