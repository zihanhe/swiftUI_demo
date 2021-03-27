//
//  MainController.swift
//  facebook_demo
//
//  Created by thunder on 24/03/21.
//


import UIKit
import LBTATools

class PostCell: LBTAListCell <String> {
    let imageView = UIImageView(backgroundColor: .red)
    let nameLabel = UILabel(text: "Name Label")
    let dateLabel = UILabel(text: "Friday at 11:11 AM")
    let postTextLabel = UILabel(text: "This is my first post")
//    let imageViewGrid = UIView(backgroundColor: .yellow)
    
    let photosGridController = PhotosGridController()
    
    
    override func setupViews() {
        backgroundColor = .white
        
        stack(
            hstack(
                imageView.withHeight(40).withWidth(40),
                stack(nameLabel, dateLabel),
                spacing: 8
            ).padLeft(12).padRight(12).padTop(12),
            postTextLabel,
            photosGridController.view,
            spacing: 8
        )
    }
}

class StoryHeader: UICollectionReusableView {
    let storiesController = StoriesController(scrollDirection: .horizontal)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        
        stack(storiesController.view)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class StoryPhotoCell: LBTAListCell<String> {
    override var item: String! {
        didSet {
            imageView.image = UIImage(named: item)
            avaImageView.image = UIImage(named: item)
        }
    }
    
    let imageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    let nameLabel = UILabel(text: "Satelite", font: .boldSystemFont(ofSize: 14), textColor: .white)
    let avaImageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    
    override func setupViews() {
        
        imageView.layer.cornerRadius = 10
        stack(imageView)
        stack(hstack(avaImageView.withWidth(30).withHeight(30), UIView()).padLeft(8).padTop(8),UIView()
        )
        avaImageView.backgroundColor = .red
        avaImageView.layer.cornerRadius = 15
        avaImageView.layer.borderWidth = 2
        avaImageView.layer.borderColor = UIColor.white.cgColor
        setupGradientLayer()
        
        stack(UIView(), nameLabel).withMargins(.allSides(8))
    }
    
    let gradientLayer = CAGradientLayer()

    fileprivate func setupGradientLayer(){
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.1]
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}

class StoriesController: LBTAListController<StoryPhotoCell, String>, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = ["sate1","sate2","sate3","sate4"]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 100, height: view.frame.height - 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 12, bottom: 0, right: 12)
    }
}

class CustomTitleView: UIView {
  override var intrinsicContentSize: CGSize {
    return UIView.layoutFittingExpandedSize
  }
}


class MainController: LBTAListHeaderController<PostCell, String, StoryHeader>, UICollectionViewDelegateFlowLayout {
    
    let logoImgView = UIImageView(image: UIImage(named: "navBarLogo"), contentMode: .scaleAspectFit)
    
    let searchButton = UIButton(title: "Search", titleColor: .black)


    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.backgroundColor = .init(white: 0.9, alpha: 1)
        
        self.items = ["Hello", "World", "1", "2"]
        
        setupNavBar()
    }
    
    fileprivate func setupNavBar() {
        let width = view.frame.width

        let titleView = CustomTitleView(backgroundColor: .clear)
        titleView.frame = .init(x: 0, y: 0, width: width, height: 50)
        
        
        titleView.hstack(logoImgView.withWidth(120),UIView(backgroundColor: .clear), searchButton.withWidth(60))
        
        navigationItem.titleView = titleView
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let safeAreaTop = UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
        
        
        
        let mSafeAreaTop: CGFloat = safeAreaTop + (navigationController?.navigationBar.frame.height ?? 0)
        let offset = scrollView.contentOffset.y + mSafeAreaTop
        let alphaValue: CGFloat = (1 - scrollView.contentOffset.y) / mSafeAreaTop
        
        [logoImgView, searchButton].forEach { $0.alpha = alphaValue }
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: 0, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 0, bottom: 0, right: 0)
    }
}


import SwiftUI

struct MainPreview: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) ->  UIViewController {
            return UINavigationController(rootViewController: MainController())
        }

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }

}
