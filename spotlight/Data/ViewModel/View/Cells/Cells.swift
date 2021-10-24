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
            stackview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
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
    
    func configure(with catalog: LibItem, rootVc: UINavigationController?, indexPath: Int?) {
        self.NavVc = rootVc
        
        image.image = UIImage(named: catalog.imageURL)
        tapGesture = ImgGestureRecognizer(target: self, action: #selector(presentVc(_:)))
        tapGesture.albumId = catalog.albumId
        image.addGestureRecognizer(tapGesture)
        
        title.text = catalog.title
    }
    
    @objc func presentVc(_ sender: ImgGestureRecognizer){
        let view = OverViewController()
        view.albumId = sender.albumId
        
        print("presenting...")
        NavVc!.title = "Featured"
        NavVc!.pushViewController(view, animated: true)
        
    }
}
class ArtistSection: UICollectionViewCell,  SelfConfigureingCell{
    
    static var reuseIdentifier: String = "Artist Section"
    
    var NavVc: UINavigationController?
    var tapGesture: ImgGestureRecognizer!
    
    let image = UIImageView()
    let label = UILabel()
    
    let artistAvi = AViCard()
    
    var stackview: UIStackView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        image.isUserInteractionEnabled = true
        stackview = UIStackView(arrangedSubviews: [artistAvi])
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackview)
        
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
    
    func configure(with catalog: LibItem, rootVc: UINavigationController?, indexPath: Int?){
        
        self.NavVc = rootVc
    
        
        print("Seting up Artist")
        artistAvi.configureCard(img: catalog.imageURL, name: catalog.name!)
        print(catalog)
        
        tapGesture = ImgGestureRecognizer(target: self, action: #selector(presentView(_sender:)))
        tapGesture.id = catalog.id
        artistAvi.addGestureRecognizer(tapGesture)
    }
    
    @objc func presentView(_sender: ImgGestureRecognizer) {
        let view = Profile()
        view.artistId = _sender.id
        
        NavVc?.pushViewController(view, animated: true)
        
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
        
        title.setFont(with: 12)
        
        artist.setFont(with: 10)
        artist.textColor = .secondaryLabel
        
        listenCount.setFont(with: 10)
        listenCount.textColor = .secondaryLabel
        
        
        chartPosition.setFont(with: 10)
        chartPosition.textColor = .secondaryLabel
        
        let innterStackview = UIStackView(arrangedSubviews: [title, artist])
        innterStackview.axis = .vertical
        innterStackview.translatesAutoresizingMaskIntoConstraints = false
        
        let stackview = UIStackView(arrangedSubviews: [chartPosition, image, innterStackview, listenCount] )
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.distribution = .fillProportionally
        stackview.spacing = 10
        
        addSubview(stackview)
        
        NSLayoutConstraint.activate([
            
            image.heightAnchor.constraint(equalToConstant: 100),
            image.widthAnchor.constraint(equalToConstant: 50),
            
            
            
            stackview.topAnchor.constraint(equalTo: topAnchor),
            stackview.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackview.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            chartPosition.trailingAnchor.constraint(equalTo: image.leadingAnchor, constant: -20),
            chartPosition.widthAnchor.constraint(equalToConstant: 5),
            
            listenCount.leadingAnchor.constraint(equalTo: stackview.trailingAnchor, constant: -38)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func configure(with catalog: LibItem, rootVc: UINavigationController?, indexPath: Int?) {
        chartPosition.text = String(indexPath! + 1)
        image.image = UIImage(named: catalog.imageURL)
        title.text = catalog.title
        artist.text = catalog.artist
        listenCount.text = catalog.playCount!
    }
    
    func presenter(with rootVc: UINavigationController) {
        
    }
}
class MediumImageSlider: UICollectionViewCell, SelfConfigureingCell{
    
    static let reuseIdentifier: String = "MediumSlider"
    
    var vc: UINavigationController?
    var tapgesture: ImgGestureRecognizer?
    
    let image = UIImageView()
    let artist = UILabel()
    let title = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        
        artist.textColor = .secondaryLabel
        artist.translatesAutoresizingMaskIntoConstraints = false
        artist.setFont(with: 10)
        
        title.textColor = .label
        title.setFont(with: 12)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        let stackview = UIStackView(arrangedSubviews: [image, title, artist])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.alignment = .leading
        stackview.spacing = 0
        
        addSubview(stackview)
        NSLayoutConstraint.activate([
            
            stackview.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackview.topAnchor.constraint(equalTo: topAnchor),
            stackview.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackview.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            image.heightAnchor.constraint(equalToConstant: 150),
            image.widthAnchor.constraint(equalToConstant: 150),
            
//            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 0),
            
            artist.topAnchor.constraint(equalTo: title.bottomAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func configure(with catalog: LibItem, rootVc: UINavigationController?, indexPath: Int?) {
        
        vc = rootVc!
        
        tapgesture = ImgGestureRecognizer(target: self, action: #selector(presenter(_sender:)))
        tapgesture!.albumId = catalog.id
        
        addGestureRecognizer(tapgesture!)
        
        image.image = UIImage(named: catalog.imageURL)
        title.text = catalog.title
        artist.text = catalog.artist
    }
    
    @objc func presenter(_sender: ImgGestureRecognizer) {
        
//        print(_sender.albumId)
//        let view = OverViewController()
//        view.albumId = _sender.albumId
//
//        vc?.pushViewController(view, animated: true)
        
    }
}
class TrackHistorySlider: UICollectionViewCell, SelfConfigureingCell {
    
    static let reuseIdentifier: String = "History cell"
    
    var vc: UINavigationController?
    var tapgesture: ImgGestureRecognizer?
    
    let image = UIImageView()
    let artist = UILabel()
    let title = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        
        artist.textColor = .secondaryLabel
        artist.translatesAutoresizingMaskIntoConstraints = false
        artist.setFont(with: 10)
        
        title.textColor = .label
        title.setFont(with: 12)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        let stackview = UIStackView(arrangedSubviews: [image, title, artist])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.alignment = .leading
        stackview.spacing = 0
        
        addSubview(stackview)
        NSLayoutConstraint.activate([
            
            stackview.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackview.topAnchor.constraint(equalTo: topAnchor),
            stackview.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackview.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            image.heightAnchor.constraint(equalToConstant: 150),
            image.widthAnchor.constraint(equalToConstant: 150),
            
            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 0),
            
            artist.topAnchor.constraint(equalTo: title.bottomAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func configure(with catalog: LibItem, rootVc: UINavigationController?, indexPath: Int?) {
        
        vc = rootVc!
        
        tapgesture = ImgGestureRecognizer(target: self, action: #selector(presenter(_sender:)))
        tapgesture!.albumId = catalog.id
        
        addGestureRecognizer(tapgesture!)
        
        image.image = UIImage(named: catalog.imageURL)
        title.text = catalog.title
        artist.text = catalog.artist
    }
    
    @objc func presenter(_sender: ImgGestureRecognizer) {
        print("History Track")
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
class TrackDetailStrip: UICollectionViewCell, DetailCell  {
    static var reuseableIdentifier: String = "track"
    var image = UIImageView()
    var artist = UILabel()
    var name = UILabel()
    let trackNumber = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        image.contentMode = .scaleAspectFill
        image.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        
        name.textColor = .label
        name.setFont(with: 15)
        
        artist.textColor = .secondaryLabel
        artist.setFont(with: 10)
        
        trackNumber.translatesAutoresizingMaskIntoConstraints = false
        trackNumber.setFont(with: 10)
        trackNumber.textColor = .secondaryLabel
//        trackNumber.backgroundColor = .red
        
        let labelStack = UIStackView(arrangedSubviews: [name, artist])
        labelStack.axis = .vertical
        
        let horizontalStack = UIStackView(arrangedSubviews: [trackNumber, image, labelStack])
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.distribution = .fillProportionally
        
        horizontalStack.spacing = 25

        
        addSubview(horizontalStack)
        
        NSLayoutConstraint.activate([
            
            image.heightAnchor.constraint(equalToConstant: 50),
            image.widthAnchor.constraint(equalToConstant: 50),
            
            image.leadingAnchor.constraint(equalTo: trackNumber.trailingAnchor, constant: 7),
            
            trackNumber.widthAnchor.constraint(equalToConstant: 18 ),
            horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            horizontalStack.topAnchor.constraint(equalTo: topAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    func configure(with trackItem: AlbumItems, rootVc: UINavigationController?,indexPath: IndexPath?) {
        let index = Int(indexPath!.row) + 1
        image.image = UIImage(named: trackItem.imageURL!)
        name.text = trackItem.title
        artist.text = trackItem.artist
        trackNumber.text = String(index)
    }
    
}

class AlbumCollectionCell: UICollectionViewCell, DetailCell{

    
    static var reuseableIdentifier: String = "albums"
    
    var vc: UINavigationController?
    var tapgesture: ImgGestureRecognizer?
    
    let image = UIImageView()
    let artist = UILabel()
    let title = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
     
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        
        artist.textColor = .secondaryLabel
        artist.setFont(with: 15)

        title.textColor = .label
        title.setFont(with: 12)

        let stackview = UIStackView(arrangedSubviews: [image, title])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.alignment = .leading

        addSubview(stackview)
        NSLayoutConstraint.activate([

            image.heightAnchor.constraint(equalToConstant: 150),
            image.widthAnchor.constraint(equalToConstant: 150),
            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 0),

//            artist.topAnchor.constraint(equalTo: title.bottomAnchor, constant: -20),

            stackview.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackview.topAnchor.constraint(equalTo: topAnchor),
            stackview.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackview.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func configure(with trackItem: AlbumItems, rootVc: UINavigationController?, indexPath: IndexPath?) {
        vc = rootVc!
        
        image.image = UIImage(named: trackItem.imageURL!)
        artist.text = trackItem.artist
        title.text = trackItem.title
        tapgesture = ImgGestureRecognizer(target: self, action: #selector(present))
        tapgesture?.albumId = trackItem.id
        image.addGestureRecognizer(tapgesture!)
    }
    
    @objc func present(_sender: ImgGestureRecognizer){
        let view = OverViewController()
        
        view.albumId = _sender.albumId
        vc?.pushViewController(view, animated: true)
    }
}
class TrackRelatedArtistSEction: UICollectionViewCell, DetailCell {

    static var reuseableIdentifier: String = "Artist Recommendation"

    var vc: UINavigationController?
    var tapGesture: ImgGestureRecognizer?
    
    let image = UIImageView()
    let label = UILabel()
    
    let artistAvi = AViCard()
    
    var stackview: UIStackView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        artistAvi.isUserInteractionEnabled = true
        
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

    func configure(with trackItem: AlbumItems, rootVc: UINavigationController?, indexPath: IndexPath?) {
        
        print("Seting up Artist")
        
        artistAvi.configureCard(img: trackItem.imageURL!, name: trackItem.name!)
        vc = rootVc
        print(trackItem)
        tapGesture = ImgGestureRecognizer(target: self, action: #selector(present))
        tapGesture?.id = trackItem.id
        artistAvi.addGestureRecognizer(tapGesture!)

    }
    @objc func present(_sender: ImgGestureRecognizer){

        let view = Profile()
        view.artistId = _sender.id
        vc?.pushViewController(view, animated: true)
    }
}

// headers
class DetailHeader: UICollectionReusableView{
    
    static let reuseableIdentifier: String = "image Header"
    
    var vc: UINavigationController?
    var tapGesture: ImgGestureRecognizer?
    
    let artistId = String()
    
    // labels
    let title = UILabel() // Title
    let artist = UILabel() //
    let pageTag = UILabel()
    
    // Images
    let albumImage = UIImageView()
    let artistAviImage = UIImageView()
    
    // buttons
    let playBtn = UIButton()
    let shuffleBtn = UIButton()
    let followBtn = UIButton()
    let saveBtn = UIButton()
    let optionsBtn = UIButton()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        let seperator = UIView(frame: .zero)
        seperator.backgroundColor = .quaternaryLabel
        
        title.textColor = .white
        title.setFont(with: 20)
        title.numberOfLines = 0
        
        artist.textColor = .label
        artist.setFont(with: 15)
        
        artistAviImage.layer.borderWidth = 1
        artistAviImage.contentMode = .scaleAspectFill
        artistAviImage.translatesAutoresizingMaskIntoConstraints = false
        artistAviImage.clipsToBounds = true
        artistAviImage.layer.cornerRadius = 16
        artistAviImage.isUserInteractionEnabled = true
        
        tapGesture = ImgGestureRecognizer(target: self, action: #selector(presentProfile(_sender:)))
        artistAviImage.addGestureRecognizer(tapGesture!)
        
        albumImage.translatesAutoresizingMaskIntoConstraints = false
        albumImage.contentMode = .scaleAspectFill
        albumImage.clipsToBounds = true
        albumImage.layer.cornerRadius = 10
        
        // btns
        followBtn.setTitle("Follow", for: .normal)
        followBtn.setTitleColor(UIColor.init(displayP3Red: 255 / 255, green: 227 / 255, blue: 77 / 255, alpha: 0.5), for: .normal)
        followBtn.titleLabel?.setFont(with: 10)
        followBtn.layer.borderWidth = 1
        followBtn.layer.borderColor = UIColor.init(displayP3Red: 255 / 255, green: 227 / 255, blue: 77 / 255, alpha: 0.5).cgColor
        followBtn.layer.cornerRadius = 3
        
        optionsBtn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        optionsBtn.setTitleColor(UIColor.init(displayP3Red: 255 / 255, green: 227 / 255, blue: 77 / 255, alpha: 0.5), for: .normal)
        
        playBtn.setTitle("Play All", for: .normal)
        playBtn.layer.borderWidth = 1
        playBtn.layer.borderColor = UIColor.init(displayP3Red: 255 / 255, green: 227 / 255, blue: 77 / 255, alpha: 0.5).cgColor
        playBtn.layer.cornerRadius = 3
        playBtn.setTitleColor(UIColor.init(displayP3Red: 255 / 255, green: 227 / 255, blue: 77 / 255, alpha: 0.5), for: .normal)
        playBtn.titleLabel?.setFont(with: 15)
        
        shuffleBtn.setTitle("Shuffle", for: .normal)
        shuffleBtn.layer.borderWidth = 1
        shuffleBtn.layer.borderColor = UIColor.init(displayP3Red: 255 / 255, green: 227 / 255, blue: 77 / 255, alpha: 0.5).cgColor
        shuffleBtn.layer.cornerRadius = 3
        shuffleBtn.setTitleColor(UIColor.init(displayP3Red: 255 / 255, green: 227 / 255, blue: 77 / 255, alpha: 0.5), for: .normal)
        shuffleBtn.titleLabel?.setFont(with: 15)
        
        pageTag.textColor = .secondaryLabel
        
        
        let btnStack = UIStackView(arrangedSubviews: [pageTag])
        btnStack.axis = .horizontal
        btnStack.translatesAutoresizingMaskIntoConstraints = false
        btnStack.distribution = .fillEqually
        
        let TirtiaryStack = UIStackView(arrangedSubviews: [pageTag, btnStack])
        TirtiaryStack.axis = .horizontal
        TirtiaryStack.translatesAutoresizingMaskIntoConstraints = false
        TirtiaryStack.distribution = .equalSpacing
        
        let SecondaryStack = UIStackView(arrangedSubviews: [artistAviImage, artist, followBtn])
        SecondaryStack.axis = .horizontal
        SecondaryStack.alignment = .center
        SecondaryStack.spacing = 10
        
        let playBtnStack = UIStackView(arrangedSubviews: [playBtn, shuffleBtn])
        playBtnStack.alignment = .center
        playBtnStack.axis = .horizontal
        playBtnStack.distribution = .fillProportionally
        playBtnStack.spacing = 10
        
        let ContainerStack = UIStackView(arrangedSubviews: [optionsBtn, playBtnStack, title, SecondaryStack, seperator, TirtiaryStack ])
        ContainerStack.translatesAutoresizingMaskIntoConstraints = false
        ContainerStack.axis = .vertical
        ContainerStack.spacing = 10
        
        
        addSubview(albumImage)
        
        addSubview(ContainerStack)
        
        NSLayoutConstraint.activate([
            seperator.heightAnchor.constraint(equalToConstant: 1),
            
            albumImage.heightAnchor.constraint(equalToConstant: 355),
            albumImage.widthAnchor.constraint(equalToConstant: 350),
            albumImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            albumImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            albumImage.topAnchor.constraint(equalTo: topAnchor),

            artistAviImage.heightAnchor.constraint(equalToConstant: 30),
            artistAviImage.widthAnchor.constraint(equalToConstant: 30),
            
            followBtn.widthAnchor.constraint(equalToConstant: 75),
            
            ContainerStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            ContainerStack.topAnchor.constraint(equalTo: albumImage.bottomAnchor, constant: 20),
            ContainerStack.trailingAnchor.constraint(equalTo: albumImage.trailingAnchor),
            
            btnStack.trailingAnchor.constraint(equalTo: ContainerStack.trailingAnchor),
            optionsBtn.trailingAnchor.constraint(equalTo: ContainerStack.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func presentProfile(_sender: ImgGestureRecognizer){
        print(artistId)
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
        title.setFont(with: 10)
        
        tagline.textColor = .secondaryLabel
        tagline.font = UIFont.boldSystemFont(ofSize: 17)
        
        let stackView = UIStackView(arrangedSubviews: [title, tagline, seperator])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        addSubview(stackView)
//        stackView.backgroundColor = .red
        stackView.spacing = 5
        
        NSLayoutConstraint.activate([
            
            seperator.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
      
}

// Profile VC Components
class ProfileHeader: UICollectionViewCell, CellConfigurer {
    
    static var reuseIdentifier: String =  "profile Header"
    
    var image = UIImageView()
    var name = UILabel()
    var artistAvi = UIImageView()
    
    let followBtn = UIButton()
    let optionsBtn = UIButton()
    let verifiedIcon = UIButton()
    
    let listener = UILabel()

    let container = UIView(frame: .zero)
    
    var stack = UIStackView()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
//        let seperator = UIView(frame: .zero)
//        seperator.backgroundColor = .quaternaryLabel
//
        name.setFont(with: 30)
        name.translatesAutoresizingMaskIntoConstraints = false

        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        
        addSubview(image)
        
        image.topAnchor.constraint(equalTo: topAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
         
        followBtn.setTitle("Follow", for:  .normal)
        followBtn.titleLabel!.setFont(with: 12)
        followBtn.layer.borderWidth = 1
        followBtn.layer.borderColor = UIColor.init(displayP3Red: 255 / 255, green: 227 / 255, blue: 77 / 255, alpha: 0.5).cgColor
        followBtn.setTitleColor(UIColor.init(displayP3Red: 255 / 255, green: 227 / 255, blue: 77 / 255, alpha: 0.5), for: .normal)
        followBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        followBtn.layer.cornerRadius = 5

        optionsBtn.setImage(UIImage(systemName: "ellipsis"), for: .normal)

        verifiedIcon.setImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
        verifiedIcon.titleLabel?.setFont(with: 5)
        
        listener.textColor = .secondaryLabel
        listener.setFont(with: 10)
        
        self.stack = UIStackView(arrangedSubviews: [name, followBtn])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalCentering
    
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func configure(item: LibItem, vc: UINavigationController?, indexPath: Int?) {
        
        name.text = item.artist!
        let listnersCount = NumberFormatter.localizedString(from: 23425234, number: NumberFormatter.Style.decimal)
        listener.text = "Listeners: \(listnersCount)"
    
        image.image = UIImage(named: item.imageURL)

        setupGradient()
    }
    
    func setupGradient(){
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.2, 1.3]
        
        gradientLayer.frame = frame
        
        container.frame = frame
        
        addSubview(container)
        container.layer.addSublayer(gradientLayer)
        
        let stack = UIStackView(arrangedSubviews: [name, verifiedIcon ])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 10

        let containerStack = UIStackView(arrangedSubviews: [stack, followBtn, listener ])
        containerStack.axis = .vertical
        containerStack.alignment = .leading
        containerStack.spacing = 7
        containerStack.translatesAutoresizingMaskIntoConstraints = false
    
        
        container.addSubview(containerStack)
        
        containerStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        containerStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true

    }
}
class CollectionCell: UICollectionViewCell, CellConfigurer{
    
    static var reuseIdentifier: String = "Top Tracks"
    
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
        
        artist.setFont(with: 10)
        artist.textColor = .secondaryLabel
        
        listenCount.setFont(with: 10)
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
            
            listenCount.leadingAnchor.constraint(equalTo: stackview.trailingAnchor, constant: -50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func configure(item: LibItem, vc: UINavigationController?, indexPath: Int?){
        chartPosition.text = "1"
        image.image = UIImage(named: item.imageURL)
        title.text = item.title
        artist.text = item.artist
        listenCount.text = item.playCount
    }
}
class SmallWidthCollectionCell: UICollectionViewCell, CellConfigurer{
    static var reuseIdentifier: String = "releases"
    
    let chartPosition = UILabel()
    let image = UIImageView()
    let title = UILabel()
    let artist = UILabel()
    let listenCount = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        backgroundColor = .red
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        image.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        title.setFont(with: 12)
        
        artist.setFont(with: 10)
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
            
            listenCount.leadingAnchor.constraint(equalTo: stackview.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func configure(item: LibItem, vc: UINavigationController?, indexPath: Int?){
        
        image.image = UIImage(named: item.imageURL)
        title.text = item.title
        artist.text = item.artist
        
    }
    
    
}
class LargeArtCollection: UICollectionViewCell, CellConfigurer{
    static var reuseIdentifier: String = "Albums"
    
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
        artist.setFont(with: 10)

        title.textColor = .label
        title.setFont(with: 12)

//        title.translatesAutoresizingMaskIntoConstraints = false

        let stackview = UIStackView(arrangedSubviews: [image, title])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.alignment = .leading

        addSubview(stackview)
        NSLayoutConstraint.activate([

            image.heightAnchor.constraint(equalToConstant: 150),
            image.widthAnchor.constraint(equalToConstant: 150),
            
            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: -10),
//            artist.topAnchor.constraint(equalTo: title.bottomAnchor, constant: -30),

            stackview.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackview.topAnchor.constraint(equalTo: topAnchor),
            stackview.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackview.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func configure(item: LibItem, vc: UINavigationController?, indexPath: Int?){
        image.image = UIImage(named: item.imageURL)
        artist.text = item.artist
        title.text = item.title
    }
}
class ArtistCell: UICollectionViewCell, CellConfigurer {
    static var reuseIdentifier: String = "Artist"
    
    var NavVc: UINavigationController?
    var tapGesture: ImgGestureRecognizer!
    
    let image = UIImageView()
    let label = UILabel()
    
    let artistAvi = AViCard()
    
    var stackview: UIStackView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        stackview = UIStackView(arrangedSubviews: [artistAvi])
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackview)
        
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
    func configure(item: LibItem, vc: UINavigationController?, indexPath: Int?) {
        
        self.NavVc = vc
    
        print("Seting up Artist")
        artistAvi.configureCard(img: item.imageURL, name: item.name!)
        
        tapGesture = ImgGestureRecognizer(target: self, action: #selector(presentView(_sender:)))
        tapGesture.id = item.artistId
        image.addGestureRecognizer(tapGesture)
    }
    
    @objc func presentView(_sender: ImgGestureRecognizer) {
        let view = Profile()
        view.artistId = _sender.id
        
        NavVc?.pushViewController(view, animated: true)
        
    }
    
}

