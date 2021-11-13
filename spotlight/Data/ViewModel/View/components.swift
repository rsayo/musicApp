////
////  components.swift
////  spotlight
////
////  Created by Robert Aubow on 6/18/21.
////
//
import Foundation
import UIKit
import AudioToolbox

class AViCard: UIView {

    let imgView = UIImageView()
    let label = UILabel()

    override init(frame: CGRect){
        super.init(frame: frame)
//
    }

    required init?(coder: NSCoder){
        fatalError("")
    }

    func configureCard(img: String, name: String){
        setupImg(img: img)
        setupLabel(name: name)
    }
    func setupImg(img: String){
        imgView.image = UIImage(named: img)
        imgView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imgView.layer.cornerRadius = 35
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFill

        // add image to view
        self.addSubview(imgView)

        // configure constraints
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imgView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true

    }
    func setupLabel(name: String){
        label.text = name
        label.textColor = .label
        label.setFont(with: 12)

        // add label
        self.addSubview(label)

        // configure constraints
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 10).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
} // User avitar image

// Buttons
class LargePrimaryButton: UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func setupButton(label: String){
        self.setTitle(label, for: .normal)
        self.setTitleColor(UIColor.init(displayP3Red: 255 / 255, green: 227 / 255, blue: 77 / 255, alpha: 1), for: .normal)
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 25
    }
}

