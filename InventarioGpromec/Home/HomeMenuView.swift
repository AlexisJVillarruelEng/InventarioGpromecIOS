import SwiftUI

struct HomeMenuView: View {
    @EnvironmentObject var login: LoginviewModel
    @StateObject var Itemsvm = ItemsViewModel()
    @StateObject var Salidasvm = SalidasViewModel()
    @StateObject var Entradasvm = EntradasViewModel()
    
    @State var idItemselec: ItemID? = nil
    struct ItemID: Identifiable, Hashable { let id: Int }
    var onlogout: () -> Void
    //NAvegacion Tabs
    enum Tabs: Hashable {case items, entradas, salidas, trabajadores, historial}
    @State private var selectedTab: Tabs = .items
    
    var body: some View {
        
        TabView(selection: $selectedTab){
            Tab("Items", systemImage: "list.clipboard", value: Tabs.items) {
                NavigationStack {
                    ItemsView(onImprimirqr: { id in
                        idItemselec = ItemID(id: id)
                    })
                    .sheet(item: $idItemselec) { sel in
                        ImprimirQrView(itemID: String(sel.id))
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Topbarview(
                                usuario: login.usertoolbar?.usuario,
                                rol:     login.usertoolbar?.rol,
                                foto_url: login.usertoolbar?.foto_url,
                                onlogout: {
                                    Task { if await login.logout() { onlogout() } }
                                }
                            )
                            .frame(maxWidth: .infinity, minHeight: 10)
                        }
                    }
                }
            }
            Tab("Salidas", systemImage: "arrow.up.square", value: Tabs.salidas) {
                NavigationStack {
                    
                    SalidasView(
                        idusuario: login.usertoolbar?.id 
                    )
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Topbarview(
                                usuario: login.usertoolbar?.usuario,
                                rol:     login.usertoolbar?.rol,
                                foto_url: login.usertoolbar?.foto_url,
                                onlogout: {
                                    Task { if await login.logout() { onlogout() } }
                                }
                            )
                            .frame(maxWidth: .infinity, minHeight: 10)
                        }
                    }
                }
            }
            Tab("Entradas",systemImage: "arrow.down.square", value: Tabs.entradas){
                NavigationStack {
                    EntradasView(
                        idusuario: login.usertoolbar?.id
                    )
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Topbarview(
                                usuario: login.usertoolbar?.usuario,
                                rol:     login.usertoolbar?.rol,
                                foto_url: login.usertoolbar?.foto_url,
                                onlogout: {
                                    Task { if await login.logout() { onlogout() } }
                                }
                            )
                            .frame(maxWidth: .infinity, minHeight: 10)
                        }
                    }
                }
            }
            Tab("Trabajadores",systemImage: "person.crop.square", value: Tabs.trabajadores){
                NavigationStack{
                    
                }
            }
            Tab("Historial",systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90", value: Tabs.historial){
                NavigationStack{
                    
                }
            }
        }
        .environmentObject(Itemsvm)
        .environmentObject(Salidasvm)
        .environmentObject(Entradasvm)
        .task {
            if login.usertoolbar == nil{
                await login.getusertoolbar()
            }
            
        }
    }
}

#Preview {
    HomeMenuView( onlogout: {}).environmentObject(LoginviewModel())
}
