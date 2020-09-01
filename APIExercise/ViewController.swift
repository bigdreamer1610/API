//
//  ViewController.swift
//  APIExercise
//
//  Created by THUY Nguyen Duong Thu on 8/31/20.
//  Copyright © 2020 THUY Nguyen Duong Thu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var  locations = [Location]()
    
    @IBOutlet var lbInformation: UILabel!
    @IBOutlet var lbError2: UILabel!
    @IBOutlet var lbError: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var blankView: UIView!
    @IBOutlet var headerTableView: UIView!
    @IBOutlet var heightConstaint: NSLayoutConstraint!
    @IBOutlet var indicatorRefresh: UIActivityIndicatorView!
    var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        heightConstaint.constant = 0
        indicatorRefresh.isHidden = true
        let url = URL(string: "http://demo0737597.mockable.io/master_data")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    let myData = try JSONDecoder().decode(LocationData.self, from: data!)
                    self.locations = myData.data
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        if self.locations.count != 0 {
                            self.lbError2.isHidden = true
                            
                            //my second
                            
                            //my first
                            self.refreshControl.tintColor = UIColor.clear
                            self.refreshControl.alpha = 0
                            let attributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
                            self.refreshControl.attributedTitle = NSAttributedString(string: "", attributes: attributes)
                            self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: UIControl.Event.valueChanged)
                            self.tableView.addSubview(self.refreshControl)
                        } else {
                            self.lbError2.isHidden = false
                        }
                    }
                } catch {
                    print("Wrong")
                }
                
            }
        }
        task.resume()
        let nib = UINib(nibName: "MyCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MyCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    //refresh data when scrolling down
    @objc func refresh(_ sender: UIRefreshControl){
        tableView.reloadData()
        indicatorRefresh.startAnimating()
        refreshControl.beginRefreshing()
        indicatorRefresh.isHidden = false
        heightConstaint.constant = 50
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            //self.refreshControl.endRefreshing()
            self.heightConstaint.constant = 0
            self.indicatorRefresh.stopAnimating()
            self.indicatorRefresh.isHidden = true
            self.refreshControl.endRefreshing()
        }
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
        cell.setUp(data: locations[indexPath.row])
        return cell
    }
}
