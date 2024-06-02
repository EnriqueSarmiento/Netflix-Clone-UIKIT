//
//  TittleCollectionViewCell.swift
//  Netflix Clone
//
//  Created by Enrique Sarmiento on 6/2/24.
//

import UIKit
import SDWebImage

class TittleCollectionViewCell: UICollectionViewCell {
    static let identifier = "TittleCollectionViewCell"
   
   private let posterImageview: UIImageView = {
      let imageView = UIImageView()
      imageView.contentMode = .scaleAspectFill
      return imageView
   }()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      contentView.addSubview(posterImageview)
   }
   
   required init?(coder: NSCoder) {
      fatalError()
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      posterImageview.frame = contentView.bounds
   }
   
   public func configure(with model: String){
      guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {return}
      
      posterImageview.sd_setImage(with: url, completed: nil)
   }
   
   
}
