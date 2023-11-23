//
//  WrittenWishCell.swift
//  iyupechikPW2
//
//  Created by Печик Ирина on 14.11.2023.
//

import UIKit

final class WrittenWishCell: UITableViewCell {
    static let reuseId: String = "WrittenWishCell"
    
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wishLabelOffset: CGFloat = 8
        
        static let rightAnchorSaveButton: CGFloat = 10
        
        static let textViewHeight: CGFloat = 280
        static let textViewFont: CGFloat = 18
    }
    let wishLabel: UILabel = UILabel()
    var textView = UITextView()
    let saveEditionButton: UIButton = UIButton()
    
    // Замыкание для изменения wishArray.
    var editWish: ((String, String) -> Void)?
    
    // View ячейки.
    let wrap: UIView = UIView()
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with wish: String) {
        wishLabel.text = wish
        wishLabel.font = .systemFont(ofSize: 18)
        wishLabel.numberOfLines = 0
    }
    
    // MARK: Отображение ячейки.
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        // Расширяем ячейку в зависимости от длины текста.
        wrap.sizeToFit()
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        
        wrap.pinVertical(to: contentView, Constants.wrapOffsetV)
        wrap.pinHorizontal(to: contentView, Constants.wrapOffsetH)

        wrap.addSubview(wishLabel)
        wishLabel.pin(to: wrap, Constants.wishLabelOffset)
    }
    
    // MARK: Изменение содержимого ячейки.
    public func Edit() {
        wrap.isHidden = true
        contentView.addSubview(textView)
        textView.text = wishLabel.text
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.pinHorizontal(to: self, Constants.wrapOffsetH)
        textView.setHeight(Constants.textViewHeight)

        textView.sizeToFit()
        textView.backgroundColor = UIColor.white
        textView.layer.cornerRadius = Constants.wrapRadius
        textView.selectedTextRange = nil
        textView.textColor = .black
        textView.font = .systemFont(ofSize: Constants.textViewFont)
        textView.addPlaceholder("Enter you wish", textView: textView)
        textView.becomeFirstResponder()

        addSubview(saveEditionButton)
        saveEditionButton.setImage(UIImage(named: "DoneMark"), for: .normal)
        saveEditionButton.translatesAutoresizingMaskIntoConstraints = false
        saveEditionButton.addTarget(self, action: #selector(SaveEditWish), for: .touchUpInside)
        saveEditionButton.layer.cornerRadius = Constants.wrapRadius
        saveEditionButton.pinRight(to: self, Constants.rightAnchorSaveButton)
    }
    
    // MARK: Обработка сохранения измененного желания.
    @objc
    func SaveEditWish() {
        // Проверяем, что текст в UITextView не пустой.
        guard let text = textView.text,
              !text.isEmpty else {
            return
        }
        // Вызываем замыкание и передаем текст в качестве параметра.
        editWish?(wishLabel.text!,text)
        // Очищаем поле UITextView.
        textView.text = ""
        textView.removeFromSuperview()
        saveEditionButton.removeFromSuperview()
        wrap.isHidden = false
    }
}
