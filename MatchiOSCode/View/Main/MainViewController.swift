//
//  ViewController.swift
//  MatchiOSCode
//
//  Created by Aminjoni Abdullozoda on 5/8/21.
//

import UIKit

final class MainViewController: UIViewController, UIGestureRecognizerDelegate {

    //MARK:- Properties
    fileprivate var viewModel  : MainViewModelType!
    private var images : [ImageDetail] = []
    fileprivate var currentPage = 1
    fileprivate var isFetching  = false
    
    //MARK:- UI Elements
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Images"
        label.font = UIFont.systemFont(ofSize: 25)
        label.accessibilityIdentifier = AccessibilityIdentifiers.AXImagesMainView.ImagesMainViewTitle
        return label
    }()
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.accessibilityIdentifier = AccessibilityIdentifiers.AXImagesMainView.ImagesMainViewCollection
        
        return collectionView
    }()
    private let getMoreButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Get more images", for: .normal)
        btn.addTarget(self, action: #selector(getMoreImages), for: .touchUpInside)
        btn.backgroundColor = .systemOrange
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        btn.accessibilityIdentifier = AccessibilityIdentifiers.AXImagesMainView.Button.GetMoreImagesButton
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.systemBackground
        
        setupView()
        
        //Setup View Model
        viewModel = MainControllerViewModel(service: ApiService())
        viewModel?.delegate = self
        viewModel?.fetchImages(page: currentPage)
    }
    
    //MARK:- Methods
    fileprivate func setupView() {
        
        //Setup Collection
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: ImageCollectionCell.reuseIdentifier)
        
        //Setup LongPress
        setupLongGestureRecognizerOnCollection()
        
        view.addSubview(collectionView)
        view.addSubview(titleLabel)
        view.addSubview(getMoreButton)
        
        //MARK:- Constrains
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -15).isActive = true
        
        getMoreButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35).isActive = true
        getMoreButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -35).isActive = true
        getMoreButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20).isActive = true
        getMoreButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupLongGestureRecognizerOnCollection() {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressOnCell(gestureRecognizer:)))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOnCell(gestureRecognizer:)))
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        collectionView.addGestureRecognizer(longPressedGesture)
        collectionView.addGestureRecognizer(tapGesture)
    }
    
    @objc fileprivate func handleLongPressOnCell(gestureRecognizer: UILongPressGestureRecognizer) {
        
        let point = gestureRecognizer.location(in: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: point) else {return}
        guard let cell = self.collectionView.cellForItem(at: indexPath) as? ImageCollectionCell else {return}
        
        //start animate
        if (gestureRecognizer.state == .began) {
            cell.startAnimate()
        }
        //stop animate
        else if (gestureRecognizer.state == .ended) {
            cell.stopAnimate()
        }
    }
    
    @objc fileprivate func handleTapOnCell(gestureRecognizer : UITapGestureRecognizer) {
        let point = gestureRecognizer.location(in: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: point) else {return}
        guard let cell = self.collectionView.cellForItem(at: indexPath) as? ImageCollectionCell else {return}
        cell.removeVowels()
    }
   
    ///Fetch more Images
    @objc fileprivate func getMoreImages() {
        viewModel.fetchImages(page: currentPage)
    }
        
}

//MARK:- CollectionView DataSource + Delegate
extension MainViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    /// Data Sources
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionCell.reuseIdentifier, for: indexPath) as? ImageCollectionCell else {
            return UICollectionViewCell()
        }
        
        guard let viewModelCell = viewModel.cellViewModel(forIndexPath: indexPath) else {return UICollectionViewCell()}
        cell.viewModel = viewModelCell
        
        return cell
    }
            
    ///Delegates
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 150, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15 
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: .zero, left: 15, bottom: .zero, right: 15)
    }
}

//MARK:- Delegate Methods of ViewModel
extension MainViewController : MainCollectionViewModelDelegate {
    
    func willLoadData() {
        self.isFetching = true
        
        //Initial spinner
        if viewModel.numberOfRows < 1 {
            self.showLoadingView()
        }
    }
    
    func didLoadData() {
        DispatchQueue.main.async {
            self.dismissLoadingView()
            self.collectionView.reloadData()
            self.isFetching = false
            self.currentPage = self.currentPage + 1
        }
    }
    
    func didLoadDataFailed(error: MatchError) {
        self.dismissLoadingView()
        self.presentAlertView(title: "Opps", message: error.localizedDescription, buttonTitle: "Hmm Okay!")
        self.isFetching = false
    }
}
