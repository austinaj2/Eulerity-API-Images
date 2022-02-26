//
//  ViewController.swift
//  Eulerity API Images
//
//  Created by Macky Cisse on 2/25/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var imagesTable: UITableView!
    
    let images: [Response] = [
        Response(url: "URL", created: "Now", updated: "Again"),
        Response(url: "URL2", created: "Now", updated: "Again"),
        Response(url: "URL3", created: "Now", updated: "Again")
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesTable.delegate = self
        imagesTable.dataSource = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = imagesTable.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? ImageCell {
            let r = images[indexPath.row]
            cell.cellImageView.image = UIImage(named: "cart")
            cell.cellLabelView.text = r.url
            print("\(r.url)")
            return cell
        }
        return UITableViewCell()
    }
    
    


}
    
struct Response: Codable {
    let url: String
    let created: String
    let updated: String
}

