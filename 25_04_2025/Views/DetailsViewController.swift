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
    
    var networkService = NetworkService()
    var characters: [Model] = []
    @IBOutlet weak var collectionview: UICollectionView!
    var itemList:[DetailsItems]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(UINib(nibName: "DetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailCollectionViewCell")
        setupLoyaut()
        fetchCharacters()
    }
    
    func setupLoyaut(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionview.collectionViewLayout = layout
    }
    func fetchCharacters() {
        networkService.fetchCharacters { [weak self] characters in
            guard let self = self else { return }
            if let characters = characters {
                self.characters = characters
                
                self.itemList = characters.map { character in
                        .items(
                            DetailCollectionViewCell.Item(
                                imageUrl: character.image,
                                name: character.name
                            )
                        )
                }
                DispatchQueue.main.async {
                    self.collectionview.reloadData()
                }
            }
        }
    }
    
}

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
