//
//  ScheduleEmptyView.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/06/21.
//

import UIKit

final class ScheduleEmptyView: BaseView {
    
    lazy var emptyImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    override func setupView() {
        addSubviews(emptyImageView)
    }
    
    override func setupConstraints() {
        emptyImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(254)
            $0.height.equalTo(215)
        }
    }
    
    convenience init(for tabCategory: TabBarItem) {
        self.init(frame: .zero)
        emptyImageView.image = tabCategory == .home ? Image.illustNoPill : Image.illustNoShare
    }
}
