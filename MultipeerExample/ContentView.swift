//
//  ContentView.swift
//  MultipeerExample
//
//  Created by Daud on 30/05/24.
//

import SwiftUI
import SwiftData
import UIKit

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var plants: [Plant]
    
    @StateObject var multipeerSession: ExampleMultipeerSession = ExampleMultipeerSession(username: UIDevice.current.name)

    @State private var isSheetPresented = false
    
    @State private var txt: String = "Nothing Shown Here"
    
    var body: some View {
        NavigationStack {
            List {
                Section{
                    Button("Delete All") {
                        for plant in plants {
                            modelContext.delete(plant)
                        }
                    }.foregroundColor(.red)
                }
                
                Section {
                    ForEach(plants) { plant in
                        VStack(alignment: .leading) {
                            Text(plant.name)
                            Text(plant.desc)
                            Text(plant.location)
                        }
                    }
                }
            }
            .navigationBarTitle("Plantdex", displayMode: .automatic)
            .navigationBarItems(
                trailing: Button(action: {
                    self.isSheetPresented = true
                }) {
                    Image(systemName: "square.and.arrow.up").foregroundColor(.green)
                }.popover(isPresented: $isSheetPresented) {
                    NavigationView {
                        ListPairView(isSheetPresented: $isSheetPresented).environmentObject(multipeerSession)
                    }
                }
            )
        }
        .onChange(of: multipeerSession.receivedPlant) {
            for plant in listOfPlants {
                if(plant.name == multipeerSession.receivedPlant.name) {
                    modelContext.insert(plant)
                }
            }
        }
    }
}
