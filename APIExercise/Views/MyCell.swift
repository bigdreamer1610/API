//
//  MyCell.swift
//  APIExercise
//
//  Created by THUY Nguyen Duong Thu on 8/31/20.
//  Copyright © 2020 THUY Nguyen Duong Thu. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {

    @IBOutlet var myImage: UIImageView!
    @IBOutlet var lbAge: UILabel!
    @IBOutlet var lbGender: UILabel!
    @IBOutlet var lbLocation: UILabel!
    @IBOutlet var lbUsername: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    func setUp(data: Location) {
        self.lbAge.text = "Age: \(data.age)"
        self.lbGender.text = "Gender: \(data.gender)"
        self.lbLocation.text = "Location: \(data.location)"
        self.lbUsername.text = "Username: \(data.userName)"
        //set image
        let imageURL = URL(string: data.image)
        let task = URLSession.shared.dataTask(with: imageURL!) { (data, response, error) in
            if error == nil {
                guard let imageData = data else {return}
                let loadedImage = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.myImage?.image = loadedImage
                }
            }
        }
        task.resume()
    }
}
