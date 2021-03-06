//
//  TrendingCollectionViewController.swift
//  dyscMusic
//
//  Created by bajo on 2022-05-27.
//

import UIKit

class TrendingCollectionViewController: UIViewController {

    var tableView: UITableView!
    var data: [Track]!
    
    let loadingView = LoadingViewController()
    
    override func loadView() {
        super.loadView()
        
//        addChild(loadingView)
//        loadingView.didMove(toParent: self)
//        view.addSubview(loadingView.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController!.navigationBar.prefersLargeTitles = true
        title = "Ample Top 100"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        NetworkManager.Get(url: "trending") { (data: [Track]?, err: NetworkError) in
            switch( err ){
            case .success:
                
                self.data = data!
                
                DispatchQueue.main.async {
//                    self.loadingView.removeFromParent()
                    self.setupView()
                }
            case .notfound:
                print( "URL not found ")
            
            case .servererr:
                print( "Internal server error ")
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupView(){
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.frame
        tableView.register(LargeTrackComoponent.self, forCellReuseIdentifier: LargeTrackComoponent.reuseIdentifier)
        tableView.backgroundColor = .black
        tableView.separatorColor = .clear
        view.addSubview(tableView)
    }

}

extension TrendingCollectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LargeTrackComoponent.reuseIdentifier, for: indexPath) as! LargeTrackComoponent
        let item = data[indexPath.row]
        
        cell.configureWithChart(with: item, index: indexPath.row, withChart: true)
        cell.backgroundColor = .clear
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AudioManager.shared.initPlayer(track: data[indexPath.row], tracks: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
}
