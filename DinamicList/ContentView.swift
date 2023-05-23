//
//  ContentView.swift
//  DinamicList
//
//  Created by Claudio Tendean on 23/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var data = ItemModel()
    
    var body: some View {
        NavigationView {
            Home().environmentObject(data)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Home : View {
    
    //    @State var newTitle : String = ""
    @EnvironmentObject var data : ItemModel
    @State private var editMode = EditMode.inactive
    
    var body: some View {
        VStack {
            HStack{
                TextField("Enter title....", text: $data.newTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                
                // Button Pluss
                addButton
            }.padding(.horizontal)
            
            // Display List
            List {
                ForEach(Array(data.items.enumerated()), id:\.offset){offset, item in
                    NavigationLink(destination: DetailView(item: item, index: offset)) {
                        Text(item.title)
                    }
                }
                .onDelete(perform: data.onDelete)
                .onMove(perform: data.onMove)
            }
        }
        .navigationBarTitle("List")
        .navigationBarItems(leading: EditButton())
        .environment(\.editMode, $editMode)
    }
    
    // Button
    private var addButton : some View {
        switch editMode {
        case .inactive:
            return AnyView(Button(action: {self.data.onAdd(title: self.data.newTitle)}){
                HStack{
                    Image(systemName: "plus")
                }
                .padding()
                .background(Color.orange)
                .foregroundColor(Color.white)
                .cornerRadius(5)
            })
        default :
            return AnyView(EmptyView())
        }
    }
    
}

struct DetailView : View {
    
    @EnvironmentObject var data : ItemModel
    
    // State New title
    @State var newTitleValue : String = ""
    
    // Props data
    var item : Item
    
    // Position
    let index : Int
    
    var body: some View {
        VStack(alignment: .leading) {
            // Edit Data
            TextField("Person name", text: $newTitleValue)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onAppear {
                    self.newTitleValue = self.item.title
                }
            
            HStack {
                Button(action: {
                    self.data.onUpdate(index: self.index, title: self.newTitleValue)
                }) {
                    Text("Update")
                }
                .padding()
                .background(Color.green)
                .cornerRadius(5)
                .foregroundColor(Color.white)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .navigationBarTitle("Details")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
