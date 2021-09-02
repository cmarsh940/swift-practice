//
//  ContentView.swift
//  ViewModifiers_Practice
//
//  Created by Cam on 9/1/21.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
    }
}

extension View {
    func withDefaultButtonFormatting(backgroundColor: Color = .blue) -> some View {
        modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello World!")
                .font(.headline)
                .modifier(DefaultButtonViewModifier(backgroundColor: .green))
//                .foregroundColor(.white)
//                .frame(height: 55)
//                .frame(maxWidth: .infinity)
//                .background(Color.blue)
//                .cornerRadius(10)
//                .shadow(radius: 10)
//                .padding()
            
            Text("Hello Everyone!")
                .font(.subheadline)
                .withDefaultButtonFormatting(backgroundColor: .orange)
            
            Text("Hello!!!")
                .font(.title)
                .withDefaultButtonFormatting()

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
