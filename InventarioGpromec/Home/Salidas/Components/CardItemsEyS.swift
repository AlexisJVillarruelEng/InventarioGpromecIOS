//
//  CardItemsEyS.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 24/09/25.
//

import SwiftUI

struct CardItemsEyS: View {
    var itemscards: TallerObrasCardResponse.Items
    
    var body: some View {
        
        HStack{
            AsyncImage(url: URL(string: itemscards.foto_url)).scaledToFit().frame(width: 44, height: 44).clipShape(Circle())
            VStack{
                Text("\(itemscards.id)").frame(maxWidth: .infinity, alignment: .leading)
                Text(itemscards.nombre).frame(maxWidth: .infinity, alignment: .leading).lineLimit(1)
            }.padding(.leading)
        }.frame(width: 170, height: 80)
        
        
    }
}


#Preview {
    CardItemsEyS(
        itemscards: .init(
            id: 101,
            nombre: "Taladro percutor XR-200",
            foto_url: "https://picsum.photos/seed/101/200",
            estado: "activo"
        )
    )
}
