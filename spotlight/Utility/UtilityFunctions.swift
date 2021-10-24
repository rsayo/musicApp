//
//  UtilityFunctions.swift
//  spotlight
//
//  Created by Robert Aubow on 7/2/21.
//

import Foundation
import  UIKit

protocol SelfConfigureingCell {
    static var reuseIdentifier: String { get }
    func configure(with catalog: LibItem, rootVc: UINavigationController?, indexPath: Int?)
}
protocol CellConfigurer {
    static var reuseIdentifier: String { get }
    func configure(item: LibItem, vc: UINavigationController?, indexPath: Int?)
}
protocol DetailCell {
    static var reuseableIdentifier: String { get }
    func configure(with trackItem: AlbumItems, rootVc: UINavigationController?, indexPath: IndexPath?)
}
protocol ProfileSectionConfigurer {
    static var reuseIdentifier: String { get }
    func configure(with item: ProfileItem)
}
protocol PlayerConfiguration {
    static var reuseIdentifier: String { get }
    func configure(with player: Queue, rootVc: UINavigationController?)
}

class ImgGestureRecognizer: UITapGestureRecognizer{
    var albumId: String?
    var artist: String?
    var track: Song?
    var id: String?
}

class LayoutManager {
    
    // Sections Layout
    static func createFeaturedHeader(using: Any) -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    
        let layoutItems = NSCollectionLayoutItem(layoutSize: itemSize)

        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .estimated(320))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItems])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 20)
        layoutSection.orthogonalScrollingBehavior = .groupPaging
        
        let sectionheader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [sectionheader]
        print("configured header layout")
        return layoutSection
        
    }
    static func createAviSliderSection(using: Any) -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    
        let layoutItems = NSCollectionLayoutItem(layoutSize: itemSize)

        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .estimated(100))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItems])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 20)
        layoutSection.orthogonalScrollingBehavior = .continuous
        
        let sectionheader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [sectionheader]
        
        print("configuredd artist section layout")
        return layoutSection
    }
    static func createTrendingSection(using: Any) -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.20))
        let items = NSCollectionLayoutItem(layoutSize: itemSize)
        items.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 10)
    
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalHeight(0.35))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [items])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 20)
        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        print("configured layout for collection Section")
        
        let sectionheader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [sectionheader]
        
        return layoutSection
    }
    static func createMediumImageSliderSection(using: Any) -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let items = NSCollectionLayoutItem(layoutSize: itemSize)
        items.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.42), heightDimension: .fractionalHeight(0.23))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [items])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10)
        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        print("configured layout for History Section")
        
        let sectionheader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [sectionheader]
        
        return layoutSection
    }
    static func createTableLayout(using: Any) -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let items = NSCollectionLayoutItem(layoutSize: itemSize)
        items.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 15, trailing: 10)
    
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.07))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [items])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        print("configured layout for History Section")
        
        let sectionheaderImage = createAlbumHeader()
        layoutSection.boundarySupplementaryItems = [sectionheaderImage]
//
        return layoutSection
    }
    static func createSmallProfileTableLayout(using: Any) -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.20))
        let items = NSCollectionLayoutItem(layoutSize: itemSize)
        items.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
    
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalHeight(0.35))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [items])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 20)
        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        print("configured layout for collection Section")
        
        let sectionheader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [sectionheader]
        
        return layoutSection
    }
    
    // Header Layout
    static func createHeaderLayout(using: Any) -> NSCollectionLayoutSection{
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: size)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(350))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0)
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        
        return layoutSection
    }
    
    static func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem{
        let layout = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
      
        let supplementoryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layout, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return supplementoryItem
    }
    static func createAlbumHeader() -> NSCollectionLayoutBoundarySupplementaryItem{
        let layout = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.73))
        
        let supplementoyItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layout, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return supplementoyItem
    }
    static func createProfileHeaderLayout() -> NSCollectionLayoutBoundarySupplementaryItem {
        let item = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.60))
        
        let supplementoryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: item, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return supplementoryItem
    }
}

extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}