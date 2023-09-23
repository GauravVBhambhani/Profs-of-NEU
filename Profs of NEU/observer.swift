//
//  observer.swift
//  Profs of NEU
//
//  Created by Gaurav Bhambhani on 9/21/23.
//

import SwiftUI
import Firebase

class observer: ObservableObject {
    
    @Published var profs = [profData]()
    
    init() {
        let db = Firestore.firestore()
        db.collection("profs").getDocuments { (snap, err) in
            
            if err != nil {
                print(err?.localizedDescription as Any)
                return
            }
            
            for i in snap!.documents {
                let id = i.documentID
                let name = i.get("name") as! String
                let image = i.get("image") as! String
                let about = i.get("about") as! String
                let subjects = i.get("subjects") as! [String]
                let comments = i.get("comments") as! [String]
                
                // Create a profData instance and append it to the profs array
                let prof = profData(id: id, name: name, image: image, about: about, subjects: subjects, comments: comments)
                
                self.profs.append(prof)
            }            
        }
    }
}
