//
//  DowloadsViewController.swift
//  Netflix Clone
//
//  Created by Enrique Sarmiento on 13/4/24.
//

import UIKit

class DownloadsViewController: UIViewController {
   
   private var titles: [TitleItem] = [TitleItem]()
   
   private let downloadedTable: UITableView = {
      let table = UITableView()
      table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
      return table
   }()


    override func viewDidLoad() {
        super.viewDidLoad()

       view.backgroundColor = .systemBackground
       title = "Downloads"
       view.addSubview(downloadedTable)
       navigationController?.navigationBar.prefersLargeTitles = true
       navigationController?.navigationItem.largeTitleDisplayMode = .always
       
       downloadedTable.delegate = self
       downloadedTable.dataSource = self
       fetchLocalStorageForDownloads()
    }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(true)
      fetchLocalStorageForDownloads()
   }
   
   private func fetchLocalStorageForDownloads(){
      DataPersistenceManager.shared.fetchingTitlesfromDataBase { [weak self] result in
         switch result {
         case .success(let titles):
            DispatchQueue.main.async {
               self?.titles = titles
               self?.downloadedTable.reloadData()               
            }
         case .failure(let error):
            print("DEBUG: error fetch data core data", error.localizedDescription)
         }
      }
   }
   
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      downloadedTable.frame = view.bounds
   }

   
}

extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return titles.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
         return UITableViewCell()
      }
      
      let title = titles[indexPath.row]
      let name = title.original_name ?? title.original_title ?? "Unknown"
      
      cell.configure(with: TitleViewModel(titleName: name, posterURL: title.poster_path ?? ""))
      return cell
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 140
   }
   
   
}
