//
//  TimeHeaderView.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/11.
//

import UIKit

final class TimeHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var editButtonStackView: UIStackView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var editState: Bool = false {
        didSet {
            
        }
    }
    var editModeClosure: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    private func style() {
        editButton.setTitleColor(Color.gray700, for: .normal)
        editButton.titleLabel?.setTypoStyle(typoStyle: .body5)
    }
    
    override func prepareForReuse() {
        editButtonStackView.isHidden = false
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        editState.toggle()
        editButton.setTitle(editState ? "완료" : "수정", for: .normal)
        editModeClosure?()
    }
}
