//
//  RecipeVC.swift
//  Recipe App
//
//  Created by Burhanuddin Shakir on 18/07/19.
//  Copyright © 2019 burhan-shakir. All rights reserved.
//

import UIKit

class RecipeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let recipeService = RecipeService.instance
    var recipes = [Recipe]()

    @IBOutlet weak var errorImg: UIImageView!
    @IBOutlet weak var recipeTable: UITableView!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // connection table to delegates
        recipeTable.delegate = self
        recipeTable.dataSource = self
        recipeTable.rowHeight = 350
        
        getRecipes()
        // Do any additional setup after loading the view.
    }
    
    @objc func getRecipes()
    {
        
        loader.isHidden = false
        loader.startAnimating()
        recipeService.getRecipes { (success) in
            
            
            if(success)
            {
                // Showing and hiding views
                DispatchQueue.main.async {
                    
                    self.recipeTable.isHidden = false
                    self.errorImg.isHidden = true
                    self.errorLbl.isHidden = true
                }
                

                // Adding recipes to array
                self.recipes = self.recipeService.recipes

                // Initiating sort button

                let sortBtn = UIBarButtonItem(image: UIImage(named: "sort-icon"), style: UIBarButtonItem.Style.done, target: self, action: #selector(self.sortPressed))

                self.navigationItem.rightBarButtonItem = sortBtn

                self.recipeTable.reloadData()
            }
            else
            {
                print("Could not get recipes")

                // Showing and hiding views
                self.recipeTable.isHidden = true
                self.errorImg.isHidden = false
                self.errorLbl.isHidden = false

                // Initialising refresh button

                let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.getRecipes))
                self.navigationItem.rightBarButtonItem = refresh



            }
            
            self.loader.isHidden = true
            self.loader.stopAnimating()


        }
        
    }
    
    // UITableView delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return recipeService.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let recipeCell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell") as? RecipeCell
        {
            
            if (recipes.count > 0)
            {
                let recipe = recipes[indexPath.row]
                
                // Sending recipes to table view cells
                recipeCell.updateViews(recipe: recipe)
                
                return recipeCell
            }
            
            return RecipeCell()
            
        }
        else
        {
            return RecipeCell()
        }
    }
    
    @objc
    func sortPressed()
    {
        recipes = sortRecipes(recipes: recipes)
        recipeTable.reloadData()
        
    }


}
