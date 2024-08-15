//
//  ContentView.swift
//  TGTR
//
//  Created by Elin.Andersson on 2024-08-14.
//


import SwiftUI
import FirebaseCore
//import FirebaseFirestore
//import FirebaseMessaging

struct ContentView: View {
    @State private var selectedAvatar: Image?
    @State private var selectedImage: Image?
   // @StateObject private var viewModel = ViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if let image = selectedImage {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .padding()
                } else if let avatar = selectedAvatar {
                    avatar
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding()
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .foregroundColor(.gray)
                        .padding()
                }

                NavigationLink(destination: ChildProfileView(selectedAvatar: $selectedAvatar, selectedImage: $selectedImage)
                                .navigationBarTitle("Barnprofil", displayMode: .inline)) {
                    Text("Profil för barn")
                        .padding()
                }

                NavigationLink(destination: VitaminScheduleView()
                                .navigationBarTitle("D-Vitamin Schema", displayMode: .inline)) {
                    Text("D-Vitamin Schema")
                        .padding()
                }

                NavigationLink(destination: CalendarView()
                                .navigationBarTitle("Kalender", displayMode: .inline)) {
                    Text("Kalender")
                        .padding()
                }
            }
            .navigationBarTitle("DVS")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                loadSelectedImageOrAvatar()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func loadSelectedImageOrAvatar() {
        if let avatarName = UserDefaults.standard.string(forKey: "selectedAvatar") {
            selectedAvatar = Image(avatarName)
        } else if let imageData = UserDefaults.standard.data(forKey: "selectedImage"), let uiImage = UIImage(data: imageData) {
            selectedImage = Image(uiImage: uiImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



/*import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                    } label: {
                        Text(item.timestamp!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
*/
