//
//  NoticeListCollectionViewCell+Interaction.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/08/08.
//

import UIKit

extension NoticeListCollectionViewCell {
    func presentDetailView() {
        infoButton.addTarget(self, action: #selector(detailButtonClicked), for: .touchUpInside)
    }
    
    func addAcceptAlert() {
        acceptButton.addTarget(self, action: #selector(acceptButtonClicked), for: .touchUpInside)
    }
    
    func addRefuseAlert() {
        refuseButton.addTarget(self, action: #selector(refuseButtonClicked), for: .touchUpInside)
    }
    
    @objc func detailButtonClicked() { info() }
    @objc func acceptButtonClicked() { accept() }
    @objc func refuseButtonClicked() { refuse() }
}
