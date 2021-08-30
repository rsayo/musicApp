//
//  CollectionViewCells.swift
//  spotlight
//
//  Created by Robert Aubow on 8/14/21.
//

import Foundation
import UIKit

class FeaturedHeader: UICollectionViewCell, SelfConfigureingCell{
        
    static var reuseIdentifier: String = "Featured Header"
    
    var tapGesture = ImgGestureRecognizer()
    var NavVc: UINavigationController?
    
    let tagline = UILabel()
    let image = UIImageView()
    let title = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        
        title.font = UIFont.boldSystemFont(ofSize: 20)
        
        let stackview = UIStackView(arrangedSubviews: [image])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackview)
        
        NSLayoutConstraint.activate([
            stackview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackview.topAnchor.constraint(equalTo: contentView.topAnchor),
        ])
        
        stackview.axis = .vertical
        stackview.spacing = 10
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func configure(with catalog: Catalog, rootVc: UINavigationController?) {
        self.NavVc = rootVc
        
        image.image = UIImage(named: catalog.imgURL)
        tapGesture = ImgGestureRecognizer(target: self, action: #selector(presentVc(_:)))
        tapGesture.albumId = catalog.id
        image.addGestureRecognizer(tapGesture)
        
        title.text = catalog.title
    }
//
//    func presentTrackOverview( AlbumId: String?, TrackId: String?, Artist: Artist?){
//        let view = TrackOverviewController()
//
//        view.getAlbumDetail(albumId: AlbumId!)
//        view.getTracks(albumId: AlbumId!)
////
//        print("presenting...")
//        NavVc!.pushViewController(view, animated: true)
//    }
    
    @objc func presentVc(_ sender: ImgGestureRecognizer){
        let view = OverViewController()
        view.albumId = sender.albumId
//        view.getAlbumDetail(albumId: sender.albumId!)
//        view.getTracks(albumId: sender.albumId!)
        
        print("presenting...")
        NavVc!.pushViewController(view, animated: true)
        
    }
}
class ArtistSection: UICollectionViewCell,  SelfConfigureingCell{
    
    static var reuseIdentifier: String = "Artist Section"
    
    var NavVc: UINavigationController?
    
    let image = UIImageView()
    let label = UILabel()
    
    let artistAvi = AViCard()
    
    var stackview: UIStackView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
//        image.layer.cornerRadius = 20
//        image.clipsToBounds = true
//        image.contentMode = .scaleAspectFit
//        image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)

//        label.textColor = .white
//        label.font = UIFont.boldSystemFont(ofSize: 12)
        
        stackview = UIStackView(arrangedSubviews: [artistAvi])
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackview)
        
