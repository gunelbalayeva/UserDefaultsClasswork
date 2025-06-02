//
//  ViewCollectionViewCell.swift
//  25_04_2025
//
//  Created by User on 25.04.25.
//

import UIKit
protocol CollectionViewDelegate{
    func didTapLovelyButton(in cell: ViewCollectionViewCell, with item: ViewCollectionViewCell.Item)
}

class ViewCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var favoriteButton:UIButton!
    var delegate :CollectionViewDelegate?
    var onFavoriteTapped: (() -> Void)?
    
    
    struct Item {
        let id: Int
        var image: String
        var title: String
        var subtitle: String
        var isLovelySelected: Bool = false
        var isFavorite: Bool
        
        
    }
    private var currentItem: Item?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favoriteButton.tintColor = .lightGray
    }
    
    func configure(with item: Item) {
        currentItem = item
        imageView.image = UIImage(named: item.image)
        title.text = item.title
        subtitle.text = item.subtitle
        let isFav = UserDefaultsManager.shared.isFavorite(id: item.id)
           currentItem?.isFavorite = isFav

           let imgName = isFav ? "heart.fill" : "heart"
           favoriteButton.setImage(UIImage(systemName: imgName), for: .normal)
           favoriteButton.tintColor = isFav ? UIColor(named: "buttonColor") ?? .red : .lightGray
    }
    
    @IBAction func lovelyButton(_ sender: UIButton) {
        guard let item = currentItem else { return }
        UserDefaultsManager.shared.toggleFavorite(id: item.id )
            currentItem?.isFavorite = UserDefaultsManager.shared.isFavorite(id: item.id)
            let isFav = currentItem?.isFavorite ?? false
            let newImageName = isFav ? "heart.fill" : "heart"
            favoriteButton.setImage(UIImage(systemName: newImageName), for: .normal)
            favoriteButton.tintColor = isFav ? UIColor(named: "buttonColor") ?? .red : .lightGray
            delegate?.didTapLovelyButton(in: self, with: currentItem!)
    }
}
