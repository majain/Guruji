//
//  GallaryViewController
//  Sample
//
//  Created by Jain, Mohit on 8/6/18.
//  Copyright © 2018 Handsome. All rights reserved.
//

import InteractiveSideMenu
import UIKit

/*
import SwiftPhotoGallery

class GallaryViewController: UIViewController, SideMenuItemContent, Storyboardable, SwiftPhotoGalleryDataSource, SwiftPhotoGalleryDelegate {
   
    
 varet imageNames = ["image1.jpeg", "image2.jpeg", "image3.jpeg"]
    var index: Int = 2
    
    // MARK: SwiftPhotoGalleryDataSource Methods
    
    func numberOfImagesInGallery(gallery: SwiftPhotoGallery) -> Int {
        return imageNames.count
    }
    
    func imageInGallery(gallery: SwiftPhotoGallery, forIndex: Int) -> UIImage? {
        return UIImage(named: imageNames[forIndex])
    }
    
    // MARK: SwiftPhotoGalleryDelegate Methods
    
    func galleryDidTapToClose(gallery: SwiftPhotoGallery) {
        dismiss(animated: true, completion: nil)
         showSideMenu()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func openMenu(_ sender: UIBarButtonItem) {
        showSideMenu()
    }
    
  
    override func viewDidAppear(_ animated: Bool) {
       
        super.viewDidAppear(animated)
        
        let gallery = SwiftPhotoGallery(delegate: self, dataSource: self)
        gallery.backgroundColor = UIColor.black
        gallery.pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.5)
        gallery.currentPageIndicatorTintColor = UIColor.white
        gallery.hidePageControl = false
        
    
        present(gallery, animated: true, completion: nil)
    }
}
 */


class GallaryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, SideMenuItemContent, Storyboardable {
    
    var myCollectionView: UICollectionView!
    var imageArray=[UIImage]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func openMenu(_ sender: UIBarButtonItem) {
        showSideMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Gallary"
        
        let layout = UICollectionViewFlowLayout()
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.delegate=self
        myCollectionView.dataSource=self
        myCollectionView.register(PhotoItemCell.self, forCellWithReuseIdentifier: "Cell")
        myCollectionView.backgroundColor=UIColor.white
        self.view.addSubview(myCollectionView)
        
        myCollectionView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleWidth.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))
        
        grabPhotos()
    }
    
    //MARK: CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoItemCell
        cell.img.image=imageArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        let vc = ImagePreviewVC()
        vc.imgArray = self.imageArray
        vc.passedContentOffset = indexPath
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        //        if UIDevice.current.orientation.isPortrait {
        //            return CGSize(width: width/4 - 1, height: width/4 - 1)
        //        } else {
        //            return CGSize(width: width/6 - 1, height: width/6 - 1)
        //        }
        if DeviceInfo.Orientation.isPortrait {
            return CGSize(width: width/4 - 1, height: width/4 - 1)
        } else {
            return CGSize(width: width/6 - 1, height: width/6 - 1)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        myCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    //MARK: grab photos
    func grabPhotos(){
        imageArray = [UIImage(named:"img1.jpg")!,UIImage(named:"img2.jpg")!,UIImage(named:"img3.jpg")!,UIImage(named:"img4.jpg")!,UIImage(named:"img5.jpg")!,UIImage(named:"img6.jpg")!,UIImage(named:"img7.jpg")!,UIImage(named:"img8.jpg")!,UIImage(named:"img9.jpg")!,UIImage(named:"img10.jpg")!,UIImage(named:"img11.jpg")!,UIImage(named:"img12.jpg")!,UIImage(named:"img13.jpg")!,UIImage(named:"img14.jpg")!,UIImage(named:"img15.jpg")!,UIImage(named:"img16.jpg")!,UIImage(named:"img17.jpg")!,UIImage(named:"img18.jpg")!,UIImage(named:"img19.jpg")!,UIImage(named:"img20.jpg")!,UIImage(named:"img21.jpg")!,UIImage(named:"img22.jpg")!,UIImage(named:"img23.jpg")!]
    }
}


class PhotoItemCell: UICollectionViewCell {
    
    var img = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        img.contentMode = .scaleAspectFill
        img.clipsToBounds=true
        self.addSubview(img)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        img.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct DeviceInfo {
    struct Orientation {
        // indicate current device is in the LandScape orientation
        static var isLandscape: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isLandscape
                    : UIApplication.shared.statusBarOrientation.isLandscape
            }
        }
        // indicate current device is in the Portrait orientation
        static var isPortrait: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isPortrait
                    : UIApplication.shared.statusBarOrientation.isPortrait
            }
        }
    }
}





