import Testing
import Foundation
import Supabase
@testable import InventarioGpromec

@MainActor
struct InventarioGpromecTests {

    @Test("carga de lista")
    func example() async throws {
        let vm = TrabajadoresViewModel()      // ok: init en MainActor
        await vm.getTrabajadores()
        let count = vm.listaTrabajadores.count // ok: lectura en MainActor
        #expect(count > 0)
        #expect(vm.listaTrabajadores.first?.nombre != nil, "El primer trabajador debe tener nombre")
        print("✅ Primer trabajador: \(String(describing: vm.listaTrabajadores.first))")
    }
    
    @Test("Falla con SupabaseKey inválida")
        func testSupabaseKeyInvalida() async throws {
            // 1️⃣ Clonamos tu manager pero con key errónea para provocar error HTTP 401
            let badClient = SupabaseClient(
                supabaseURL: URL(string: "https://olocxlmztfaguqdxfuvy.supabase.co")!,
                supabaseKey: "INVALID_KEY"
            )

            // 2️⃣ Servicio personalizado con cliente inválido
            let servicioInvalido = TrabajadoresService(client: badClient)
            let vm = TrabajadoresViewModel(trabajadoresService: servicioInvalido)

            // 3️⃣ Ejecutamos la carga
            await vm.getTrabajadores()

            // 4️⃣ Validamos que el ViewModel reaccionó correctamente
            #expect(vm.listaTrabajadores.isEmpty, "La lista debe estar vacía si falla la autenticación")
            print("lista count: \(vm.listaTrabajadores.count)")
        }
    
    
    
}
