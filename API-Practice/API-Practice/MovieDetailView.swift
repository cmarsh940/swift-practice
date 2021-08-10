//
//  MovieDetailView.swift
//  API-Practice
//
//  Created by Cam on 8/9/21.
//

import SwiftUI


let BASE_IMAGE_URL = "https://image.tmdb.org/t/p/original/"

extension String {
    func load() -> UIImage {
        do {
            guard let url = URL(string: self) else { return UIImage() }
            let data: Data = try Data(contentsOf: url)
            return UIImage(data: data) ?? UIImage()
        } catch {
//            
        }
        return UIImage()
    }
}

struct MovieDetails : View {
    var movie: Movie
    var body: some View {
        VStack {
            Image(uiImage: "\(BASE_IMAGE_URL)\(movie.poster_path)".load())
                .resizable()
                .frame(width: UIScreen.main.bounds.height/8*3, height: UIScreen.main.bounds.height/2)
                .padding()
            HStack {
                Text("Description").foregroundColor(.gray)
                Spacer()
            }
            Text(movie.overview).lineLimit(nil)
            Spacer()
        }.navigationBarTitle(Text(movie.title), displayMode: .inline)
            .padding()
    }
}
