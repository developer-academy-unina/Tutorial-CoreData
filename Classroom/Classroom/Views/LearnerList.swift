//
//  ContentView.swift
//  Classroom
//
//  Created by Stefania Zinno for the Developer Academy on 12/01/22.
//

import SwiftUI
import CoreData

struct LearnerList: View {
    
    @State var showModal: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Learner.name, ascending: true)],
        animation: .default)
    private var learners: FetchedResults<Learner>
    
    
    var body: some View {
        NavigationView{
            List {
                ForEach(learners) { learner in
                    NavigationLink(destination: PresentMeView(learner: learner)) {
                        HStack {
                            Image("stefania_zinno")
                                .resizable()
                                .frame(width: 50, height: 50)
                            if let name = learner.name, let surname = learner.surname {
                                Text("\(name) \(surname)")
                            }
                            Spacer()
                        }
                    }
                }.onDelete(perform: deleteLearners)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem {
                    Button("Add") {
                        self.showModal.toggle()
                    }
                    .sheet(isPresented: $showModal, content: {
                        NewLearnerForm(showModal: $showModal)
                    })
                }
            }
            Text("Select an item")
        }.navigationTitle("Learners")
    }
    
    func deleteLearners(offsets: IndexSet) {
        offsets.map { learners[$0] }.forEach(viewContext.delete)
        PersistenceManager.shared.saveContext()
    }
}


struct LearnerList_Previews: PreviewProvider {
    static var previews: some View {
        LearnerList().environment(\.managedObjectContext, PersistenceManager.shared.container.viewContext)
    }
}
