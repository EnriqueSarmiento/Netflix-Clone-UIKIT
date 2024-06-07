//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by Enrique Sarmiento on 13/4/24.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
   func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel)
}

class CollectionViewTableViewCell: UITableViewCell {

   // cell identifier for our table
   static let identifier = "CollectionViewTableViewCell"
   
   weak var delegate: CollectionViewTableViewCellDelegate?
   
   private var titles : [Title] = [Title]()
   
   // creae collections for are cell (data horizontal)
   private  let collectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.itemSize = CGSize(width: 140, height: 200)
      layout.scrollDirection = .horizontal
      let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
      collectionView.register(TittleCollectionViewCell.self, forCellWithReuseIdentifier: TittleCollectionViewCell.identifier)
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
   
   public func configure(with titles: [Title]){
      self.titles = titles
      DispatchQueue.main.async { [weak self] in
         self?.collectionView.reloadData()
      }
   }
   
   private func downloadTitleAt(indexPath: IndexPath){
      let title = titles[indexPath.row]
      print("downloading \(title.original_title ?? title.original_name ?? "")")
      
   }

}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return titles.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TittleCollectionViewCell.identifier, for: indexPath) as? TittleCollectionViewCell else {return UICollectionViewCell()}
      
      guard let model = titles[indexPath.row].poster_path else { return UICollectionViewCell() }
      cell.configure(with: model)
      return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      collectionView.deselectItem(at: indexPath, animated: true)
      let title = self.titles[indexPath.row]
      
      let name = title.original_name ?? title.original_title ?? "Unknown"
      
      APICaller.shared.getMovie(with: name + " trailer") {[weak self] result in
         switch result {
         case .success(let videoElement):
            let viewModel = TitlePreviewViewModel(title: name, youtubeView: videoElement, titleOverview: title.overview ?? "")
            guard let strongSelf = self else {return}
            
            self?.delegate?.collectionViewTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
            print(videoElement.id)
            
         case.failure(let error):
            print("error on collection view table api call for video", error.localizedDescription)
         }
      }
   }
   
   /** this fucntions allow long press and show a menu of option on each collection*/
   func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
      let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
         let downloadAction = UIAction(title: "Download", state: .off) { [weak self] _ in
            self?.downloadTitleAt(indexPath: indexPath)
         }
         
         return UIMenu(title: "", image:  nil, identifier: nil, options:  .displayInline, children: [downloadAction])
         
      }
      return config
   }
}
