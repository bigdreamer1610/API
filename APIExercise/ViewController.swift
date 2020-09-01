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
    
    @IBOutlet var lbError2: UILabel!
    @IBOutlet var lbError: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://demo0737597.mockable.io/master_data1")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    let myData = try JSONDecoder().decode(LocationData.self, from: data!)
                    self.locations = myData.data
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.lbError2.isHidden = !(self.locations.count == 0)
                        if self.locations.count != 0 {
                            self.lbError2.isHidden = true
                            //refresh control
                            self.refreshControl.attributedTitle = NSAttributedString(string: "loading")
                            self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
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
    @objc func refresh(_ sender: UIRefreshControl){
        sender.endRefreshing()
        self.tableView.reloadData()
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
