//
//  ViewController.swift
//  Eulerity API Images
//
//  Created by Macky Cisse on 2/25/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var imagesTable: UITableView!
    
    let url = "https://eulerity-hackathon.appspot.com/image"
    @Published var parsed = [Response]()
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesTable.delegate = self
        imagesTable.dataSource = self
        getData {
            self.imagesTable.reloadData()
            self.loadImages {
                //print(self.images)
                
            }

        }
        
    }

    func getData(completed: @escaping () -> ()) {
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) in
            if let data = data {
                if error == nil {
                    do {
                        self.parsed = try JSONDecoder().decode([Response].self, from: data)
                        DispatchQueue.main.async {
                            completed()
                        }
                    } catch {
                            print("Failed URL Conversion: \(String(describing: error))")
                    }
                }
            }
        }).resume()
    }
   
    func loadImages(completed: @escaping () -> ())  {
        for i in self.parsed {
            URLSession.shared.dataTask(with: URL(string: i.url)!, completionHandler: { (data, response, error) in
                if let data = data {
                    if error == nil {
                        if let img = UIImage(data: data) {
                            self.images.append(img)
//                            print(self.images)
                        }
                        DispatchQueue.main.async {
                            completed()
                        }
                    }
                }
            }).resume()
        }
    }
    /* Populating table view */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parsed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = imagesTable.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? ImageCell {
            let r = parsed[indexPath.row]
//            let newImage = loadImage(url: r.url)
            cell.configure(url: r.url) {
                print(cell.cellImageView.image!)
            }
            cell.cellLabelView.text = r.url
//            print("\(r.url)")
    
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

extension UIImageView {
    func load(url: String) {
        if let url = URL(string: url) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let img = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = img
                        }
                    }
                }
            }
        }
    }
}
