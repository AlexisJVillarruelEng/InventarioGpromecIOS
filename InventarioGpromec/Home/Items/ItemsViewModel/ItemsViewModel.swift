//
//  ItemsViewModel.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 21/09/25.
//

import Foundation
@MainActor
final class ItemsViewModel : ObservableObject {
    
    @Published var busqueda: String = ""
    @Published var itemscards: [ItemsModelResponse] = []
    @Published var itemIDDetails: ItemsDetailResponse? = nil
    
    private let itemsservice = ItemsService()
    
    
    func getItems() async {
        do {
            let itemsResponse = try await itemsservice.getItems()
            itemscards = itemsResponse
            print("viewmodel items cargados\(itemsResponse.count)")
        } catch {
            let ns = error as NSError
            print("❌ Error al obtener los items: \(ns.domain) \(ns.code) \(ns.localizedDescription)")
            print("UserInfo: \(ns.userInfo)")
        }
    }
    
    func getitemsID(_ id: Int) async {
        do {
            let itemIDResponse = try await itemsservice.getItemDetail(id: id)
            itemIDDetails = itemIDResponse
            print("viewmodel cargando detalle id \(itemIDResponse.id)")
        }catch{
            let ns = error as NSError
            print("❌ Error al obtener los items: \(ns.domain) \(ns.code) \(ns.localizedDescription)")
            print("UserInfo: \(ns.userInfo)")
            
        }
    }
    func buscarItems() async{
        let q = busqueda.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !q.isEmpty else {
                await getItems()                
                return
            }
            do {
                let resultados = try await itemsservice.buscaritems(nombre: busqueda, estado: busqueda)
                itemscards = resultados
                print("buscando '\(q)' => \(resultados.count)")
            } catch {
                print("❌ buscaritems:", error.localizedDescription)
            }
    }
    
}
