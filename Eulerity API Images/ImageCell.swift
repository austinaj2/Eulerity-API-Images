//
//  ImageCell.swift
//  Eulerity API Images
//
//  Created by Macky Cisse on 2/25/22.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellLabelView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure(url: String, completed: @escaping () -> ()) {
        print(url)
                URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) in
                    if let data = data {
                        if error == nil {
                            if let img = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self.cellImageView.image = img
                                    completed()
                                }
                            }
                        }
                    }
                }).resume()
    }

}
