//
//  GoVC.swift
//  Recipe App
//
//  Created by Burhanuddin Shakir on 18/07/19.
//  Copyright © 2019 burhan-shakir. All rights reserved.
//

import UIKit

class GoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Changing color for status bar
        navigationController?.navigationBar.barStyle = .black
    }
    

    // IBAction for go button
    @IBAction func goBtnPressed(_ sender: Any)
    {
        performSegue(withIdentifier: "recipeControllerSegue", sender: self)
    }

}
