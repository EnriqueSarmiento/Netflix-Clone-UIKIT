//
//  HeroHeaderUIView.swift
//  Netflix Clone
//
//  Created by Enrique Sarmiento on 14/4/24.
//

import UIKit

class HeroHeaderUIView: UIView {
   
   private let downloadButton: UIButton = {
      let button = UIButton()
      button.setTitle("Download", for: .normal)
      button.layer.borderColor = UIColor.white.cgColor
      button.layer.borderWidth = 1
      button.translatesAutoresizingMaskIntoConstraints = false
      button.layer.cornerRadius = 5
      return button
   }()
   
   private let playButton: UIButton = {
      let button = UIButton()
      button.setTitle("Play", for: .normal)
      button.layer.borderColor = UIColor.white.cgColor
      button.layer.borderWidth = 1
      button.translatesAutoresizingMaskIntoConstraints = false
      button.layer.cornerRadius = 5
      return button
   }()
   
   private let heroImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      imageView.image = UIImage(named: "heroImage")
      return imageView
   }()

   private func addGradient(){
      let gradientLayer = CAGradientLayer()
      gradientLayer.colors = [
         UIColor.clear.cgColor,
         UIColor.systemBackground.cgColor
      ]
      gradientLayer.frame = bounds
      layer.addSublayer(gradientLayer)
   }
   
   // this two init functions are the init steps for this view
   override init(frame: CGRect) {
      super.init(frame: frame)
      // here we added the subview to this view
      addSubview(heroImageView)
      addGradient()
      addSubview(playButton)
      addSubview(downloadButton)
      applyConstraints()
   }
   
   required init?(coder: NSCoder){
      fatalError()
   }
   
   //here we load our subview
   override func layoutSubviews() {
      super.layoutSubviews()
      heroImageView.frame = bounds
   }
   
   //here we apply the constraints for our views
   private func applyConstraints(){
      let playButtonConstraints = [
         playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
         playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
         playButton.widthAnchor.constraint(equalToConstant: 120)
      ]
      let downloadButtonConstraints = [
         downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
         downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
         downloadButton.widthAnchor.constraint(equalToConstant: 120)
      ]
      
      NSLayoutConstraint.activate(playButtonConstraints)
      NSLayoutConstraint.activate(downloadButtonConstraints)
     
   }
   
   public func configure(with model: TitleViewModel){
      guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {return}
      
      heroImageView.sd_setImage(with: url, completed: nil)
      
   }

}
