//
//  Movie.swift
//  Movie Api App
//
//  Created by AKIL KUMAR THOTA on 6/22/17.
//  Copyright © 2017 Akil Kumar Thota. All rights reserved.
//

import UIKit


struct Movie {
    
    var movieTitle:String
    var movieImagePath:String
    var movieDescription:String
    
    
    private let imgBaseUrl = "https://image.tmdb.org/t/p/w500"
    
    
    
   private static func getData(completion:@escaping (_ success:Bool,_ object:AnyObject?)->()) {
       
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=e8ecc774b10dc268a907b27f51c36be8")
        let request = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            if error != nil {
                print("error occured")
                completion(false,nil)
            }else{
                
                if let data = data {
                    
                    let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    
                    if let json = jsonObject {
                        completion(true,json as AnyObject)
                    }
                }else{
                    completion(false,nil)
                }
                
            }
        }
        task.resume()
        
        
    }
    
    
    static func nowPlaying(completion:@escaping (_ success:Bool,_ movie:[Movie]?)->()) {
        
        Movie.getData { (success, object) in
            
            if success {
                var movieArray = [Movie]()
             
                if let movies = object?["results"] as? [Dictionary<String,Any>] {
                    
                    for movie in movies {
                        let movieName = movie["title"] as! String
                        let movieDescription = movie["overview"] as! String
                        
                        guard let posterPath = movie["poster_path"] as? String else {
                            continue
                        }
                        
                        let movie = Movie(movieTitle: movieName, movieImagePath: posterPath, movieDescription: movieDescription)
                        
                        movieArray.append(movie)
                    }
                    completion(true,movieArray)
                    
                }
                
            }else{
                completion(false,nil)
            }
        }
    }
    
    
    private static func getDocumentDirectory() -> String? {
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        guard let documents = path.first else {
            return nil
        }
        
        return documents
    }
    
    
    private static func checkForImageData(withMovieObject movie:Movie) -> String? {
        
        if let document = getDocumentDirectory() {
            
            let movieImagePath = document + "/\(movie.movieTitle)"
            
            let escapedImagePath = movieImagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            if FileManager.default.fileExists(atPath: escapedImagePath!) {
                return escapedImagePath
            }
        }
        
        return nil
    }
    
    
    static func getImage(forCell cell:AnyObject,movieObject movie:Movie) {
        
        if let imagePath = checkForImageData(withMovieObject: movie) {
            if let imageData = FileManager.default.contents(atPath: imagePath) {
                
                if cell is UITableViewCell {
                    
                    let myCell = cell as! UITableViewCell
                    myCell.imageView?.image = UIImage(data: imageData)
                    myCell.setNeedsLayout()
                    
                }else {
                    // this is for collectionViewCell
                    
                    let myCell = cell as? MovieCollectionViewCell
                    myCell?.movieImg.image = UIImage(data: imageData)
                    myCell?.setNeedsLayout()
                }
                
            }
        }else {
            // download and save it to disk part
            
            
            let imageFullPath = movie.imgBaseUrl + "\(movie.movieImagePath)"
            
            let imageUrl = URL(string: imageFullPath)
            
            DispatchQueue.global().async {
                
                let data = try? Data(contentsOf: imageUrl!)
                
                
                let filePath = getDocumentDirectory()! + "/\(movie.movieTitle)"
                
                let escapedImagePath = filePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                if FileManager.default.createFile(atPath: escapedImagePath!, contents: data!, attributes: nil) {
                    print("saved successfully")
                }else{
                    print("saving failed")
                }
                
                DispatchQueue.main.async {
                    
                    if cell is UITableViewCell {
                        
                        let myCell = cell as! UITableViewCell
                        myCell.imageView?.image = UIImage(data: data!)
                        myCell.setNeedsLayout()
                        
                    }else {
                        
                        
                        
                        // this is for collectionViewCell
                        
                        let myCell = cell as? MovieCollectionViewCell
                        myCell?.movieImg.image = UIImage(data: data!)
                        myCell?.setNeedsLayout()
  
                    }
                }
            }
            
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
