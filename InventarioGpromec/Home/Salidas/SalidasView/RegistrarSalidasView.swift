import Foundation
import SwiftUI

struct RegistrarSalidaView: View {
    @EnvironmentObject var salidasvm: SalidasViewModel
    @EnvironmentObject var entradasvm : EntradasViewModel
    @Environment(\.dismiss) private var dismiss

    private enum ActiveAlert: String, Identifiable {
        case success, error
        var id: String { rawValue }
    }
    @State private var activeAlert: ActiveAlert?

    @State private var scanned = ""
    @State private var isTaller = true
    @State private var idtaller: Int? = nil
    @State private var idobra: Int? = nil
    @State private var nota = ""
    @FocusState private var notaFocused: Bool     // 👈 foco del TextEditor

    let userID: UUID
    
    var textoAlert = ""

    private var itemID: Int? { Int(scanned.trimmingCharacters(in: .whitespacesAndNewlines)) }
    private var destinoID: Int? { isTaller ? idtaller : idobra }
    private var isFormValid: Bool {
        if textoAlert == "Salida" {
            return itemID != nil && destinoID != nil && !scanned.isEmpty
        } else { // "Entrada"
            return itemID != nil && !scanned.isEmpty
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("\(textoAlert) de almacen")
                .frame(maxWidth: .infinity)
                .font(.system(size: 35, weight: .bold))
                .padding(.horizontal)
                .padding(.top, 80)
            
            ScanBoxView(scannedText: $scanned)
            
            HStack {
                Text("ID escaneado:")
                Text(scanned.isEmpty ? "No Id escaneado" : scanned)
                    .font(.caption)
            }
            .padding(.horizontal)
            
            if (textoAlert == "Salida"){
                PickerDestino(
                    istaller: $isTaller,
                    tallerseleccionado: $idtaller,
                    obraseleccionado: $idobra,
                    talleres: salidasvm.tallerespicker,
                    obras: salidasvm.obraspicker
                )
            }
            TextEditor(text: $nota)
                .focused($notaFocused)// 👈 enlazado al foco
                .frame(minHeight: 90)
                .padding(10)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)
            
            Button {
                
                
                if textoAlert == "Salida" {
                    guard let id = itemID, let destino = destinoID else {
                        activeAlert = .error
                        return
                    }
                    
                    let itemAEnviar = TallerObrasInsert(
                        item_id: id,
                        ubicacion_origen: 1,
                        ubicacion_destino: destino,
                        tipo: "salida",
                        operador: userID,
                        estado: "abierto",
                        nota: nota.isEmpty ? nil : nota
                    )
                    
                    Task {
                        let ok = await salidasvm.actualizarTallerObra(objinsertar: itemAEnviar)
                        DispatchQueue.main.async {
                            self.activeAlert = ok ? .success : .error
                        }
                    }
                } else if textoAlert == "Entrada" {
                    guard let id = itemID else { activeAlert = .error; return }
                    
                    Task {
                        // 1) Consultar la ubicación actual del item
                        guard let origen = await entradasvm.getubicacionID(id: id) else {
                            await MainActor.run { self.activeAlert = .error }
                            return
                        }
                        
                        // 2) Construir el objeto para movimientos (destino SIEMPRE 1)
                        let movEntrada = TallerObrasInsertEntrada(
                            item_id: id,
                            ubicacion_origen: origen, // 👈 consulta
                            ubicacion_destino: 1,     // 👈 fijo en 1
                            tipo: "entrada",
                            operador: userID,
                            estado: "abierto",
                            nota: nota.isEmpty ? nil : nota
                        )
                        
                        // 3) Insertar movimiento y actualizar item
                        let ok = await entradasvm.actualizarEntrada(objetoEntrada: movEntrada)
                        await MainActor.run { self.activeAlert = ok ? .success : .error }
                    }
                }
                
            } label: {
                Text("Registrar \(textoAlert) del Item")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(isFormValid ? Color.blue : Color.gray, in: Capsule())
                    .foregroundStyle(.white)
            }
            .disabled(!isFormValid)
            .padding(.horizontal)

            Spacer(minLength: 8)
        }
        // 👇 En lugar de .toolbar: inset inferior solo cuando hay foco en el editor
        .safeAreaInset(edge: .bottom) {
            if notaFocused {
                HStack {
                    Spacer()
                    Button("Listo") {
                        notaFocused = false   // cierra teclado
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(.thinMaterial, in: Capsule())
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Listo") {
                    // Oculta el teclado cerrando el foco del TextEditor
                    notaFocused = false
                }
            }
        }
        .alert(item: $activeAlert) { kind in
            switch kind {
            case .success:
                return Alert(
                    title: Text("\(textoAlert) registrada con éxito"),
                    message: Text("El item fue registrado correctamente."),
                    dismissButton: .default(Text("OK")) { dismiss() }
                )
            case .error:
                return Alert(
                    title: Text("Error al registrar \(textoAlert)"),
                    message: Text("Hubo un problema. Revisa los datos e intenta nuevamente."),
                    dismissButton: .cancel(Text("OK"))
                )
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

    
