//
//  TabBarViewController.swift
//  Stats
//
//  Created by Asam Zaman on 12/3/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = HomeViewController()
        vc1.title = "Main"
        vc1.navigationItem.largeTitleDisplayMode = .always
        let nav1 = UINavigationController(rootViewController: vc1)
        nav1.tabBarItem = UITabBarItem(title: "Main", image: UIImage(systemName: "house"), tag:  1)
        nav1.navigationBar.prefersLargeTitles = true
        setViewControllers([nav1], animated: false)
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
