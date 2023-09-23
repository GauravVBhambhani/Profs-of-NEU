//
//  ProfDetails.swift
//  Profs of NEU
//
//  Created by Gaurav Bhambhani on 9/21/23.


import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct ProfDetails: View {
    
    @ObservedObject var viewModel: ProfDetailsViewModel
    
    let pData: profData
    
    @State var commentBox: String = ""
    
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                VStack {
                    Text(pData.name)
                        .font(.title)
                    
                    if let url = URL(string: pData.image), !url.absoluteString.isEmpty {
                        AnimatedImage(url: url)
                            .resizable()
                            .frame(height: 300)
                            .padding(.horizontal)
                            .cornerRadius(20)
                            .clipShape(Circle())
                    }
                    
                    else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(height: 300)
                            .padding(.horizontal)
                    }
                }
                
                VStack {
                    Text("ABOUT")
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(.gray)
                        .padding(.leading)
                        .padding(.trailing)
                    
                    Text(pData.about)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .padding(.trailing)
                        .multilineTextAlignment(.leading)
                }
                
                VStack {
                    Text("SUBJECT(S)")
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(.gray)
                        .padding(.leading)
                        .padding(.trailing)
                    
                    ForEach(pData.subjects, id: \.self) { subject in
                        HStack {
                            Image(systemName: "book.fill")
                                .padding(.bottom)
                                .padding(.leading)
                            Text(subject)
                                .padding(.bottom)
                                .lineLimit(nil)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                VStack {
                    Text("COMMENTS")
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(.gray)
                        .padding(.leading)
                        .padding(.trailing)
                    
                    ForEach(pData.comments, id: \.self) { comment in
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .padding(.bottom)
                                .padding(.leading)
                            
                            Text(comment)
                                .padding(.bottom)
                                .lineLimit(nil)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                VStack {
                    Text("ADD ANONYMOUS COMMENT")
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(.gray)
                        .padding(.leading)
                        .padding(.trailing)
                    
                    TextField("Write your comment here (Keep it civil :))", text: $commentBox, axis: .vertical)
                        .lineLimit(5...7)
                        .padding()
                    
                    Button (action: {
                        
                        //                        showMessageSentAlert = true
                        addComment()
                    }, label: {
                        HStack {
                            Image(systemName: "paperplane.fill")
                            Text("Send")
                        }
                    })
                    .buttonStyle(.borderedProminent)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Comment Status"),
                            message: Text(alertMessage),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
            }
        }
        .font(.system(size: 18))
        .padding()
    }
    
    private func addComment() {
        viewModel.addComment(comment: commentBox) { success, errorMessage in
            if success {
                alertMessage = "Thank you for your comment! We'll review it shortly to ensure it meets our guidelines. If everything checks out, we'll publish it.\n\nRest assured, our review is impartial, focused on maintaining a respectful discourse, and not influenced by any biases. Thank you for understanding. "
            } else {
                alertMessage = "Error adding comment: \(errorMessage)"
            }
            showAlert = true
        }
        commentBox = ""
    }
}

class ProfDetailsViewModel: ObservableObject {
    private let db = Firestore.firestore()
    private let profData: profData
    
    init(profData: profData) {
        self.profData = profData
    }
    
    func addComment(comment: String, completion: @escaping (Bool, String) -> Void) {
        let commentData: [String: Any] = [
            "comment": comment,
            "timestamp": FieldValue.serverTimestamp()
        ]
        
        // Add comment to Firestore
        db.collection("comments").document(profData.name).collection("comms").addDocument(data: commentData) { error in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                completion(true, "")
            }
        }
    }
}

//struct ProfDetails_Previews: PreviewProvider {
//    static var previews: some View {
//
//        let dummyData = profData(
//            id: "Josie",
//            name: "Giuseppina \"Josie\" Cucciniello",
////            name: "Vishal Chawla",
//            image: "https://media.licdn.com/dms/image/D4E03AQFXihHa5PFpcg/profile-displayphoto-shrink_400_400/0/1694521983967?e=1700697600&v=beta&t=JuCPUBqJO5LRhUMw2468kt1Zd6fBDZgk0y7kc2b7BHM",
////            image:"",
//            about: """
//            Josie is an Adjunct Faculty who teaches ENCP6000 to graduate students.
//
//            She is really proactive about Career Management and building Employer Partnerships for the University.
//            """,
//            subjects: ["ENCP6000", "Career Advisor"],
//            comments: ["one of the best", "Strict but likable"]
//        )
//
//        ProfDetails(pData: dummyData)
//    }
//}
