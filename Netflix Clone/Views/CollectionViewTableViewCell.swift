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
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      contentView.backgroundColor = .systemPink
   }
   
   required init?(coder: NSCoder) {
      fatalError()
   }
   
   

}
