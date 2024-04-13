//
//  ViewController.swift
//  Netflix Clone
//
//  Created by Enrique Sarmiento on 13/4/24.
//

import UIKit

class MainTabBarViewController: UITabBarController{

   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      view.backgroundColor = .white
      
      let vc1 = UINavigationController(rootViewController: HomeViewController())
      let vc2 = UINavigationController(rootViewController: UpcomingViewController())
      let vc3 = UINavigationController(rootViewController: SearchViewController())
      let vc4 = UINavigationController(rootViewController: DownloadsViewController())
      
      //adding icons on tab items
      vc1.tabBarItem.image = UIImage(systemName: "house")
      vc2.tabBarItem.image = UIImage(systemName: "play.circle")
      vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
      vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
      
      //adding titles to tab items
      vc1.title = "Home"
      vc2.title = "Comming Soon"
      vc3.title = "Top Search"
      vc4.title = "Downloads"
      
      //changing tint color
      tabBar.tintColor = .label
      
      setViewControllers([vc1, vc2, vc3, vc4], animated: true)
   }


}

