//
//  Toolbar.swift
//  InventarioGpromec
//
//  Created by Alexis Villarruel on 21/09/25.
//

import SwiftUI

struct Toolbar: View {
    var usuario: String?
    var rol: String?
    var foto_url: String?
    var onlogout: () -> Void
    //entra envirioment de loginviewmodel
    
    var body: some View {
        HStack(alignment: .center,){
            
            Button(action:{
                onlogout()
            }){Image(systemName: "power.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.gray)
                    .padding(.leading, 16)
            }
            Spacer()
            Text(usuario ?? "no encontrado")
            Spacer()
            Text(rol ?? "no encontrado")
            Spacer().frame(width: 50)
            AsyncImage(url: URL(string: foto_url ?? "")) { image in
                            image.resizable().scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .padding(.trailing, 16)
            
        }.frame(maxWidth: .infinity)
    }
}

#Preview {
    Toolbar(onlogout: {})
}
