//
//  AddMyMedicineCollectionViewCell.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/10.
//

import UIKit

final class AddMyMedicineCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var deleteCellClosure: (() -> ())?
    var cellHeightClosure: (() -> ())?
    
    // MARK: - @IBOutlets
    
    @IBOutlet var rootView: UIView!
    @IBOutlet var medicineMainView: UIView!
    @IBOutlet var medicineTextField: UITextField!
    @IBOutlet var deleteTextButton: UIButton!
    @IBOutlet var deleteMedicineCellButton: UIButton!
    @IBOutlet var writingCountLabel: UILabel!
    @IBOutlet var medicineCellHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        setDeleteButton()
        assignDelegate()
    }
    
    // MARK: - Functions
    
    private func setUI() {
        medicineMainView.makeRoundedWithBorder(radius: 10, color: Color.gray300!.cgColor)
    }
    
    private func assignDelegate() {
        medicineTextField.delegate = self
    }
    
    private func setDeleteButton() {
        medicineTextField.addTarget(self, action: #selector(AddMyMedicineCollectionViewCell.medicineTextFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
    }
    
    // Color, Bool을 매개변수로 가지는 함수
    private func checkMedicineTextField(color: CGColor, bool: Bool) {
        medicineMainView.layer.borderColor = color
        deleteTextButton.isHidden = bool
        deleteMedicineCellButton.isHidden = true
        writingCountLabel.isHidden = false
    }
    
    private func changeUI() {
        writingCountLabel.isHidden = true
        deleteTextButton.isHidden = true
        deleteMedicineCellButton.isHidden = false
    }
    
    @objc func medicineTextFieldDidChange(_ textField: UITextField) {
        if let medicineText = medicineTextField.text {
            !medicineText.isEmpty ?
            checkMedicineTextField(color: Color.gray600!.cgColor, bool: false) :
                checkMedicineTextField(color: Color.gray300!.cgColor, bool: true)
        }
        
        // 글자 수 나타내기
        medicineTextField.attributedText = setAttributedText(text: medicineTextField.text!)
        writingCountLabel.attributedText = setAttributedText(text: "\(String(medicineTextField.text?.count ?? 0)) / 10")
        
    }
    
    // 글자 수 나타내기
    func setAttributedText(text: String) -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor.black, range: (text as NSString).range(of: "/ 10자"))
        return attributeString
    }
    
    // MARK: - @IBActions
    // Delete버튼 클릭 시, 텍스트필드, 글자 수 초기화
    @IBAction func deleteButtonClicked(_ sender: UIButton) {
        medicineTextField.text = ""
        writingCountLabel.text = "0 / 10"
    }
    // 클로저를 활용해서 AddMyMedicineViewController에서 셀 삭제 가능하게 만듦
    @IBAction func deleteCellButtonClicked(_ sender: UIButton) {
        deleteCellClosure?()
    }
}

// MARK: UITextField Delegate
extension AddMyMedicineCollectionViewCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkMedicineTextField(color: Color.gray300!.cgColor, bool: true)
        changeUI()
        cellHeightClosure?()
    }
    
    // 텍스트필드 10글자까지 입력 가능하게 / 10글자 이상이면 입력 안 됨
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let medicineText = medicineTextField.text ?? ""
        guard let stringRange = Range(range, in: medicineText) else { return false }
        let updatedText = medicineText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 10
    }
}
