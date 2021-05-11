//
//  ImageCollectionCell.swift
//  MatchiOSCode
//
//  Created by Aminjoni Abdullozoda on 5/9/21.
//

import UIKit

final class ImageCollectionCell: UICollectionViewCell {
    
    //MARK:- Properties
    static let reuseIdentifier = "imageCell"
    weak var viewModel : ImageCellViewModelType? {
        didSet(viewmodel) {
            guard let viewmodel = viewModel else {return}
            self.cellImage.load(url: viewmodel.downloadURL)
            self.authorLabel.attributedText = authorLabelAttribute(named: viewmodel.author)
        }
    }
    
    //MARK: - UI
    private let placeHolderImage =  UIImage(named: "placeholder")?.roundedImage
    private let authorLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.transform =  CGAffineTransform(rotationAngle: CGFloat(Double.pi / -4))
        label.accessibilityIdentifier = AccessibilityIdentifiers.AXImagesMainView.Cell.AuthorLabel
        return label
    }()
    private lazy var cellImage : UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFill
        imageview.image = placeHolderImage
        return imageview
    }()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(cellImage)
        cellImage.addSubview(authorLabel)
        
        //Constrains
        cellImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        cellImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        cellImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        cellImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        authorLabel.topAnchor.constraint(equalTo: self.cellImage.topAnchor).isActive = true
        authorLabel.bottomAnchor.constraint(equalTo: self.cellImage.bottomAnchor).isActive = true
        authorLabel.leadingAnchor.constraint(equalTo: self.cellImage.leadingAnchor, constant: 10).isActive = true
        authorLabel.trailingAnchor.constraint(equalTo: self.cellImage.trailingAnchor, constant: -10).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    //MARK:- Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellImage.image  = placeHolderImage
        self.authorLabel.text = nil
    }
    func configureViewModel (viewModel : ImageCellViewModelType) {
        self.viewModel = viewModel
        self.cellImage.load(url: viewModel.downloadURL)
        let strokeTextAttributes: [NSAttributedString.Key : Any] = [
            .strokeColor : UIColor.black,
            .foregroundColor : UIColor.white,
            .font : UIFont.systemFont(ofSize: 14, weight: .bold),
            .strokeWidth : -2.0,
        ]
        self.authorLabel.attributedText = NSAttributedString(string: viewModel.author, attributes: strokeTextAttributes)
    }
    
    func removeVowels() {
        if let labelText = authorLabel.text {
            self.authorLabel.attributedText = authorLabelAttribute(named: labelText.removeVowels())
        }
    }
    
    func startAnimate() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = 3
        rotateAnimation.repeatCount = Float.infinity
        self.authorLabel.layer.add(rotateAnimation, forKey: nil)
    }
    
    func stopAnimate() {
        self.authorLabel.layer.removeAllAnimations()
    }
    
    func authorLabelAttribute(named : String) -> NSAttributedString {
        let strokeTextAttributes: [NSAttributedString.Key : Any] = [
            .strokeColor : UIColor.black,
            .foregroundColor : UIColor.white,
            .font : UIFont.systemFont(ofSize: 14, weight: .bold),
            .strokeWidth : -2.0,
        ]
        return NSAttributedString(string: named, attributes: strokeTextAttributes)
    }
    
}

