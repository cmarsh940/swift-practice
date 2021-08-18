//
//  FruitListView.swift
//  CoreData_Practice
//
//  Created by Cam on 8/18/21.
//

import SwiftUI

struct FruitListView: View {
    
    @ObservedObject var viewModel = CoreDataViewModel()
    @State var textFieldText: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Add Fruit", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button(action: {
                    guard !textFieldText.isEmpty else { return }
                    viewModel.addFruit(text: textFieldText)
                    textFieldText = ""
                    
                }, label: {
                    Text("Add Fruit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)))
                        .cornerRadius(10)
                    
                })
                .padding(.horizontal)
                
                
                List {
                    ForEach(viewModel.savedEntities) { entity in
                        Text(entity.name ?? "No Name")
                            .onTapGesture {
                                viewModel.updateFruit(entity: entity)
                            }
                    }
                    .onDelete(perform: viewModel.deleteFruite)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Fruits")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FruitListView()
    }
}
