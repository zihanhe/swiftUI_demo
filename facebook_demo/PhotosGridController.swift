//
//  PhotosGridController.swift
//  facebook_demo
//
//  Created by thunder on 26/03/21.
//


import UIKit
import SwiftUI
import LBTATools

class PhotoGridCell: LBTAListCell <String> {
    
    override var item: String! {
        didSet{
            imageView.image = UIImage(named: item)
        }
    }
    
    let imageView = UIImageView(image: UIImage(named: "sate1") , contentMode: .scaleAspectFill)
    
    override func setupViews() {
        backgroundColor = .yellow
        
        addSubview(imageView)
//        imageView.fillSuperview()
        stack(imageView)
    }
}

class PhotosGridController: LBTAListController<PhotoGridCell, String>, UICollectionViewDelegateFlowLayout {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .lightGray
        
        self.items = ["sate1","sate2","sate3","sate4","sate5"]
    }
    
    let cellSpacing: CGFloat = 4
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if self.items.count == 4 {
            // do 4 grid cell layout here.
        }
        
        if indexPath.item == 0 || indexPath.item == 1 {
            let width = (view.frame.width - 3 * cellSpacing) / 2
            return .init(width: width, height: width)
        }
        
        let width = (view.frame.width - 4.1 * cellSpacing) / 3
        return .init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: cellSpacing, bottom: 0, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
}

class PhotosGridPreview: PreviewProvider {
    
    static var previews: some View {
        ContainerView()
    }
    
    
    struct ContainerView: UIViewControllerRepresentable {
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<PhotosGridPreview.ContainerView>) -> UIViewController {
           return PhotosGridController()
        }
        
        func updateUIViewController(_ uiViewController: PhotosGridPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<PhotosGridPreview.ContainerView>) {
            
        }
        
    }
}
