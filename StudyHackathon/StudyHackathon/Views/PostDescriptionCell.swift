//
//  PostDescriptionCell.swift
//  StudyHackathon
//
//  Created by Binjia Chen on 7/18/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import UIKit

class PostDescriptionCell: UITableViewCell {
    
    static let height: CGFloat = 200
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
