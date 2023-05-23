//
//  ItemModel.swift
//  DinamicList
//
//  Created by Claudio Tendean on 23/05/23.
//

import Foundation
import Combine

class ItemModel : ObservableObject {
    @Published var newTitle : String = ""
    @Published var items : [Item] = []
    
    func onAdd(title : String) {
        items.append(Item(title: title))
        self.newTitle = ""
    }
    
    func onDelete(offset : IndexSet) {
        items.remove(atOffsets: offset)
    }
    
    func onMove(source : IndexSet, destination : Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
    
    func onUpdate(index: Int, title: String) {
        items[index].title = title
    }
}
