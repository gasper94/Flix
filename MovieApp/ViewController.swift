//
//  ViewController.swift
//  MovieApp
//
//  Created by Ulises Martinez on 2/4/19.
//  Copyright © 2019 Ulises Martinez. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDataSource,
UITableViewDelegate{
    
    // Dictionary to hold ..
    var movies = [[String: Any]]()
    
    @IBOutlet weak var tableView: UITableView!

    @IBAction func view(_ sender: Any) {
        print("hi")
    }
    
    
    
    /*
    @IBAction func viewButton(_ sender: Any) {
        
        print("hi")
        
        //performSegue(withIdentifier: "viewSegue", sender: nil)
    }*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.movies = dataDictionary["results"] as! [[String : Any]]
                
                self.tableView.reloadData()
                //print(dataDictionary)
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Reusable custome cell - MovieCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCells") as! MovieCell
        
        // movies
        let movie = movies[indexPath.row]
        
        // Movie Title
        let title = movie["title"] as! String
        
        // Movie Sipnosis
        let synopsis = movie["overview"] as! String
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath )
        
        
        cell.posterView.af_setImage(withURL: posterUrl!)
        
        // Title Text Label
        cell.titleLabel.text = title
        
        // Synopsis Text Label
        cell.synopsis.text = synopsis
        
        
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print("hello")
        
        // Find the Selected Movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        // Pass the data related to the selected movie.
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie
        
        
        // deSelect row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    
}

