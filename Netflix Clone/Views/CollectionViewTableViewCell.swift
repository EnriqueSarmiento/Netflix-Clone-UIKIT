//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by Enrique Sarmiento on 13/4/24.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

   // cell identifier for our table
   static let identifier = "CollectionViewTableViewCell"
   
   // creae collections for are cell (data horizontal)
   private  let collectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.itemSize = CGSize(width: 140, height: 200)
      layout.scrollDirection = .horizontal
      let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
      collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
      return collectionView
   }()
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      contentView.backgroundColor = .systemPink
      contentView.addSubview(collectionView)
      
      //adding protocols to collection cell
      collectionView.delegate = self
      collectionView.dataSource = self
   }
   
   required init?(coder: NSCoder) {
      fatalError()
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      
      collectionView.frame = contentView.bounds
   }

}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      10
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
      cell.backgroundColor = .yellow
      return cell
   }
}
