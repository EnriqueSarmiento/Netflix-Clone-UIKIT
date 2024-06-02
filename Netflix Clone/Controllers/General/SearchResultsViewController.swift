//
//  SearchResultsViewController.swift
//  Netflix Clone
//
//  Created by Enrique Sarmiento on 6/2/24.
//

import UIKit

class SearchResultsViewController: UIViewController {
   
   public var titles : [Title] = [Title]()
   
   public let searchResultsCollectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
      layout.minimumInteritemSpacing = 0
      
      let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
      collectionView.register(TittleCollectionViewCell.self, forCellWithReuseIdentifier: TittleCollectionViewCell.identifier)
      
      return collectionView
   }()

    override func viewDidLoad() {
        super.viewDidLoad()

       view.backgroundColor = .systemBackground
       view.addSubview(searchResultsCollectionView)
       
       searchResultsCollectionView.delegate = self
       searchResultsCollectionView.dataSource = self
    }
    
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      searchResultsCollectionView.frame = view.bounds
   }


}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return titles.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TittleCollectionViewCell.identifier, for: indexPath) as? TittleCollectionViewCell else {
         return UICollectionViewCell()
      }
      
      let title = titles[indexPath.row]
      cell.configure(with:  title.poster_path ?? "")
      
      return cell
   }
}
