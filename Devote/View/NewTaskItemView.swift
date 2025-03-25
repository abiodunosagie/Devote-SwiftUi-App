//
//  NewTaskItemView.swift
//  Devote
//
//  Created by Abiodun Osagie on 19/03/2025.
//

import SwiftUI

struct NewTaskItemView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) private var viewContext
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State private var task: String = ""
    @Binding var isShowing: Bool
    // Computed property
    private  var isButtonDisabled: Bool {
        task.isEmpty
    }
    // MARK: - FUNCTIONS
    
    // MARK: - ADD ITEMS FUNCTION to the CoreData
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()

            do {
                try viewContext.save()
            } catch {
               
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            task = ""
            hideKeyboard()
            isShowing = false 
        }
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 16) {
                TextField("New Task", text: $task)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .padding()
                    .background(
                        isDarkMode ? Color(
                            UIColor.tertiarySystemBackground
                        ) : Color(UIColor.secondarySystemBackground)
                    )
                    .clipShape(.rect(cornerRadius: 10))
                
                Button {
                    addItem()
                } label: {
                    Spacer()
                    Text("Save".uppercased())
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                    Spacer()
                }
                .disabled(isButtonDisabled)
                .padding()
                .foregroundStyle(.white)
                .background(isButtonDisabled ? Color.gray : Color.pink)
                .clipShape(.rect(cornerRadius: 10))

            }//: VSTACK
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(
                isDarkMode ? Color(UIColor.secondarySystemBackground) :  Color.white
            )
            .clipShape(.rect(cornerRadius: 16))
            .shadow(
                color: Color(red: 0, green: 0, blue: 0, opacity: 0.65),
                radius: 24
            )
            .frame(maxWidth: 640)
        }//: VSTACK
        .padding()
    }
}
// MARK: - PREVIEWS
#Preview {
    NewTaskItemView(isShowing: .constant(true))
        .background(Color.gray.edgesIgnoringSafeArea(.all))
}
