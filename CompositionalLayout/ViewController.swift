//
//  ViewController.swift
//  CompositionalLayout
//
//  Created by Yernar Baiginzheyev on 24.04.2024.
//

import UIKit

class ViewController: UIViewController {
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        // item
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(2/3),
                              heightDimension: .fractionalHeight(1)
                             )
        )
        
        item.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let verticalStackItem = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .fractionalHeight(0.5)
                             )
        )
        
        verticalStackItem.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let verticalStackGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1/3),
                              heightDimension: .fractionalHeight(1)
                             ),
            subitem: verticalStackItem,
            count: 2)
        
        let tripletItem = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(1)
            )
        )

        tripletItem.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)

        
        let tripletHorizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(0.3)
            ),
            subitem: tripletItem,
            count: 3)

        //group
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .fractionalWidth(0.7)
                             ),
            subitems:  [
                item,
                verticalStackGroup
            ]
        )
        
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .fractionalHeight(1.0)
                             ),
            subitems: [
                horizontalGroup,
                tripletHorizontalGroup
            ]
        )
        //sections
        let section = NSCollectionLayoutSection(group: verticalGroup)
        
        //return
        return .init(section: section)
    }
    
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: ViewController.createLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.register(MyCollectionViewCell.self,
                                forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
    }
    
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier,
                                                      for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    
}

