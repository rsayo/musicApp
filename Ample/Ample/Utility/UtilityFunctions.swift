//
//  UtilityFunctions.swift
//  spotlight
//
//  Created by Robert Aubow on 7/2/21.
//

import Foundation
import  UIKit


class CustomGestureRecognizer: UITapGestureRecognizer{
    var id: String?
    var track: Track?
    var tracks: [Track]?
    var video: VideoItemModel?
}

class LayoutManager {
    
    // Sections Layout
    static func createFeaturedHeader(using: Any) -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    
        let layoutItems = NSCollectionLayoutItem(layoutSize: itemSize)

        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .estimated(200))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItems])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 10)
        layoutSection.orthogonalScrollingBehavior = .groupPaging
        
        let sectionheader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [sectionheader]
        print("configured header layout")
        return layoutSection
        
    }
    static func createFeaturedVideoHeader(using: Any) -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    
        let layoutItems = NSCollectionLayoutItem(layoutSize: itemSize)

        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .estimated(200))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItems])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20)
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
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20)
        layoutSection.orthogonalScrollingBehavior = .continuous
        
        let sectionheader = createSectionHeaderWithButton()
        layoutSection.boundarySupplementaryItems = [sectionheader]
        
        print("configuredd artist section layout")
        return layoutSection
    }
    static func createTrendingSection(using: Any) -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.20))
        let items = NSCollectionLayoutItem(layoutSize: itemSize)
        items.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
    
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .fractionalHeight(0.30))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [items])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20)
        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        print("configured layout for collection Section")
        
        let sectionheader = createSectionHeaderWithButton()
        layoutSection.boundarySupplementaryItems = [sectionheader]
        
        return layoutSection
    }
    static func createMediumImageSliderSection(using: Any) -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let items = NSCollectionLayoutItem(layoutSize: itemSize)
        items.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.36), heightDimension: .fractionalHeight(0.20))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [items])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 10)
        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        print("configured layout for History Section")
        
        let sectionheader = createSectionHeaderWithButton()
        layoutSection.boundarySupplementaryItems = [sectionheader]
        
        return layoutSection
    }
    static func twoRowCollectionSlider(using: Any) -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.50))
        let items = NSCollectionLayoutItem(layoutSize: itemSize)
        items.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 10)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.36), heightDimension: .fractionalHeight(0.45))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [items])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 10)
        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        print("configured layout for History Section")
        
        let sectionheader = createSectionHeaderWithButton()
        layoutSection.boundarySupplementaryItems = [sectionheader]
        
        return layoutSection
    }
    static func createTableLayout(using: Any) -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let items = NSCollectionLayoutItem(layoutSize: itemSize)
        items.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 2, trailing: 10)
    
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.07))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [items])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
        
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
    static func createWideLayout(using: Any) -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: size)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.55), heightDimension: .fractionalHeight(0.17))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 10)
        
        
        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]
        
        return section
        
    }
    static func largeImageLayout(using: Any) -> NSCollectionLayoutSection {
        
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.40), heightDimension: .fractionalHeight(0.25))
//        let group = NSCollectionLayoutGroup(layoutSize: groupSize)
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: layoutGroup)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20)
        
        let sectionheader = createSectionHeaderWithButton()
        section.boundarySupplementaryItems = [sectionheader]
        
        return section
        
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
    
    // ReusableViews
    static func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem{
        let layout = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
      
        let supplementoryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layout, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return supplementoryItem
    }
    static func createSectionHeaderWithButton() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layout = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
      
        let supplementoryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layout, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return supplementoryItem
    }
    static func createAlbumHeader() -> NSCollectionLayoutBoundarySupplementaryItem{
        let layout = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.74))
        
        let supplementoyItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layout, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return supplementoyItem
    }
    static func createProfileHeaderLayout() -> NSCollectionLayoutBoundarySupplementaryItem {
        let item = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.90))
        
        let supplementoryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: item, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return supplementoryItem
    }
    
    static func configureCell<T: Cell>(collectionView: UICollectionView, navigationController: UINavigationController?, _ cellType: T.Type, with item: LibItem, indexPath: IndexPath) -> T{
        print("Configureing cell")

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("could not configure cell")
        }
        
        cell.configure(with: item, rootVc: navigationController, indexPath: indexPath.row)
        
        return cell

    }
    
    static func configureVideoCell<T: VideoCell>(collectionView: UICollectionView, navigationController: UINavigationController?, _ cellType: T.Type, with item: VideoItemModel, indexPath: IndexPath) -> T{

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("could not configure cell")
        }
        
        cell.configure(with: item, navigationController: navigationController!)
        
        return cell

    }
    
}
