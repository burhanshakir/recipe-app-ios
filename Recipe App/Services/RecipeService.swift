//
//  RecipeService.swift
//  Recipe App
//
//  Created by Burhanuddin Shakir on 18/07/19.
//  Copyright © 2019 burhan-shakir. All rights reserved.
//

import Foundation


// Class to call Food2Fork API
class RecipeService
{
    // Singleton class
    static let instance = RecipeService()
    
    // recipe array to store results
    var recipes = [Recipe]()
    
    func getRecipes(handler:@escaping (_ status : Bool) ->())
    {
        let url = URL(string: "https://www.food2fork.com/api/search?key=\(api_key)")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if(error == nil)
            {
                let json = (try? JSONSerialization.jsonObject(with: data!, options: [])) as? [String:AnyObject]
                
                print(json ?? "Empty Data")
                
                let recipeDict = json!["recipes"] as! [Dictionary<String,AnyObject>]
                
                self.recipes.removeAll()
                
                for recipe in recipeDict
                {
                    // Converting each recipe to model
                    
                    let recipeModel = Recipe(publisher: recipe["publisher"] as! String?, title: recipe["title"] as! String?, image_url: recipe["image_url"] as! String?, social_rank: recipe["social_rank"] as! Int?, publisher_url: recipe["publisher_url"] as! String?)
                    
                    // Appending it to results array
                    self.recipes.append(recipeModel)
                }
                
                handler(true)
            }
            
                // Handling Failure
            else
            {
                handler(false)
            }
            

        }
        
        task.resume()
    
    }
    
}

