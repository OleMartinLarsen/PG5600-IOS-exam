//
//  ViewController.swift
//  PG5600_eksamen
//
//  Created by Ole Martin Larsen on 24/11/2018.
//  Copyright © 2018 Høyskolen Kristiania. All rights reserved.
//

import UIKit

struct Root: Decodable {
    let count: Int
    let next: Int?
    let previous: Int?
    let results: [Film]
}

struct Film: Decodable {
    let title: String?
    let director: String?
}

class FilmListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var films = [Film]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        let jsonUrl = "https://swapi.co/api/films/"

        guard let url = URL(string: jsonUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in

            guard let data = data else { return }
            
            do {
                let films = try JSONDecoder().decode(Root.self, from: data)
                self.films = films.results
                for film in self.films{
                    print(film.title ?? String())
                }
                
            } catch let jsonError {
                print("Error serializing json:", jsonError)
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

