//
//  ContentView.swift
//  Budgeteer
//
//  Created by Izel on 9/26/25.
//

import Observation
import SwiftUI


@Observable
class User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
    }
    
}

struct ContentView: View {
    @State private var user = User()
    @State private var showingSheet = false
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(numbers, id: \.self){
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
            }
        }.toolbar {
            EditButton()
        }
        
        Button("Add number") {
            numbers.append(currentNumber)
            currentNumber += 1
        }
        Spacer()
        
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView()
        }
    }
    
    func removeRows(at offset: IndexSet) {
        numbers.remove(atOffsets: offset)
    }
}

#Preview {
    ContentView()
}


// If you use @State with a struct, will update auto when a value changes

// @State + class then you must mark that class with @Observable if you want SwiftUI to watch its contents for changes.

//@Observable tells SwiftUI to watch each individual property inside the class for changes, and reload any view that relies on a property when it changes.
