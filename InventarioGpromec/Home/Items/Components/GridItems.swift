//
//  GridItems.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 22/09/25.
//

import SwiftUI

struct GridItems: View {
    @EnvironmentObject var itemsvm: ItemsViewModel
    var onImprimirqr: (Int) -> Void
    
    var body: some View {
        
        LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 180), spacing: 5), count: 2), spacing: 20) {
            ForEach(itemsvm.itemscards) { item in
                NavigationLink(value: item.id) {
                    CardItemView(item: item,
                                 onImprimirqr: { id in
                        onImprimirqr(id)
                    }
                    )
                }
            }
        }.padding(.vertical)
        
        
    }
}

#Preview {
    GridItems(onImprimirqr: {_ in }).environmentObject(ItemsViewModel())
}
