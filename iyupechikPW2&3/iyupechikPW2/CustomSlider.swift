//
//  CustomSlider.swift
//  iyupechikPW2
//
//  Created by Печик Ирина on 30.09.2023.
//
import UIKit

final class CustomSlider: UIView {
    
    enum Constraints {
        static let titleTop: CGFloat = 10
        static let titleLeading: CGFloat = 20
        
        static let sliderBottom: CGFloat = -10
        static let sliderLeading: CGFloat = 20
    }
    
    // Переменная типа замыкания, принимает double и ничего не возвращает
    var valueChanged: ((Double) -> Void)?
    // Ползунок
    var slider = UISlider()
    // Заголовок
    var titleView = UILabel()
    
    // title - текст ползунка, min/max - минимально/максимально допустимое значение ползунка
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    
    // "Исключаем" метод из наследования
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: Constraints.titleTop),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.titleLeading),
            
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constraints.sliderBottom),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.sliderLeading)
        ])
    }
    
    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}
