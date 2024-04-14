//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Enrique Sarmiento on 13/4/24.
//

import UIKit

class HomeViewController: UIViewController{

   //create a table for this view controller with our custom cell
   private let homeFeedtable: UITableView = {
      let table = UITableView(frame: .zero, style: .grouped)
      table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
      return table
   }()

    override func viewDidLoad() {
        super.viewDidLoad()

       view.backgroundColor = .systemBackground
       view.addSubview(homeFeedtable)
       // added protocols for table
       homeFeedtable.delegate = self
       homeFeedtable.dataSource = self
       
       homeFeedtable.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
       
    }
   
   // here we load our table as a subview
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      homeFeedtable.frame = view.bounds
   }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource  {
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return 20
   }
   
   //here we defined the numbers of rows for our cell
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 1
   }
   
   // here we defined our custom cell, we asure that the custom cell is loaded, otherwise we return a default cell
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
         return UITableViewCell()
      }
      
      return cell
   }
   
   // here defined the height for our cell
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 200
   }
   
   //here defined the height header or our cell
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      40
   }
   
}
