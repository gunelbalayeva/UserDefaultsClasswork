//
//  ViewController.swift
//  25_04_2025
//
//  Created by User on 25.04.25.
//

import UIKit
enum CollectionList{
    case collectionList(ViewCollectionViewCell.Item)
}

class ViewController: UIViewController {
    @IBOutlet weak var collectionview: UICollectionView!
    var list: [CollectionList] = [
        .collectionList(.init(id: 1, image: "image1", title: "Yolana", subtitle: "Fotosessiya", isFavorite: UserDefaultsManager.shared.isFavorite(id: 1))),
        .collectionList(.init(id: 2, image: "image2", title: "Wavesfactory", subtitle: "Fotosessiya", isFavorite: UserDefaultsManager.shared.isFavorite(id: 2))),
        .collectionList(.init(id: 3, image: "image3", title: "Sayyes", subtitle: "Fotosessiya", isFavorite: UserDefaultsManager.shared.isFavorite(id: 3))),
        .collectionList(.init(id: 4, image: "image4", title: "Aeroty", subtitle: "Fotosessiya", isFavorite: UserDefaultsManager.shared.isFavorite(id: 4))),
        .collectionList(.init(id: 5, image: "image5", title: "HBM", subtitle: "Fotosessiya", isFavorite: UserDefaultsManager.shared.isFavorite(id: 5)))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(UINib(nibName: "ViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ViewCollectionViewCell")
        setupCollectionViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionview.reloadData() 
    }

    private func setupCollectionViewLayout() {
        if let layout = collectionview.collectionViewLayout as? UICollectionViewFlowLayout {
            let spacing: CGFloat = 16
            let screenWidth = UIScreen.main.bounds.width
            let itemWidth = (screenWidth - spacing * 3) / 2
            
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.4)
            layout.minimumLineSpacing = spacing
            layout.minimumInteritemSpacing = spacing
            layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        }
    }
}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewCollectionViewCell", for: indexPath) as? ViewCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        let item = list[indexPath.row]
        switch item {
        case .collectionList(let data):
            cell.configure(with: data)
            
            cell.onFavoriteTapped = { [weak self] in
                guard let self = self else { return }
                let characterId = data.id
                UserDefaultsManager.shared.toggleFavorite(id: characterId)
                
                if case .collectionList(var updatedItem) = self.list[indexPath.row] {
                    updatedItem.isFavorite.toggle()
                    self.list[indexPath.row] = .collectionList(updatedItem)
                }
                
                self.collectionview.reloadItems(at: [indexPath])
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: DetailsViewController.identifier) as? DetailsViewController  else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController:CollectionViewDelegate {
    
    func didTapLovelyButton(in cell: ViewCollectionViewCell, with item: ViewCollectionViewCell.Item) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: ItemVC.identifier) as? ItemVC else {
            return
        }
        vc.item = item
        vc.imageName = item.image
        vc.titleText = item.title
        vc.subtitleText = item.subtitle
        vc.isLovelySelected = item.isFavorite
        cell.delegate = self
        vc.modalPresentationStyle = .fullScreen
        if let index = list.firstIndex(where: {
            switch $0 {
            case .collectionList(let oldItem):
                return oldItem.id == item.id
            }
        }) {
            list[index] = .collectionList(item)
            collectionview.reloadItems(at: [IndexPath(item: index, section: 0)])
        }
        collectionview.reloadData()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension ViewController: ItemVCDelegate {
    
    func didUpdateItem(_ item: ViewCollectionViewCell.Item) {
        if let index = list.firstIndex(where: {
            switch $0 {
            case .collectionList(let oldItem):
                return oldItem.id == item.id
            }
        }) {
            list[index] = .collectionList(item)
            collectionview.reloadItems(at: [IndexPath(item: index, section: 0)])
        }
    }
}

