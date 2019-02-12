//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Ulises Martinez on 2/11/19.
//  Copyright © 2019 Ulises Martinez. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {


    var movie: [String:Any]!
    
    @IBOutlet weak var backDropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var sypnosisView: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //print(movie["title"])
        
        tittleLabel.text = movie["title"] as! String
        tittleLabel.sizeToFit()
        
        sypnosisView.text = movie["overview"] as! String
        sypnosisView.sizeToFit()

        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath )
        
        posterView.af_setImage(withURL: posterUrl!)
        
        
        // back drop view
        let backDropPath = movie["backdrop_path"] as! String
        let backDropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backDropPath)
        
        backDropView.af_setImage(withURL: backDropUrl!)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
