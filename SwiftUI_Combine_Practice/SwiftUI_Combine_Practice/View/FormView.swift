//
//  FormView.swift
//  SwiftUI_Combine_Practice
//
//  Created by Cam on 8/30/21.
//

import SwiftUI

struct FormView: View {
    @StateObject private var vm = FormViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Username")) {
                        TextField("Username", text: $vm.username)
                            .autocapitalization(.none)
                    }
                    Section(header: Text("Password"), footer: Text(vm.inlineErrorForPassword)
                                .foregroundColor(.red)) {
                        SecureField("Password", text: $vm.password)
                        SecureField("Confirm Password", text: $vm.confirmPassword)
                    }
                }
                Button(action: {
                    print("touched")
                }, label: {
                    Text("Continue")
                })
                .frame(width: 250, height: 60)
                .cornerRadius(10)
                .foregroundColor(.white)
                .background(Color.blue)
                .padding()
                .disabled(!vm.isValid)
            }
            .navigationTitle("Sign Up")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
