//
//  StickerBottomSheet.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/14.
//

import UIKit

import EasyKit

final class StickerBottomSheet: BaseViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sheetHeight: NSLayoutConstraint!
    
    // MARK: - Properties
    
    var stickers: [Stickers]?
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        registerXibs()
    }
    
    override func style() {
        containerView.layer.cornerRadius = 20
        containerView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        titleLabel.setTypoStyle(
            font: TypoStyle.body5.font,
            kernValue: TypoStyle.body5.labelDescription.kern,
            lineSpacing: TypoStyle.body5.labelDescription.lineHeight
        )
    }
    
    override func layout() {
        sheetHeight.constant = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }
    
    @IBAction func closedButtonClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    // MARK: - Functions
    
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 31, bottom: 0, right: 32)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 30

        collectionView?.collectionViewLayout = layout
        collectionView?.allowsMultipleSelection = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
    }
    
    private func registerXibs() {
        collectionView.register(StickerCollectionViewCell.self)
    }
    
    public func showSheetWithAnimation() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.sheetHeight.constant = UIScreen.main.bounds.height / 2
            self?.view.layoutIfNeeded()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension StickerBottomSheet: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: StickerCollectionViewCell.self)
        if let sticker = stickers?[indexPath.row] {
            cell.configure(stickers: sticker)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stickers?.count ?? 0
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension StickerBottomSheet: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = 84 / 375 * UIScreen.main.bounds.width
        let cellHeight = 136 / 84 * cellWidth
        
        return CGSize(width: cellWidth,
                      height: cellHeight)
    }
}
