//
//  ContentView.swift
//  SwiftUIPullToRefresh
//
//  Created by ramil on 08.11.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var posts = [
        NewsItem(id: 0, title: "Want the latest posts?", body: "Pull to refresh!")
    ]
    
    var body: some View {
        NavigationView {
            List(posts) { item in
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.headline)
                    Text(item.body)
                        .foregroundColor(.secondary)
                }
            }
            .refreshable {
                do {
                    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
                    let (data, _) = try await URLSession.shared.data(from: url)
                    posts = try JSONDecoder().decode([NewsItem].self, from: data)
                } catch {
                    posts = []
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct NewsItem: Decodable, Identifiable {
    let id: Int
    let title: String
    let body: String
}
