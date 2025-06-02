//
//  DetailCollectionViewCell.swift
//  25_04_2025
//
//  Created by User on 25.04.25.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    struct Item{
        var imageUrl:String
        var name:String
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with item :Item){
        loadImage(from: item.imageUrl)
        nameLabel.text = item.name
    }
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
          if let error = error {
                print("Error loading image: \(error)")
                return
            }
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        task.resume()
    }
}
