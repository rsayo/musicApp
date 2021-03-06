//
//  PlaylistViewController.swift
//  spotlight
//
//  Created by bajo on 2022-02-03.
//

import UIKit

class PlaylistViewController: UIViewController{
    
    var id = String()
    var data: Playlist?
    
    var tableview: UITableView!
    let user = UserDefaults.standard.value(forKey: "userdata")
    
    var loadingView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.backgroundColor = .red
        
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view.addSubview(loadingView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.Get(url: "user/playlist?user=\(user)&&id=\(id)") { (data: Playlist?, error: NetworkError) in
            
            switch( error ){
            case .servererr:
                print( "internal error")
            
            case .notfound:
                print( "url not found ")
                
            case .success:
                print( "success ")
                self.data = data!
                
                DispatchQueue.main.async {
                    self.loadingView.removeFromSuperview()
                    self.loadTableview()
                }
            }
        }
        
    }
    
    func loadTableview(){
        tableview = UITableView(frame: .zero, style: .grouped)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.frame = view.frame
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.register(TrackStrip.self, forCellReuseIdentifier: TrackStrip.reuseIdentifier)
        tableview.backgroundColor = UIColor.init(displayP3Red: 22 / 255, green: 22 / 255, blue: 22 / 255, alpha: 1)
        tableview.separatorColor = UIColor.clear
        tableview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 140, right: 0)
        tableview.contentInsetAdjustmentBehavior = .never
        tableview.allowsSelection = true
        setupHeader()
        
        view.addSubview(tableview)
        
    }
    func setupHeader(){
       
        let header = PlaylistsDetailHeader(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 520))
        header.artist.text = data!.title
        header.albumImage.setUpImage(url: data!.imageURL, interactable: true)
        header.trackTitle.text = data!.title
        header.vc = navigationController
        header.tracks = data!.tracks
        self.tableview.tableHeaderView = header
        
        
    }

}

extension PlaylistViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data!.tracks.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Tracks"
    }
    
//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//
//        let date = Date()
//        let publishDate = date.formateDate(dateString: data!.releaseDate!)
        
        
//        return "Published \(publishDate)"
        
//    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

         let favouritAction = UIContextualAction(style: .normal, title: "") { (action, view, completion) in
             print(self.data!.tracks[indexPath.row])
             
             NetworkManager.Delete(url: "user/savedTracks?user=\(self.user!)") { (error : NetworkError) in
                 switch(error){
                 case .notfound:
                     print("url not found")
                
                 case .servererr:
                     print("Internal server error")
                     
                 case .success:
                     DispatchQueue.main.async {
                         self.tableview.reloadRows(at: [indexPath], with: .left)
                     }
                     print("success")
                 }
             }
        }
        
//        favouritAction.image = UIImage(systemName: "xmark.circle")
        favouritAction.title = "Remove"
        favouritAction.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [favouritAction])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AudioManager.shared.initPlayer(track: data!.tracks[indexPath.row], tracks: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: TrackStrip.reuseIdentifier, for: indexPath) as! TrackStrip
        cell.configure(track: data!.tracks[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }
    
}
