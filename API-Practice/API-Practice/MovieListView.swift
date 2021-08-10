//
//  MovieListView.swift
//  API-Practice
//
//  Created by Cam on 8/9/21.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject var apiService = APIService()
        var body: some View {
            NavigationView {
                VStack {
                    if apiService.loading {
                        Text("Loading ...")
                    } else {
                        List(apiService.movies.results) { movie in
                            NavigationLink(destination: MovieDetails(movie: movie)){
                                MovieRow(movie: movie)
                            }
                        }
                    }
                }
                .navigationBarTitle(Text("Movies"))
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
