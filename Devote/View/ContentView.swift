//
//  ContentView.swift
//  Devote
//
//  Created by Abiodun Osagie on 17/03/2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTY
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State var task: String = ""
    @State private var showNewTaskItem: Bool = false
    
    // MARK: - FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
  

    // MARK: - DELETE ITEM FUNCTION to the CoreData
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: - BODY
    var body: some View {
            NavigationView {
                // MARK: - MAIN VIEW
                ZStack {
                    VStack {
                    
                        // MARK: - HEADER
                        HStack(spacing: 10) {
                            // TITLE
                            Text("Devote")
                                .font(.system(.largeTitle, design: .rounded))
                                .fontWeight(.heavy)
                                .padding(.leading, 4)
                            
                            Spacer()
                            
                            // EIDT BUTTON
                            EditButton()
                                .font(
                                    .system(
                                        size: 16,
                                        weight: .semibold,
                                        design: .rounded
                                    )
                                )
                                .padding(.horizontal, 10)
                                .frame(minWidth: 70, minHeight: 24)
                                .background(
                                    Capsule().stroke(Color.white, lineWidth: 2)
                                )
                            // APPEARANCE BUTTON
                            Button {
                                // TOGGLE APPEARANCE
                                isDarkMode.toggle()
                            } label: {
                                Image(systemName: isDarkMode ? "sun.max" : "moon.circle")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .font(.system(.title, design: .rounded))
                            }

                        } //: HSTACK
                        .padding()
                        .foregroundStyle(.white)
                         Spacer(minLength: 40)
                        // MARK: - NEW TASK BUTTON
                        Button(action: {showNewTaskItem = true}) {
                            Text("New Task")
                                .font(
                                    .system(
                                        size: 20,
                                        weight: .semibold,
                                        design: .rounded
                                    )
                                )
                            Image(systemName: "plus.circle")
                                .font(
                                    .system(
                                        size: 20,
                                        weight: .semibold,
                                        design: .rounded
                                    )
                                )
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                        .foregroundStyle(.white)
                        .background(Color.blue)
                        .clipShape(Capsule())
                        // MARK: - TASKS
                        List {
                            ForEach(items) { item in
                                ListRowItemView(item: item)
                            }
                            .onDelete(perform: deleteItems)
                        } //: LIST
                        .listStyle(InsetGroupedListStyle())
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                        .frame(maxWidth: 640)
                    }//: VSTACK
                    .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
                    .transition(.move(edge: .bottom))
                    .animation(.easeOut(duration: 0.5))
                    
                    // MARK: -  NEW TASK ITEM
                    
                    if showNewTaskItem {
                        BlankView(
                            backgroundColor: isDarkMode ? Color.black : Color.white,
                            backgroundOpacity: isDarkMode ? 0.3 : 0.1
                        )
                            .onTapGesture {
                                withAnimation {
                                    showNewTaskItem = false
                                }
                            }
                        NewTaskItemView(isShowing: $showNewTaskItem)
                    }
                    }//: ZSTACK
                     .onAppear() {
                         UITableView.appearance().backgroundColor = UIColor.clear
                }
                .navigationBarTitle("Daily Task", displayMode: .large )
                .navigationBarHidden(true)
                .background(BackgroundImageView()
                .blur(radius: showNewTaskItem ? 8.0 : 0, opaque:false)
                )
                .background(backgroundGradient.ignoresSafeArea(.all))
            } //: NAVIGATION
            .navigationViewStyle(StackNavigationViewStyle())
            
        }

}



// MARK: - PREVIEW
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
