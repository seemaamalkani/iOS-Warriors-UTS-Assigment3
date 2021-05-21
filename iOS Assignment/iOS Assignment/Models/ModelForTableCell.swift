

import Foundation
import UIKit
class ModelForTableCell : UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableCellLevelInstance: UILabel = {
        let label = UILabel()
        label.text = "Subject 1"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupView(){
        addSubview(cellView)
        cellView.addSubview(tableCellLevelInstance)
        self.selectionStyle = .none
        
            NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        tableCellLevelInstance.heightAnchor.constraint(equalToConstant: 200).isActive = true
        tableCellLevelInstance.widthAnchor.constraint(equalToConstant: 200).isActive = true
        tableCellLevelInstance.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        tableCellLevelInstance.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20).isActive = true
        
    }
    
    
}
