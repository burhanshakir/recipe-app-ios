//
//  Constants.swift
//  Recipe App
//
//  Created by Burhanuddin Shakir on 18/07/19.
//  Copyright © 2019 burhan-shakir. All rights reserved.
//

import Foundation

let api_key = "2d7fa661b63bbbd4ddf4063bb8714398"


func sortRecipes(recipes : [Recipe]) -> [Recipe]
{
    
    // Sorting recipes by title
    
    let sortedRecipes = recipes.sorted(by: {$0.title < $1.title} )
    return sortedRecipes
}
