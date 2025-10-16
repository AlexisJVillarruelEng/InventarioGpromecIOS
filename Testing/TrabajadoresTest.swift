import Testing

struct TrabajadoresViewModelTests {

    @Test("Carga real de trabajadores desde Supabase")
    func testGetTrabajadoresReal() async throws {
        let vm = TrabajadoresViewModel() // el real
        await vm.getTrabajadores()

        #expect(vm.listaTrabajadores.count > 0)
        #expect(vm.listaTrabajadores.first?.nombre != "")
    }
}
