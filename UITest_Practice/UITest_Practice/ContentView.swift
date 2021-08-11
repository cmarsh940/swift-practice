//
//  ContentView.swift
//  UITest_Practice
//
//  Created by Cam on 8/11/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var taskName: String = ""
    @State private var tasks = [String]()
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter Task:", text: $taskName)
                        .accessibility(identifier: "taskNameTextField")
                    
                    Button("Add Task"){
                        self.tasks.append(self.taskName)
                    }.padding(10)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                    .accessibility(identifier: "addTaskButton")
                }
                List(self.tasks, id: \.self) { name in
                    Text("\(name)")
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Your Tasks")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
