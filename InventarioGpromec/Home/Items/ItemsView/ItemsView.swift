//
//  ItemsView.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 21/09/25.
//

import SwiftUI

struct ItemsView: View {
    @EnvironmentObject var itemsvm: ItemsViewModel
    var onImprimirqr: (Int) -> Void
    
    var body: some View {
        
        ScrollView {
            GridItems(
                onImprimirqr: {id in onImprimirqr(id)}
                    )
                        .padding(.horizontal, 16)
                        .padding(.top, 12)   // respiro bajo la barra
                }
                .scrollIndicators(.hidden)

                // Barra “liquid glass” fija arriba
                .safeAreaInset(edge: .top) {
                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                            .font(.system(size: 18))

                        TextField("Buscar", text: $itemsvm.busqueda)
                            .textFieldStyle(.plain)
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial, in: Capsule())
                    .overlay(Capsule().stroke(.black.opacity(0.25), lineWidth: 1))
                    .shadow(radius: 2)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                }// 1) Cargar una sola vez al entrar
                .task {
                    print("cargando items...")
                    await itemsvm.getItems()
                }
//
//                // 2) Reconsultar cuando cambie la búsqueda (con debounce ligero)
//                .task(id: itemsvm.busqueda) {
//                    // opcional: pequeño delay para no pegar al escribir
//                    try? await Task.sleep(nanoseconds: 300_000_000) // 300ms
//                    await itemsvm.search()
//                }
//
//                // 3) Pull-to-refresh
//                .refreshable {
//                    await itemsvm.load(force: true)
//                }
        }
    }


#Preview {
    ItemsView( onImprimirqr: {_ in }).environmentObject(ItemsViewModel())
}
