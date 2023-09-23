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
    
    @State private var showContributeAlert = false
    
    var body: some View {
        NavigationView {
            //            List(obs.profs) { prof in
            List {
                ForEach(self.obs.profs
                    .filter{(self.search.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(self.search))
                    }, id: \.id) { prof in
                        
                        NavigationLink(destination: ProfDetails(viewModel: ProfDetailsViewModel(profData: prof), pData: prof)) {
                            
                            HStack {
                                
                                if let url = URL(string: prof.image), !url.absoluteString.isEmpty {
                                    AnimatedImage(url: url)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                }
                                else {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                }
                                Text(prof.name)
                            }
                        }
                    }
            }
            .navigationTitle("Profs of NEU")
            //            .toolbar {
            //                Button("I want to contribute"){
            //                    showContributeAlert = true
            //                }
            //                .alert(isPresented: $showContributeAlert) {
            //                    Alert(title: Text("Thank you for your time!"), message: Text("To contribute email your comments to example@gmail.com. We will censor your comments and publish them. We promise we're not biased."), dismissButton: .default(Text("Got it!")))
            //                }
            //            }
            .searchable(text: $search)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

