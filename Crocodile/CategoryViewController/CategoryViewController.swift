//
//  Category.swift
//  test
//
//  Created by Евгений Житников on 18.04.2023.
//

import UIKit

class CategoryViewController: UIViewController {
    
    let categoryCellIdentifire = "categoryCell"
    
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Категории"
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 34)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backGround: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "backgroung")
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let categoryCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let startGameButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(named: "Bottom color")
        view.setTitleColor(.white, for: .normal)
        view.setTitle("Начать игру", for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(startGameButtonPressed), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollection.backgroundColor = .clear
        addSubviews()
        setupCollectionView()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(backGround)
        view.addSubview(titleLabel)
        view.addSubview(categoryCollection)
        view.addSubview(startGameButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            backGround.topAnchor.constraint(equalTo: view.topAnchor),
            backGround.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backGround.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backGround.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            categoryCollection.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            categoryCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoryCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            categoryCollection.bottomAnchor.constraint(equalTo: startGameButton.topAnchor, constant: 16),
            
            startGameButton.heightAnchor.constraint(equalToConstant: 63),
            startGameButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 14),
            startGameButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -14),
            startGameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -63),
        ])
    }
    
    func setupCollectionView() {
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        categoryCollection.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: categoryCellIdentifire)
        categoryCollection.backgroundColor = .clear
        categoryCollection.showsVerticalScrollIndicator = false
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 32, height: categoryCollection.frame.height / 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
}

extension CategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellIdentifire, for: indexPath) as! CategoryCollectionViewCell
        let category = categories[indexPath.row]
        cell.refresh(category)
        switch indexPath.row {
        case 0:
            cell.contentView.backgroundColor = UIColor(named: "first cell color")
        case 1:
            cell.contentView.backgroundColor = UIColor(named: "second cell color")
        case 2:
            cell.contentView.backgroundColor = UIColor(named: "third cell color")
        case 3:
            cell.contentView.backgroundColor = UIColor(named: "fourth cell color")
        default:
            break
        }
        
        cell.isSelected = collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        
        if let selectedIndexPaths = collectionView.indexPathsForSelectedItems,
           let selectedIndex = selectedIndexPaths.firstIndex(where: { $0 != indexPath }) {
            let deselectedIndexPath = selectedIndexPaths[selectedIndex]
            let deselectedCell = collectionView.cellForItem(at: deselectedIndexPath) as! CategoryCollectionViewCell
            deselectedCell.isSelected = false
            collectionView.deselectItem(at: deselectedIndexPath, animated: true)
        }
        
        cell.isSelected = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        
        cell.isSelected = false
    }
    
    @objc func startGameButtonPressed() {
        guard let selectedIndexPath = categoryCollection.indexPathsForSelectedItems?.first else {
            let alert = UIAlertController(title: "Внимание!", message: "Для начала игры необходимо выбрать одну из категорий", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let selectedCategory = categories[selectedIndexPath.row]
        print(selectedCategory) // строка тестовая, убрать после связки с GameViewController()
        
        //        Раскомментить для связки
        //        let gameViewController = GameViewController()
        //        gameViewController.selectedCategory = selectedCategory
        //
        //        navigationController?.pushViewController(gameViewController, animated: true)
    }
}

