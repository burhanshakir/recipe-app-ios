//
//  RecipeCell.swift
//  Recipe App
//
//  Created by Burhanuddin Shakir on 19/07/19.
//  Copyright © 2019 burhan-shakir. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell
{
    @IBOutlet weak var publisherImage: UIImageView!
    @IBOutlet weak var publisherName: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var socialRank: UILabel!
    
    func updateViews(recipe : Recipe)
    {
        publisherName.text = recipe.publisher
        recipeName.text = recipe.title
        socialRank.text = String(recipe.social_rank)
        // Getting the images
        
//        Alamofire.request(recipe.image_url).responseImage { response in
//
//            if let image = response.result.value {
//
//                self.recipeImage.image = image
//            }
//        }
        
        let imageTask = URLSession.shared.dataTask(with: URL(string: recipe.image_url)!) { (data, response, error) in
            
            if(error == nil)
            {
                DispatchQueue.main.async
                {
                    let loadedImage = UIImage(data: data!)
                    self.recipeImage.image = loadedImage
                }
            }
            
        }
        
        imageTask.resume()
        
        
        // Getting favicon
        
        let faviconURL = recipe.publisher_url + "/favicon.ico"
        let faviconTask = URLSession.shared.dataTask(with: URL(string: faviconURL)!) { (data, response, error) in
            
            if(error == nil)
            {
                DispatchQueue.main.async
                {
                    let loadedImage = UIImage(data: data!)
                    self.publisherImage.image = loadedImage
                }
            }
            
        }
        
        faviconTask.resume()
        
        
        
        
    }
}
