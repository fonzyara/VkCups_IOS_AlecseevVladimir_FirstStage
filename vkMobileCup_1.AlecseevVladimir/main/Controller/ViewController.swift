//
//  ViewController.swift
//  vkMobileCup_1.AlecseevVladimir
//
//  Created by Vladimir Alecseev on 12.12.2022.
//

import UIKit

class ViewController: UIViewController {

    
    var arrayOfSelectedCategories: [CellType?] = [] {
        didSet{
            if arrayOfSelectedCategories.count >= 1{
                nextButton.isHidden = false
            } else { nextButton.isHidden = true}
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        configureCollection()
        createViews()
        setConstraints()
    }

    
    private let collectionView: UICollectionView = {
        let layout = CustomCollectionViewLayout()
        layout.minimumLineSpacing = 8
        layout.estimatedItemSize = CustomCollectionViewLayout.automaticSize
        
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.translatesAutoresizingMaskIntoConstraints = false
        c.allowsMultipleSelection = true
        c.backgroundColor = .black
        return c
    }()

    private let infoLabel: UILabel = {
        let l = UILabel()
        l.textColor = .darkGray
        l.textAlignment = .left
        l.text = "Отметьте то, что вам интересно, чтобы настроить Дзен"
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let laterButton: UIButton = {
        let b = UIButton()
        b.setTitle("Позже", for: .normal)
        b.backgroundColor = .appPalette.laterbutton.color
        b.layer.cornerRadius = 20
        b.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
       return b
    }()
    private let nextButton: UIButton = {
        let b = UIButton()
        b.setTitle("Продолжить", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.backgroundColor = .white
        b.layer.cornerRadius = 40
        b.isHidden = true
        b.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
       return b
    }()
    
    @objc func nextButtonTapped(){
        let alert = UIAlertController(title: "Дальше пути нет!", message: ":(", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Что ж", style: .cancel))
        present(alert, animated: true)
    }
    
    func configureCollection(){
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
}



extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CellType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let cellModel = CellModel(type: CellType.allCases[indexPath.row])
        cell.configureCell(with: cellModel)
        cell.delegate = self
        return cell 
    }
    
    
}


extension ViewController: CellDelegate {
    func passCellSelectionStateToController(_ cellType: CellType?, isNowSelected: Bool) {
        if isNowSelected == true{
            arrayOfSelectedCategories.append(cellType)
        } else {
            if let elementIndex = arrayOfSelectedCategories.firstIndex(of: cellType){
                arrayOfSelectedCategories.remove(at: elementIndex)
            }
            
        }
        
    }
}
extension ViewController{
    private func createViews(){
        view.addSubview(collectionView)
        view.addSubview(nextButton)
        view.addSubview(infoLabel)
        view.addSubview(laterButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            laterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            laterButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            laterButton.heightAnchor.constraint(equalToConstant: 40),
            laterButton.widthAnchor.constraint(equalToConstant: 79),
            
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            infoLabel.trailingAnchor.constraint(equalTo: laterButton.leadingAnchor, constant: -10),
            
            
            collectionView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: 20),

            
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 80),
            nextButton.widthAnchor.constraint(equalToConstant: 211),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
            
        ])
    }
}

