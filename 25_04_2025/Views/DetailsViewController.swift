//
//  DetailsViewController.swift
//  25_04_2025
//
//  Created by User on 25.04.25.
//

import UIKit
enum DetailsItems{
    case items(DetailCollectionViewCell.Item)
}
class DetailsViewController: UIViewController {
    var networkservice = NetworkService()
    var model = Model()
    @IBOutlet weak var collectionview: UICollectionView!
    var itemList:[DetailsItems]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(UINib(nibName: "DetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailCollectionViewCell")
        fetchCharacters() 
    }
    func fetchCharacters() {
        networkservice.fetchCharakters { [weak self] characters in
            DispatchQueue.main.async {
                self?.itemList = characters.map { DetailsItems.items(DetailCollectionViewCell.Item(imageUrl: $0.image, name: $0.name)) }
                self?.collectionview.reloadData()
            }
        }
    }
}
extension DetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "DetailCollectionViewCell", for: indexPath) as? DetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        if case let .items(character) = itemList[indexPath.item] {
                    cell.configure(with: character)
                }
        return cell
    }
}
