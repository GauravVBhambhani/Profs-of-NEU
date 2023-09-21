//
//  ProfDetails.swift
//  Profs of NEU
//
//  Created by Gaurav Bhambhani on 9/21/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfDetails: View {
    
    let pData: profData
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text(pData.name)
                    .font(.title)
                
                AnimatedImage(url: URL(string: pData.image))
                    .resizable()
                    .frame(height: geo.size.height-100)
                    .padding(.horizontal, 15)
                    .cornerRadius(20)
            }
            
        }
    }
}
//
//struct ProfDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfDetails()
//    }
//}
