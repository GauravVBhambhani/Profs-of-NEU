//
//  ContentView.swift
//  Profs of NEU
//
//  Created by Gaurav Bhambhani on 9/21/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @State var search = ""
    @ObservedObject var obs = observer()


    var body: some View {
        NavigationView {
//            List(obs.profs) { prof in
            List {
                ForEach(self.obs.profs.filter{(self.search.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(self.search))}, id: \.id) { prof in
                    

                    NavigationLink(destination: ProfDetails(pData: prof)) {
                        
                        HStack {
                            AnimatedImage(url: URL(string: prof.image))
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                            
                            Text(prof.name)
                        }
                    }
                }
            }
            .navigationTitle("Profs of NEU")
            .searchable(text: $search)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

