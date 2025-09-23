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
    
}
