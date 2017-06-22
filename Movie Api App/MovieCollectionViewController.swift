//
//  MovieCollectionViewController.swift
//  Movie Api App
//
//  Created by AKIL KUMAR THOTA on 6/22/17.
//  Copyright © 2017 Akil Kumar Thota. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class MovieCollectionViewController: UICollectionViewController {
    
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
                    self.collectionView!.reloadData()
                }
            }
        }
        
    }


    

   

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return movieList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        let movie = movieList[indexPath.row]
        cell.movieTitle.text = movie.movieTitle
        
        Movie.getImage(forCell: cell, movieObject: movie)
    
        
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
