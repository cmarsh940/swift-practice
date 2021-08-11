//
//  ContentView.swift
//  UnitTest_Practice
//
//  Created by Cam on 8/11/21.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
            Text("Login")
            TextField("username", text: $loginViewModel.username)
                .padding(5)
                .border(
                    Color.gray,
                    width: 0.5
                )
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                .padding(10)
            SecureField("password", text: $loginViewModel.password)
                .padding(5)
                .border(
                    Color.gray,
                    width: 0.5
                )
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                .padding(10)
            Button {
                loginViewModel.login()
            } label: {
                Label("Login", systemImage: "key.fill")
                    .padding(10)
            }
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 100, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .border(Color.blue)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