class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(
        top: 0,
        left: 20,
        bottom: 0,
        right: 20
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
//
//// Extentions
extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
//        backgroundColor = .white
//        textColor = .black
        bottomLine.cornerRadius = 25
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
extension UILabel {
    func setFont(with size: CGFloat){
        font = UIFont(name: "Helvetica Neue", size: size)
    }
    func setBoldFont(with size: CGFloat){
        font = UIFont.boldSystemFont(ofSize: size)
    }
}

class MiniPlayer: UIView {
    
    var timer = Timer()
    let img: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "6lack")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    let artistLabel = UILabel()
    let trackLabel = UILabel()

    let playBtn = UIButton()
    let playNext = UIButton()
    let prevBtn = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NotificationCenter.default.addObserver(self, selector: #selector(setTrack(sender:)), name: Notification.Name("trackChange"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(togglePlayBtn), name: NSNotification.Name("isPlaying"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateMiniPlayer), name: Notification.Name("update"), object: nil)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openPlayer)))
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.init(displayP3Red: 22 / 255, green: 22 / 255, blue: 22 / 255, alpha: 1)
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.init(displayP3Red: 255 / 255, green: 227 / 255, blue: 77 / 255, alpha: 0.1).cgColor
        
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
        heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        addSubview(img)
        
        artistLabel.text = "6lack"
        artistLabel.textColor = .secondaryLabel
        artistLabel.setFont(with: 10)
        
        trackLabel.text = "Nonchallant"
        trackLabel.textColor = .label
        trackLabel.setFont(with: 12)
        
        trackLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        let trackInfoStack = UIStackView(arrangedSubviews: [artistLabel, trackLabel])
        trackInfoStack.axis = .vertical
        trackInfoStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(trackInfoStack)
        
        prevBtn.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        prevBtn.tintColor = UIColor.init(displayP3Red: 255 / 255, green: 227 / 255, blue: 77 / 255, alpha: 0.5)
        
        playBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playBtn.tintColor = UIColor.init(displayP3Red: 255 / 255, green: 227 / 255, blue: 77 / 255, alpha: 0.5)
        playBtn.addTarget(self, action: #selector(togglePlayState), for: .touchUpInside)
        
        playNext.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        playNext.tintColor = UIColor.init(displayP3Red: 255 / 255, green: 227 / 255, blue: 77 / 255, alpha: 0.5)
        playNext.addTarget(self, action: #selector(nextTrack), for: .touchUpInside)
        
        let buttonStack = UIStackView(arrangedSubviews: [playBtn, playNext])
        buttonStack.axis = .horizontal
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.spacing = 20
        
        addSubview(buttonStack)
        
        layer.cornerRadius = 10
        
        img.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        img.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        img.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        buttonStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        buttonStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        trackInfoStack.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 20).isActive = true
        trackInfoStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    @objc func setTrack(sender: Notification){
        
        if let object = sender.userInfo as NSDictionary? {
            if let track = object["track"] {
                
                NotificationCenter.default.post(name: Notification.Name("update"), object: nil, userInfo: ["track" : track])
                
                AudioManager.initPlayer(track: track as? String, tracks: nil)
            }
        }
    }
    
    @objc func updateMiniPlayer(sender: Notification){

        if let object = sender.userInfo as NSDictionary? {
            if let id = object["track"]{
                
                NetworkManager.getTrack( id: id as! String, completion: {
                    result in

                    switch( result){
                    case .success( let data):
                        self.img.image = UIImage(named: data.imageURL)
                        self.artistLabel.text = data.name
                        self.trackLabel.text = data.title
                        
                    case .failure( let err):
                        print(err)
                    }
                })
                
            }
        }
    }
    
    @objc func nextTrack(){
        AudioManager.playerController(option: .next)
        
    }
    
    @objc func togglePlayBtn(sender: Notification){
    
        if (player!.isPlaying){
            playBtn.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            
        }else{
            playBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    @objc func setPlayerInterval(){
        print(Int(player!.currentTime))
        if(player?.currentTime == player?.duration){
            
        }
    }
    
    @objc func togglePlayState(){
        if(player!.isPlaying){
            AudioManager.playerController(option: .pause ) } else{ AudioManager.playerController(option: .resume)}
        print("pressed")
        NotificationCenter.default.post(name: NSNotification.Name("isPlaying"), object: nil)
    }
    
    @objc func openPlayer(){
        NotificationCenter.default.post(name: NSNotification.Name("player"), object: nil)
    }
   
    
}
class customTab: UITabBarController{
    
    
    let animate = CABasicAnimation()

    let miniPlayer = MiniPlayer()
    let player = MiniPlayer()
    
    override func viewDidLoad() {
        
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .fullScreen
        
        view.addSubview(miniPlayer)
        
        miniPlayer.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: -10).isActive = true
        miniPlayer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let homeVc = UINavigationController(rootViewController: ViewController())
        homeVc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
            
        let profile = UINavigationController(rootViewController: ProfileViewController())
        profile.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "books.vertical"), tag: 0)
        tabBar.tintColor = UIColor.init(displayP3Red: 255 / 255, green: 227 / 255, blue: 77 / 255, alpha: 0.5)
        
        tabBar.backgroundColor = UIColor.init(displayP3Red: 22 / 255, green: 22 / 255, blue: 22 / 255, alpha: 1)
    
        tabBar.frame = CGRect(x: 100, y: 100, width: 200, height: 200)

        self.viewControllers = [homeVc, profile]
    
    }
    
//    @objc func openPlayer(){
//   
//        animate.keyPath = "position.y"
//        animate.fromValue = UIScreen.main.bounds.height - (self.tabBar.bounds.height - 10)
//        animate.toValue = 200
//        animate.duration = 0.5
//
//        playerContainer.layer.add(animate, forKey: "basic")
//        playerContainer.layer.position = CGPoint(x: (UIScreen.main.bounds.width / 2), y: 200)
//        
//        print("player tapped")
//    }
//    
//    @objc func closePlayer(){
//        
//        animate.keyPath = "position.y"
//        animate.fromValue = 0
//        animate.toValue = CGFloat(UIScreen.main.bounds.height - (self.tabBar.bounds.height - 10))
//        animate.duration = 0.5
//
//        playerContainer.layer.add(animate, forKey: "basic")
//        playerContainer.layer.position = CGPoint(x: (UIScreen.main.bounds.width / 2), y: 200)
//        
//    }
//    
}
