import SwiftUI

struct PickerDestino: View {
    @EnvironmentObject var salidasvm: SalidasViewModel
    @Binding var istaller: Bool
    @Binding var tallerseleccionado: Int?
    @Binding var obraseleccionado: Int?
    
    let talleres: [TalleresObrasActivosModel]
    let obras: [TalleresObrasActivosModel]
    
    // Helpers para mostrar el nombre del id seleccionado
    private var nombreTallerSeleccionado: String {
        if let id = tallerseleccionado,
           let t = talleres.first(where: { $0.id == id }) {
            print(" returning \(t.nombre) id \(id)")
            return t.nombre
        }
        return "Talleres"
    }
    private var nombreObraSeleccionada: String {
        if let id = obraseleccionado,
           let o = obras.first(where: { $0.id == id }) {
            return o.nombre
        }
        return "Obras"
    }
    
    
    var body: some View {
        VStack {
            HStack {
                // Botón Taller
                Button(action: {
                    istaller = true
                }) {
                    Text("Taller")
                        .padding()
                        .frame(width: 100)
                        .background(
                            Capsule()
                                .fill(istaller ? Color.blue : Color.gray) // 👈 depende de istaller
                        )
                        .foregroundStyle(.white)
                }
                .disabled(istaller) // ya está seleccionado → no tiene acción
                
                Spacer()
                
                // Botón Obra
                Button(action: {
                    istaller = false
                }) {
                    Text("Obra")
                        .padding()
                        .frame(width: 100)
                        .background(
                            Capsule()
                                .fill(!istaller ? Color.blue : Color.gray) // 👈 inverso
                        )
                        .foregroundStyle(.white)
                }
                .disabled(!istaller) // ya está seleccionado → no tiene acción
            }
            Spacer().frame(height: 20)
            HStack {
                // Talleres
                Picker("Talleres", selection: $tallerseleccionado) {
                    // placeholder visible cuando selection == nil
                    Text("Selecciona un taller").tag(Optional<Int>.none)

                    ForEach(talleres) { t in
                        Text(t.nombre).tag(t.id)   // OJO: Optional(...)
                    }
                }
                .pickerStyle(.menu)
                .disabled(!istaller)
                .onAppear {
                    // si hay exactamente 1, autoselecciona
                    if tallerseleccionado == nil, let unico = talleres.first, talleres.count == 1 {
                        tallerseleccionado = unico.id
                    }
                }
                .onChange(of: tallerseleccionado) { _, new in
                    print("📌 Taller seleccionado → \(String(describing: new))")
                }

                // Obras
                Picker("Obras", selection: $obraseleccionado) {
                    Text("Selecciona una obra").tag(Optional<Int>.none)

                    ForEach(obras) { o in
                        Text(o.nombre).tag(o.id)
                    }
                }
                .pickerStyle(.menu)
                .disabled(istaller)
                .onAppear {
                    if obraseleccionado == nil, let unico = obras.first, obras.count == 1 {
                        obraseleccionado = unico.id
                    }
                }
                .onChange(of: obraseleccionado) { _, new in
                    print("📌 Obra seleccionada → \(String(describing: new))")
                }
            }
        }
        .padding(.horizontal).task {
            await salidasvm.TalleresPicker()
            await salidasvm.ObrasPicker()
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        PickerDestino(
            istaller: .constant(false),
            tallerseleccionado: .constant(nil),
            obraseleccionado: .constant(nil),
            talleres: [
                .init(id: 1, nombre: "Taller A", tipo: "taller", estado: true),
                .init(id: 2, nombre: "Taller B", tipo: "taller", estado: true),
                .init(id: 3, nombre: "Taller C", tipo: "taller", estado: false)
            ],
            obras: [
                .init(id: 4, nombre: "Obra A", tipo: "obra", estado: true),
                .init(id: 5, nombre: "Obra B", tipo: "obra", estado: true),
                .init(id: 6, nombre: "Obra C", tipo: "obra", estado: false)
            ]
        ).environmentObject(SalidasViewModel())
    }
    .padding()
}
