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
    @IBOutlet weak var image: UIImageView!
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
    }
    
    func configure(with item: Item) {
        currentItem = item
        image.image = UIImage(named: item.image)
        title.text = item.title
        subtitle.text = item.subtitle
        let favoriteImage = item.isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        favoriteButton.setImage(favoriteImage, for: .normal)   
    }
    
    @IBAction func lovelyButton(_ sender: UIButton) {
        if let currentItem = currentItem {
               delegate?.didTapLovelyButton(in: self, with: currentItem)
        } 
        let favoriteColor: UIColor = (currentItem?.isFavorite ?? false) ? UIColor(named: "selectColor")! : UIColor(named: "selectColor")!
        favoriteButton.setTitleColor(favoriteColor, for: .normal)
        onFavoriteTapped?()
    }
}
