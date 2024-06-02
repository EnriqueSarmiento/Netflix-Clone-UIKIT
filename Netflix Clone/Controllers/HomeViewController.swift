//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Enrique Sarmiento on 13/4/24.
//

import UIKit

enum Sections: Int {
   case TrendingMovies = 0
   case TrendingTv = 1
   case Popular = 2
   case Upcoming = 3
   case TopRated = 4
}

class HomeViewController: UIViewController{
   
   let sectionTitles : [String] = [
      "Trending Movies","Trending TV", "Popular",
      "Top Rated", "Upcoming Movies"
   ]
   
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
      
      configureNavBar()
      
      let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
      //       homeFeedtable.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
      homeFeedtable.tableHeaderView = headerView
      
   }
   
   private func configureNavBar(){
      var image = UIImage(named: "netflix-logo")
      image = image?.withRenderingMode(.alwaysOriginal)
      
      navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
      
      
      navigationItem.rightBarButtonItems = [
         UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
         UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
      ]
      
      navigationController?.navigationBar.tintColor = .white
      
      
   }
   
   // here we load our table as a subview
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      homeFeedtable.frame = view.bounds
   }
   
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource  {
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return sectionTitles.count
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
      
      switch indexPath.section {
      case Sections.TrendingMovies.rawValue:
         APICaller.shared.getTrendingMovies { result in
            switch result {
            case .success(let titles):
               cell.configure(with: titles)
            case .failure(let error):
               print("DEBUG: error on tableView UITableViewCell fetcing  TRENDING MOVIES", error.localizedDescription)
            }
         }
      case Sections.TrendingTv.rawValue:
         APICaller.shared.getTrendingTvs { result in
            switch result {
            case .success(let titles):
               cell.configure(with: titles)
            case .failure(let error):
               print("DEBUG: error on tableView UITableViewCell fetcing  TRENDING TV", error.localizedDescription)
            }
         }
      case Sections.TopRated.rawValue:
         APICaller.shared.getTopRatedMovies { result in
            switch result {
            case .success(let titles):
               cell.configure(with: titles)
            case .failure(let error):
               print("DEBUG: error on tableView UITableViewCell fetcing  TOP RATED", error.localizedDescription)
            }
         }
      case Sections.Upcoming.rawValue:
         APICaller.shared.getUpcomingMovies { result in
            switch result {
            case .success(let titles):
               cell.configure(with: titles)
            case .failure(let error):
               print("DEBUG: error on tableView UITableViewCell fetcing UPCOMING", error.localizedDescription)
            }
         }
      case Sections.Popular.rawValue:
         APICaller.shared.getPopularMovies { result in
            switch result {
            case .success(let titles):
               cell.configure(with: titles)
            case .failure(let error):
               print("DEBUG: error on tableView UITableViewCell fetcing POPULAR", error.localizedDescription)
            }
         }
      default:
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
   
   func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
      guard let header = view as? UITableViewHeaderFooterView else {return}
      header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
      header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
      header.textLabel?.textColor = .white
      header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
   }
   
   
   //here we assigned the titles for each sections
   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return sectionTitles[section]
   }
   
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let defaultOffset = view.safeAreaInsets.top
      let offset = scrollView.contentOffset.y + defaultOffset
      
      navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
   }
   
   
   
}
