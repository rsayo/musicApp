////
////  OverViewController.swift
////  spotlight
////
////  Created by Robert Aubow on 8/22/21.
////
//import Foundation
//import UIKit
//
//class OverViewController: UIViewController, UICollectionViewDelegate {
//    var albumId: String?
//
//    fileprivate var section: [LibObject]?
//
//
//    fileprivate var collectionView: UICollectionView!
//    fileprivate var dataSource: UICollectionViewDiffableDataSource<LibObject, LibItem>?
//
//    override func loadView() {
//        super.loadView()
//        view.backgroundColor = UIColor.init(displayP3Red: 22 / 255, green: 22 / 255, blue: 22 / 255, alpha: 1)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.navigationBar.isHidden = true
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        NetworkManager.Get(url: "album?albumId=\(albumId)") { (data: [LibObject]?, error: NetworkError) in
//            switch(error){
//            case .servererr:
//                print(error.localizedDescription)
//
//            case .success:
//
//                self.section = data!
//
//                DispatchQueue.main.async {
////                    self.loadingView.removeFromSuperview()
//
//                    self.initCollectionView()
//                }
//
//            case .notfound:
//                print(error.localizedDescription)
//            }
//        }
//
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        navigationController?.navigationBar.isHidden = false
//    }
//    func initCollectionView(){
//        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
//        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        collectionView.backgroundColor = UIColor.init(displayP3Red: 22 / 255, green: 22 / 255, blue: 22 / 255, alpha: 0.2)
//        collectionView.delegate = self
//
//        // register items
//        collectionView.register(TrackDetailStrip.self, forCellWithReuseIdentifier: TrackDetailStrip.reuseIdentifier)
//        collectionView.register(MediumImageSlider.self, forCellWithReuseIdentifier: MediumImageSlider.reuseIdentifier)
////        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
//
//        // Headers
//        collectionView.register(DetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailHeader.reuseableIdentifier)
//        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
//
//        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
//        view.addSubview(collectionView)
//
//        createDataSource()
//
//        reloadData()
//    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let contentOffsetY = abs(collectionView.contentOffset.y)
////        print(contentOffsetY)
//    }
//
//
//
//    // Create Datasource
//    func createDataSource() {
//        dataSource = UICollectionViewDiffableDataSource<LibObject, LibItem> (collectionView: collectionView) {
//            collectionview, IndexPath, item in
//            let section = self.section![IndexPath.section].type
////            print("Section", section)
//
//            print(item)
////
////            switch(section){
////            case "Tracks":
//                return LayoutManager.configureCell(collectionView: collectionview, navigationController: self.navigationController, TrackDetailStrip.self, with: item, indexPath: IndexPath)
////            default:
////                return LayoutManager.configureCell(collectionView: collectionview, navigationController: self.navigationController, MediumImageSlider.self, with: item, indexPath: IndexPath)
////            }
//
////
//        }
//
//        dataSource?.supplementaryViewProvider = {[weak self] collectionView, kind, IndexPath in
//
//
//            guard let firstSEction = self?.dataSource?.itemIdentifier(for: IndexPath) else {return nil}
//            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstSEction) else {return nil}
//
//
//            if section.imageURL == nil {
//
//                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: IndexPath) as? SectionHeader else {return nil}
//
//                header.tagline.text = section.title
//                header.title.text = section.type
//
//                return header
//            }else{
//                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailHeader.reuseableIdentifier, for: IndexPath) as? DetailHeader else {
//                    return nil
//                }
//
//                header.albumImage.setUpImage(url: section.imageURL!, interactable: false)
//                header.imageContainer.setUpImage(url: section.imageURL!, interactable: false)
//
//                header.trackTitle.text = section.title
//                header.artist.text = section.name
//                header.pageTag.text = section.type
//                header.artistAviImage.setUpImage(url: section.artistImgURL!, interactable: true)
//                header.artistId = section.artistId!
//                header.vc = self?.navigationController
//
//                let date = Date()
//                let publishDate = date.formateDate(dateString: section.releaseDate!)
//                header.datePublished.text = "\(section.items!.count) \( section.items!.count > 1 ? "Tracks" : "Track"), Published \(publishDate)"
//
//                for i in 0..<section.items!.count {
//                    let item  = section.items![i]
//
//                    let track = Track(id: item.id, title: item.title!, artistId: item.artistId!, name: item.name!, imageURL: item.imageURL, albumId: item.albumId!, audioURL: item.audioURL!)
//
//                    header.tracks.append(track)
//                }
//
////                header.tracks = section.items as? Track
//                return header
//
//            }
//        }
//    }
//
//    // initialize snapshot
//    func reloadData(){
//        var snapshot = NSDiffableDataSourceSnapshot<LibObject, LibItem>()
//        guard let section = section else { return }
//
//        snapshot.appendSections(section)
//
//        for section in section {
//            snapshot.appendItems(section.items!, toSection: section)
//        }
//
//        dataSource?.apply(snapshot)
//    }
//
//
//    // create compositional layout
//    func createCompositionalLayout() -> UICollectionViewLayout {
//        let compositionalLayout = UICollectionViewCompositionalLayout {
//            index, layoutEnvironment in
//
//            return LayoutManager.createTableLayout(using: self.section ?? LibItem.self)
//
//        }
//
//        return compositionalLayout
//    }
//
//}
