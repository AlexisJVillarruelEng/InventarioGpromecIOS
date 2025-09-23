import SwiftUI

struct HomeMenuView: View {
    @EnvironmentObject var login: LoginviewModel
    @StateObject var Itemsvm = ItemsViewModel()
    @State var idItemselec: Int? = nil
    
    var onlogout: () -> Void
    //NAvegacion Tabs
    enum Tabs: Hashable {case items, entradas, salidas, trabajadores, historial}
    @State private var selectedTab: Tabs = .items
    
    var body: some View {
        
        TabView(selection: $selectedTab){
            Tab("Items",systemImage: "list.clipboard", value: Tabs.items ){
                NavigationStack{
                    ItemsView(
                        onImprimirqr: {
                            id in idItemselec = id
                        }
                    ).toolbar {
                        Toolbar(
                            usuario: login.usertoolbar?.usuario,
                            rol: login.usertoolbar?.rol,
                            foto_url: login.usertoolbar?.foto_url,
                            onlogout: {
                                Task{
                                    if await login.logout(){
                                        onlogout()
                                    }
                                }
                            }
                        )
                    }.navigationDestination(item: $idItemselec){ id in
                            ImprimirQrView(itemID: String(id))
                        }
                }
            }
            Tab("Salidas", systemImage: "arrow.up.square", value: Tabs.salidas){
                NavigationStack{
                    //pantalla de salidas
                }
            }
            Tab("Entradas",systemImage: "arrow.down.square", value: Tabs.entradas){
                NavigationStack{
                    
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
