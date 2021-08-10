//
//  MovieRow.swift
//  API-Practice
//
//  Created by Cam on 8/9/21.
//

import SwiftUI

struct MovieRow : View {
    var movie: Movie
    
    var body: some View {
        HStack {
            Image(uiImage: "\(BASE_IMAGE_URL)\(movie.poster_path)".load())
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 120)
                .cornerRadius(4)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(movie.title)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                Text(movie.release_date)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Votes: \(movie.vote_count)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Popularity: \(movie.popularity)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            VStack{
                Text(movie.vote_average.format())
                    .padding()
                    .background(Color.orange)
                    .clipShape(Circle())
            }
        }.frame(height: 130)
    }
}

extension Float {
    func format() -> String {
        return String(format: "%.1f",self)
    }
}