//        stackview.backgroundColor = .red
        
        NSLayoutConstraint.activate([
            stackview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackview.topAnchor.constraint(equalTo: contentView.topAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    func configure(with catalog: Catalog, rootVc: UINavigationController?){
        
        self.NavVc = rootVc
//        image.image = UIImage(named: catalog.imgURL)
//        label.text = catalog.artist
    
        print("Seting up Artist")
        artistAvi.configureCard(img: catalog.imgURL, name: catalog.artist)
        print(catalog)
    }
    
    func presenter(with rootVc: UINavigationController) {
        
    }
}
class TrendingSection: UICollectionViewCell, SelfConfigureingCell{
    
    static let reuseIdentifier: String = "Trending"
    
    let chartPosition = UILabel()
    let image = UIImageView()
    let title = UILabel()
    let artist = UILabel()
    let listenCount = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        title.setFont(with: 15)
        
        artist.setFont(with: 15)
        artist.textColor = .secondaryLabel
        
        listenCount.setFont(with: 15)
        listenCount.textColor = .secondaryLabel
        
        let innterStackview = UIStackView(arrangedSubviews: [title, artist])
        innterStackview.axis = .vertical
        innterStackview.translatesAutoresizingMaskIntoConstraints = false
        
        let stackview = UIStackView(arrangedSubviews: [image, innterStackview, listenCount] )
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.distribution = .fill
        stackview.spacing = 10
        
        addSubview(stackview)
        
        NSLayoutConstraint.activate([
            
            image.heightAnchor.constraint(equalToConstant: 100),
            image.widthAnchor.constraint(equalToConstant: 50),
            
            stackview.topAnchor.constraint(equalTo: topAnchor),
            stackview.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackview.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackview.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            listenCount.leadingAnchor.constraint(equalTo: stackview.trailingAnchor, constant: -100)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func configure(with catalog: Catalog, rootVc: UINavigationController?) {
        chartPosition.text = "1"
        image.image = UIImage(named: catalog.imgURL)
        title.text = catalog.title
        artist.text = catalog.artist
        listenCount.text = catalog.playCount!
    }
    
    func presenter(with rootVc: UINavigationController) {
        
    }
}
class MediumImageSlider: UICollectionViewCell, SelfConfigureingCell{
    func presenter(with rootVc: UINavigationController) {
        
    }
    
    static let reuseIdentifier: String = "MediumSlider"
    
    let image = UIImageView()
    let artist = UILabel()
    let title = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        artist.textColor = .secondaryLabel
//        artist.translatesAutoresizingMaskIntoConstraints = false
        artist.setFont(with: 15)
        
        title.textColor = .label
        
//        title.translatesAutoresizingMaskIntoConstraints = false
        
        let stackview = UIStackView(arrangedSubviews: [image, title, artist])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.alignment = .leading
        
        addSubview(stackview)
        NSLayoutConstraint.activate([
            
            image.heightAnchor.constraint(equalToConstant: 150),
            image.widthAnchor.constraint(equalToConstant: 150),
//            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            
//            artist.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            
            stackview.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackview.topAnchor.constraint(equalTo: topAnchor),
            stackview.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackview.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
//        stackview.spacing = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func configure(with catalog: Catalog, rootVc: UINavigationController?) {
        image.image = UIImage(named: catalog.imgURL)
        title.text = catalog.title
        artist.text = catalog.artist
    }
    
}
class PlayerContainerSection: UICollectionViewCell, PlayerConfiguration{
    
    static let reuseIdentifier: String = "TrackPlayer"
    var backgroundImg: UIImageView?
        
    let container = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundImg = UIImageView(frame: CGRect(x: 0, y: 0, width: 500, height: contentView.frame.height))
        backgroundImg?.contentMode = .scaleAspectFill
        
        contentView.addSubview(backgroundImg!)
        contentView.addSubview(container)
    }
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func configure(with player: Queue, rootVc: UINavigationController?) {
        backgroundImg?.image = UIImage(named: "6lack")
    }
}

// Track Overview Cells
class TrackImageHeader: UICollectionReusableView{
    static let reuseableIdentifier: String = "image Header"
    
    let title = UILabel()
    let tagline = UILabel()
    let image = UIImageView()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
//        let seperator = UIView(frame: .zero)
//        seperator.backgroundColor = .quaternaryLabel
        
        title.textColor = .white
        title.setFont(with: 35)
//        title.text = "6lack"
        
        tagline.textColor = .white
        tagline.font = UIFont.boldSystemFont(ofSize: 33)
        tagline.numberOfLines = 0
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        
        let stackView = UIStackView(arrangedSubviews: [title, tagline])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
//        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        
        let primaryStack = UIStackView(arrangedSubviews: [image, stackView])
        primaryStack.axis = .vertical
        primaryStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(primaryStack)
        
        NSLayoutConstraint.activate([
//            seperator.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.topAnchor.constraint(equalTo: topAnchor, constant: -6),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupGradientLayer(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1]
        
        layer.addSublayer(gradientLayer)
        
        
    }
    
}
class TrackOverviewSectionHeader: UICollectionReusableView{
    static let reuseableIdentifier: String = "Overview Header"
    
    let title = UILabel()
    let tagline = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        let seperator = UIView(frame: .zero)
        seperator.backgroundColor = .quaternaryLabel
        
        title.textColor = .label
        title.setFont(with: 15)
        
        tagline.textColor = .secondaryLabel
        tagline.font = UIFont.boldSystemFont(ofSize: 20)
        
        let stackView = UIStackView(arrangedSubviews: [title, tagline, seperator])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
//
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            seperator.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
//
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
class TrackDetailCell: UICollectionViewCell, DetailCell {
    static var reuseableIdentifier: String = "main"
    
//    let container = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    let image = UIImageView()
    let artist = UILabel()
    let name = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        image.contentMode = .scaleAspectFill
        image.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        
        name.textColor = .label
        name.setFont(with: 15)
        artist.textColor = .secondaryLabel
        
        let labelStack = UIStackView(arrangedSubviews: [name, artist])
        labelStack.axis = .vertical
        
        let horizontalStack = UIStackView(arrangedSubviews: [image, labelStack])
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.distribution = .fill
        
        horizontalStack.spacing = 25
        
        addSubview(horizontalStack)
        
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 100),
            image.widthAnchor.constraint(equalToConstant: 50),
            
            horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            horizontalStack.topAnchor.constraint(equalTo: topAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError(" coder was not initialized")
    }
    
    func configure(with trackItem: TrackItem) {
        image.image = UIImage(named: trackItem.imageURL)
        artist.text = trackItem.artist
        name.text = trackItem.title
    }
    
    
}
class AlbumCollectionCell: UICollectionViewCell, DetailCell{
    static var reuseableIdentifier: String = "albums"
    
    let image = UIImageView()
    let artist = UILabel()
    let title = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
     
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        artist.textColor = .secondaryLabel
//        artist.translatesAutoresizingMaskIntoConstraints = false
        artist.setFont(with: 15)

        title.textColor = .label

//        title.translatesAutoresizingMaskIntoConstraints = false

        let stackview = UIStackView(arrangedSubviews: [image, title, artist])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.alignment = .leading

        addSubview(stackview)
        NSLayoutConstraint.activate([

            image.heightAnchor.constraint(equalToConstant: 150),
            image.widthAnchor.constraint(equalToConstant: 150),
//            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),

//            artist.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),

            stackview.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackview.topAnchor.constraint(equalTo: topAnchor),
            stackview.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackview.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func configure(with trackItem: TrackItem) {
        image.image = UIImage(named: trackItem.imageURL)
        artist.text = trackItem.artist
        title.text = trackItem.title
    }
    

}
class TrackRelatedArtistSEction: UICollectionViewCell, DetailCell {
    static var reuseableIdentifier: String = "Artist Recommendation"
    
    let image = UIImageView()
    let label = UILabel()
    
    let artistAvi = AViCard()
    
    var stackview: UIStackView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        stackview = UIStackView(arrangedSubviews: [artistAvi])
        stackview.axis = .horizontal
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackview)
        
        
        NSLayoutConstraint.activate([
            stackview.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackview.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stackview.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("")
    }
    func configure(with trackItem: TrackItem) {
        print("Seting up Artist")
        artistAvi.configureCard(img: trackItem.imageURL, name: trackItem.artist)
    }
}

// To Do: Conver to UIcollectionview cell
// Player cell
class PlayerView {
    
    
}
class TrackHistorySection: UICollectionViewCell, SelfConfigureingCell{
    func presenter(with rootVc: UINavigationController) {
        
    }
    
    static let reuseIdentifier: String = "History"
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func configure(with catalog: Catalog, rootVc: UINavigationController?) {
        
    }
}

class SectionHeader: UICollectionReusableView {
    
    static let reuseIdentifier: String = "sectionHeader"
    
    let title = UILabel()
    let tagline = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        let seperator = UIView(frame: .zero)
        seperator.backgroundColor = .quaternaryLabel
        
        title.textColor = .label
        title.setFont(with: 15)
        
        tagline.textColor = .secondaryLabel
        tagline.font = UIFont.boldSystemFont(ofSize: 20)
        
        let stackView = UIStackView(arrangedSubviews: [title, tagline, seperator])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        addSubview(stackView)
//        stackView.backgroundColor = .red
        stackView.spacing = 5
        
        NSLayoutConstraint.activate([
            
            seperator.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
            
        ])
        
//        stackView.setcus
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    
    
}
