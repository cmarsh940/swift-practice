//
//  APIService.swift
//  API-Practice
//
//  Created by Cam on 8/9/21.
//

import Foundation


public final class APIService: ObservableObject {
    private let API_KEY = ""
    private let API_url = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key="
    @Published var movies = MovieList(results: [])
    @Published var loading = false
    
    init() {
        loading = true
        loadDataNormal()
    }
    
    private func loadDataNormal() {
        guard let url = URL(string: "\(API_url)\(API_KEY)") else { return }
        URLSession.shared.dataTask(with: url){ (data, _, _) in
            guard let data = data else { return }
            let movies = try! JSONDecoder().decode(MovieList.self, from: data)
            DispatchQueue.main.async {
                self.movies = movies
                self.loading = false
            }
        }.resume()
    }
}
