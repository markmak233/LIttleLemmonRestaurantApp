//
//  Header.swift
//  Restaurant
//
//  Created by marco mai on 2024-01-25.
//

import SwiftUI

struct Header: View {
    @State var isLoggedIn = false
    
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Text("Little Lemon").frame(maxWidth:.infinity, alignment: .leading).font(.TittleFont()).foregroundColor(.color3)
                    Text("Chicargo").frame(maxWidth:.infinity, alignment: .leading).font(.subTitleFont()).foregroundColor(.color8)
                    Spacer(minLength: 5)
                    Text("best restuarant...").frame(maxWidth:.infinity, alignment: .leading).font(.PargTextFont()).foregroundColor(.color8)
                }.padding()
                
                Image("Hero image").resizable().aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 120,maxHeight:120).cornerRadius(16).clipShape(Rectangle())
            }.padding(.horizontal)
        }.frame(maxHeight: 170).background(.color1)
     
    
    }
}

#Preview {
    Header()
}
