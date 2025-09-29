//
//  ContentView.swift
//  Budgeteer
//
//  Created by Izel on 9/26/25.
//

import Observation
import SwiftUI


struct ExpenseItem: Identifiable{
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]()
}

struct ContentView: View {
    @State private var expenses = Expenses()
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("Budgeteer")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    let expense = ExpenseItem(name: "Test Item", type: "Personal", amount: 5)
                    expenses.items.append(expense)
                }
            }
        }
        
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}


#Preview {
    ContentView()
}


// If you use @State with a struct, will update auto when a value changes

// @State + class then you must mark that class with @Observable if you want SwiftUI to watch its contents for changes.

//@Observable tells SwiftUI to watch each individual property inside the class for changes, and reload any view that relies on a property when it changes.
