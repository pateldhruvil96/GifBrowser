//
//  GifViewController.swift
//  GifBrowser
//
//  Created by Dhruvil Patel on 3/16/21.
//

import UIKit
import SwiftyGif
import Kingfisher
import SwiftyJSON

class GifViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var gifData = [String]()
    var titleData = [String]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nibCustomTableViewCell = UINib(nibName: "GifTableViewCell", bundle: nil)
        tableView.register(nibCustomTableViewCell, forCellReuseIdentifier: "GifTableViewCell")
        
        if (UserDefaults.standard.object(forKey: "gifData") == nil) || Reachability.isConnectedToNetwork(){
            cleaingPreviousCache {
                callApi()
            }
        }else{
            gifData = UserDefaults.standard.object(forKey: "gifData") as! [String]
            titleData = UserDefaults.standard.object(forKey: "titleData") as! [String]
        }
    }
    func cleaingPreviousCache(completion:()->()){
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache()
        KingfisherManager.shared.cache.cleanExpiredDiskCache()
        completion()
    }
    func callApi(){
        var requestURL = URLComponents(string: GETBASEURL + ServerRequest.ApiEndPoints.version + "/\(ServerRequest.ApiEndPoints.gif)" + "/\(ServerRequest.ApiEndPoints.type)")
        let queryItems = [URLQueryItem(name: APIKEY, value: APIKEYVALUE),URLQueryItem(name: APILIMIT, value: APILIMITVALUE),URLQueryItem(name: APIRATING, value: APIRATINGVALUE)]
        requestURL?.queryItems = queryItems
        guard let url = requestURL?.url else{return}
        ServerRequest.postcall(url: url, httpMethod: .get, params: nil) {[weak self] (response, error) in
            print(response as Any)
            if let dict = response, dict.count > 0{
                let json = JSON(dict)
                var i = 0
                while i < 10{
                    let title = json["data"][i]["title"].string
                    self?.titleData.append(title!)
                    let gif = json["data"][i]["images"]["downsized"]["url"].string
                    self?.gifData.append(gif!)
                    if i == 9{
                        UserDefaults.standard.set(self?.gifData, forKey:"gifData")
                        UserDefaults.standard.set(self?.titleData, forKey:"titleData")
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                    }
                    i += 1
                }
            }
        }
    }
}
extension GifViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GifTableViewCell", for: indexPath) as! GifTableViewCell
        cell.gifImageView.kf.cancelDownloadTask()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectedViewController") as! SelectedViewController
        vc.label = titleData[indexPath.row]
        vc.imageUrl = gifData[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension GifViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  gifData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GifTableViewCell", for: indexPath) as! GifTableViewCell
        let url = URL(string: gifData[indexPath.row])
        cell.gifImageView.kf.indicatorType = .activity
        cell.gifImageView?.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.2))], progressBlock: nil, completionHandler: { (image, error, cacheType, URL) in
            cell.setNeedsLayout()
        })
        cell.borderLineView.isHidden = indexPath.row == gifData.count - 1 ? true : false
        return cell
    }
}
extension GifViewController: UIScrollViewDelegate{
    //NOTE: If paginating(i.e loding 15-20 gif at one go and again loading 15-20 gifs on another go ) is implement then below code should be uncomment out
    
    
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        let position = scrollView.contentOffset.y
    //        if position > tableView.contentSize.height - 100 - scrollView.frame.size.height{
    //            if !apiCalled{
    //                tableView.tableFooterView = createSpinnerFooterView()
    //                apiCalled = true
    //                callApi()
    //            }
    //        }
    //    }
    
}
