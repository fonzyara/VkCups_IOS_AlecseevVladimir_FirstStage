//
//  CollectionViewCell.swift
//  vkMobileCup_1.AlecseevVladimir
//
//  Created by Vladimir Alecseev on 12.12.2022.
//
import UIKit

protocol CellDelegate: AnyObject {
    func passCellSelectionStateToController(_ cellType: CellType?, isNowSelected: Bool)
}

final class CollectionViewCell: UICollectionViewCell {
    
    weak var delegate: CellDelegate?
    
    private var cellModel: CellModel? {
        didSet{
            label.text = cellModel?.type.rawValue
        }
    }
    override var isSelected: Bool {
        didSet{
            changeBackgroundColor()
            delegate?.passCellSelectionStateToController(cellModel?.type, isNowSelected: isSelected)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        createViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCell(with cellModel: CellModel) {
        self.cellModel = cellModel
    }
   
    
    
    private let label: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.textAlignment = .center
        l.textAlignment = .left
        l.font = UIFont.boldSystemFont(ofSize: 17)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let separator: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
       return v
    }()
    
    private let selectionImage: UIImageView = {
        let iv = UIImageView()
        iv.image = SystemImagePicker.getImage(ofType: .plus)
        iv.translatesAutoresizingMaskIntoConstraints = false
       return iv
    }()
    
    func changeBackgroundColor(){
        if isSelected == true {
            UIView.animate(withDuration: 0.5) { [unowned self] in
                backgroundColor = .orange
                separator.isHidden = true
                selectionImage.image = SystemImagePicker.getImage(ofType: .checkmark)
            }

            
        } else {
            UIView.animate(withDuration: 0.5) { [unowned self] in
                backgroundColor = .systemGray
                separator.isHidden = false
                selectionImage.image = SystemImagePicker.getImage(ofType: .plus)
            }

        }
    }
}

extension CollectionViewCell{
    
    private func setupCell(){
        backgroundColor = .systemGray
        layer.cornerRadius = 15
    }
    private func createViews(){
        contentView.addSubview(label)
        contentView.addSubview(separator)
        contentView.addSubview(selectionImage)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45),

            
            selectionImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            selectionImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            selectionImage.widthAnchor.constraint(equalTo: selectionImage.heightAnchor),
            selectionImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -11),
            
            separator.trailingAnchor.constraint(equalTo: selectionImage.leadingAnchor, constant: -6),
            separator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            separator.widthAnchor.constraint(equalToConstant: 1)
        ])
    }
}

