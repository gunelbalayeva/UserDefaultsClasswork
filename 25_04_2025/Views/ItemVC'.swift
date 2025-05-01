//
//  ItemVC'.swift
//  25_04_2025
//
//  Created by User on 27.04.25.
//
import Foundation
import UIKit
protocol ItemVCDelegate {
    func didUpdateItem(_ item: ViewCollectionViewCell.Item)
}
class ItemVC: UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lovelyButton: UIButton!
    var imageName: String?
    var titleText: String?
    var subtitleText: String?
    var isLovelySelected: Bool = false
    var item: ViewCollectionViewCell.Item?
    var delegate: ItemVCDelegate?
    var itemId: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleText
        subtitleLabel.text = subtitleText
        
        if let imageName = imageName {
            imageView.image = UIImage(named: imageName)
        }

        let heartImage = UIImage(named: "heartIcon")?.withRenderingMode(.alwaysTemplate)
        lovelyButton.setImage(heartImage, for: .normal)

        lovelyButton.tintColor = isLovelySelected ? UIColor(named: "selectColor") ?? .red : .black
    }

    @IBAction func selectLovelyButton(_ sender: UIButton) {
        isLovelySelected.toggle()
            sender.tintColor = isLovelySelected ? UIColor(named: "selectColor") ?? .red : .black
            delegate?.didUpdateItem(ViewCollectionViewCell.Item(
                id: itemId ?? Int.random(in: 1000...9999),
                image: imageName ?? "",
                title: titleText ?? "",
                subtitle: subtitleText ?? "",
                isFavorite: isLovelySelected
            ))
            self.navigationController?.popViewController(animated: true)
    }
}
