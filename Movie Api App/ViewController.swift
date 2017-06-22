//
//  ViewController.swift
//  Movie Api App
//
//  Created by AKIL KUMAR THOTA on 6/22/17.
//  Copyright © 2017 Akil Kumar Thota. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var movieList = [Movie]()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
  
    }
    
    
    func loadData() {
        
        Movie.nowPlaying { [unowned self](success, moviesArray:[Movie]?) in
            
            if success {
                self.movieList = moviesArray!
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = movieList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = movie.movieTitle
        cell.detailTextLabel?.text = movie.movieDescription
        
        Movie.getImage(forCell: cell, movieObject: movie)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("")
    }
    
    
    
    
    
    
    
    

  


}

