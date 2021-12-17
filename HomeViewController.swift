//
//  ViewController.swift
//  Stats
//
//  Created by Asam Zaman on 12/3/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main Stats"
        view.backgroundColor = .systemBackground
        fetchData()
        
        //NAVID this creates a text field that we can have the data output to
        //this was intended to use for the different things we would print but it never wokred
        
        let myTextField: UITextField = UITextField(frame: CGRect(x: 0, y: 150, width: 300.00, height: 30.00));
        let myTextField2: UITextField = UITextField(frame: CGRect(x: 0, y: 250, width: 300.00, height: 30.00));
        let myTextField3: UITextField = UITextField(frame: CGRect(x: 0, y: 350, width: 300.00, height: 30.00));

        myTextField.placeholder = "Place holder text"
        myTextField2.placeholder = "Place holder text"
        myTextField3.placeholder = "Place holder text"
        myTextField.text = "Favorite Songs:"
        myTextField2.text = "Favorite Artist:"
        myTextField3.text = "Favorite Genre:"
         myTextField.borderStyle = UITextField.BorderStyle.line
        myTextField.backgroundColor = UIColor.white
        myTextField.textColor = UIColor.blue
        myTextField2.borderStyle = UITextField.BorderStyle.line
       myTextField2.backgroundColor = UIColor.white
       myTextField2.textColor = UIColor.blue
        myTextField3.borderStyle = UITextField.BorderStyle.line
       myTextField3.backgroundColor = UIColor.white
       myTextField3.textColor = UIColor.blue
        self.view.addSubview(myTextField)
        self.view.addSubview(myTextField2)
        self.view.addSubview(myTextField3)
        
    }
    //function to fetch data which doesn't fetch anything since either this doesn't work or the api calls themselves don't work
    public func fetchData() {
        APICaller.shared.getFav { result in
            switch result {
            case .success(let model): break
            case .failure(let error): break
            }
        }
        
        APICaller.shared.getFavArtist { result in
            switch result {
            case .success(let model): break
            case .failure(let error): break
            }
        }
        
        APICaller.shared.getFavGenre { result in
            switch result {
            case .success(let model): break
            case .failure(let error): break
            }
        }
    }

}

