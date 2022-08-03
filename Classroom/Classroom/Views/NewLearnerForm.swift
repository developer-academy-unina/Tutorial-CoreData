//
//  NewLearnerForm.swift
//  Classroom
//
//  Created by Luca Palmese and Stefania Zinno for the Developer Academy on 12/01/22.
//

import SwiftUI

struct NewLearnerForm: View {
    
    @Binding var showModal: Bool
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var name: String = ""
    @State var surname: String = ""
    @State var shortBio: String = "Lorem Ipsum Bio so you don't have to copy and paste any long text"
    @State var age: Int?
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name: ", text: $name)
                    .disableAutocorrection(true)
                TextField("Surname: ", text: $surname)
                    .disableAutocorrection(true)
                TextField("Age: ", value: $age, format: .number)
                TextEditor(text: $shortBio)
            }
            .navigationBarTitle("Add Learner")
            .navigationBarItems(trailing: Button("Done", action: {
                showModal.toggle()
                if let age = age {
                    addNewLerner(name: name, surname: surname, age: age, shortBio: shortBio)
                }
            }))
        }
    }
    
    func addNewLerner(name: String, surname: String, age: Int, shortBio: String) {
        let newLearner = Learner(context: viewContext)
        newLearner.id = UUID()
        newLearner.name = name
        newLearner.surname = surname
        newLearner.shortBio = shortBio
        newLearner.age = Int64(age)
        
        PersistenceManager.shared.saveContext()
    }
}


struct NewLearnerForm_Previews: PreviewProvider {
    static var previews: some View {
        NewLearnerForm(showModal: .constant(false))
    }
}
