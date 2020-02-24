//
//  CustomTableViewCell.swift
//  Proficiency_iOS
//
//  Created by Prince Gupta on 17/02/20.
//  Copyright © 2020 Prince Gupta. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    var imgView = UIImageView()
    var titleLbl = UILabel()
    var descriptionLbl = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addSubViews()
    }
    
    func addSubViews() {
        
        let imageFrame = CGRect(x: 10, y: 10, width: 80, height: 80)
        imgView = UIImageView(frame: imageFrame)
        imgView.image = UIImage.init(named: "PlaceholderImage.jpg")
        imgView.contentMode = .scaleAspectFit
        self.addSubview(imgView)
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0).isActive = true
        imgView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        
        let titleFrame = CGRect(x: 107, y: 10, width: 204, height: 21)
        titleLbl = UILabel(frame: titleFrame)
        titleLbl.font = UIFont.boldSystemFont(ofSize: 17.0)
        self.addSubview(titleLbl)
        
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 17.0).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        titleLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0).isActive = true
        titleLbl.heightAnchor.constraint(equalToConstant: 21.0).isActive = true
        
        let descriptionFrame = CGRect(x: 107, y: 41, width: 207, height: 60)
        descriptionLbl = UILabel(frame: descriptionFrame)
        descriptionLbl.font = UIFont.systemFont(ofSize: 14.0)
        descriptionLbl.numberOfLines = 0
        self.addSubview(descriptionLbl)
               
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        descriptionLbl.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 17.0).isActive = true
        descriptionLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        descriptionLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 10.0).isActive = true
        descriptionLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        descriptionLbl.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: 11.0).isActive = true
        descriptionLbl.heightAnchor.constraint(greaterThanOrEqualToConstant: 60.0).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
