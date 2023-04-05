//
//  ContentView.swift
//  Apex Predators
//
//  Created by Raja Adeel Ahmed on 4/5/23.
//

import SwiftUI

struct ContentView: View {
    var apController = PredatorController()
    @State var sortAlphabetic = true
    @State var currentFilter = "All"
    var body: some View {
        apController.filterBy(type: currentFilter)
        sortAlphabetic ? apController.sortByAphabeticOrder() : apController.sortByMovieAppearance()
        return NavigationView  {
            List {
                ForEach(apController.apexPredators) {predator in
                    NavigationLink(destination: PredatorDetailsView(predator: predator)) {
                        
                        PredatorRow(predator: predator)
                    }
                }
            }
            .navigationTitle("Apex Pregators ")
            .toolbar {
                ToolbarItem (placement: .navigationBarLeading) {
                    Button {
                        withAnimation {
                            sortAlphabetic.toggle()
                        }
                    } label: {
                        sortAlphabetic ? Image(systemName: "textformat") :Image(systemName: "film")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentFilter.animation()) {
                            ForEach(apController.typeFilters, id:\.self) { type in
                                HStack {
                                    Text(type)
                                    Spacer()
                                    Image(systemName: apController.typeIcon(for: type))
                                }
                                
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
