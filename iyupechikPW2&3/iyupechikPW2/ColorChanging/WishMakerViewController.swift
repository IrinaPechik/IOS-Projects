//
//  WishMakerViewController.swift
//  iyupechikPW2
//
//  Created by Печик Ирина on 30.09.2023.
//

import UIKit

final class WishMakerViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    enum Constants {
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        static let redName: String = "Red"
        static let greenName: String = "Green"
        static let blueName: String = "Blue"
        
        static let stackRadius: CGFloat = 20
        static let stackBottom: CGFloat = -220
        static let stackLeading: CGFloat = 20
        static let outStackX: CGFloat = -45
        
        static let titleTop: CGFloat = 30
        static let titleLeading: CGFloat = 20
        
        static let decriptionTop: CGFloat = 20
        static let decriptionLeading: CGFloat = 20
        
        static let buttonStackBottom: CGFloat = -40
        
        static let viewBackroundColor: String = "#7375D8"
        static let wishTitleTextColor: String = "#F16C97"
        static let descriptionTextColor: String = "#FFDB73"
    }
    
    let wishTitle = UILabel()
    let wishDescription = UILabel()
    let stack = UIStackView()
    var stack_constraints:[NSLayoutConstraint] = []
    
    var outViewStackConstaint: [NSLayoutConstraint] = []
    var stackVerticalConstaint: [NSLayoutConstraint] = []
    var stackHorizontalConstraint: [NSLayoutConstraint] = []
    
    var shouldRemoveSlider: Bool = false
    let buttonsStack = UIStackView()
    var buttonStackVerticalConstraints:[NSLayoutConstraint] = []
    var buttonStackHorizontalConstraints:[NSLayoutConstraint] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureConstraints()
        configureUI()
    }
    
    
    // MARK: - Отображение элементов интерфейса
    private func configureUI() {
        view.backgroundColor = convertHexCodeStringToUIColor(hex: Constants.viewBackroundColor)
        configureTitle()
        configureDescription()
        configireSliders()
        configureButton()
    }
    
    private func configureConstraints() {
        buttonStackVerticalConstraints = [
            buttonsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackLeading),
            buttonsStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.buttonStackBottom)]
        
        buttonStackHorizontalConstraints = [
            buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            buttonsStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            buttonsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 180)]
        
        stackHorizontalConstraint = [
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -250)
        ]
        stackVerticalConstaint = [
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackLeading),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.stackBottom),
        ]
        outViewStackConstaint = [stack.centerXAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.outStackX)]
    }
    
    // MARK: Отображение заголовка
    private func configureTitle() {
        // Отключаем автоматическое создание constraints, т.к. система автоматически создает constraints на основе кадра представления и его маски.
        wishTitle.translatesAutoresizingMaskIntoConstraints = false
        wishTitle.text = "WishMaker"
        // Делаем жирный шрифт
        wishTitle.font = UIFont.boldSystemFont(ofSize: 32)
        wishTitle.textColor = convertHexCodeStringToUIColor(hex: Constants.wishTitleTextColor)
        // Добавляем title к родительскому View
        view.addSubview(wishTitle)
        
        // Создаем ограничения и сразу активируем их
        NSLayoutConstraint.activate([
            // Устанавливаем центр заголовка по горизонтали равным центру нашего экрана по горизонтали
            wishTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wishTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.titleLeading),
            wishTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleTop)
        ])
    }
    
    // MARK: Отображение описания
    private func configureDescription() {
        wishDescription.translatesAutoresizingMaskIntoConstraints = false
        wishDescription.text = "This app will bring you joy and will fulfill three of your wishes!\n * The first wish is to change the backround color"
        wishDescription.font = UIFont.italicSystemFont(ofSize: 20)
        wishDescription.textColor = convertHexCodeStringToUIColor(hex: Constants.descriptionTextColor)
        wishDescription.numberOfLines = 4
        view.addSubview(wishDescription)
        
        NSLayoutConstraint.activate([
            wishDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wishDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.decriptionLeading),
            wishDescription.topAnchor.constraint(equalTo: wishTitle.bottomAnchor, constant: Constants.decriptionTop),
        ])
    }
    
    // MARK: Отображение слайдеров
    private func configireSliders() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = Constants.stackRadius
        // Все подслои стека, выходящие за границы его рамок, будут обрезаны.
        stack.clipsToBounds = true
        
        let sliderRed = CustomSlider(title: Constants.redName, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderBlue = CustomSlider(title: Constants.blueName, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderGreen = CustomSlider(title: Constants.greenName, min: Constants.sliderMin, max: Constants.sliderMax)
        
        // Добавляем в стек
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stack.addArrangedSubview(slider)
        }
        // Убираем стек за область видимости экрана
        NSLayoutConstraint.activate(outViewStackConstaint)
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 1
        view.backgroundColor?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Изменяем цвет фона путём добавления красного цвета.
        // value - значение слайдера.
        sliderRed.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(
                red: CGFloat(value),
                green: green,
                blue: blue,
                alpha: alpha)
            red = CGFloat(value)
        }
        sliderGreen.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(
                red: red,
                green: CGFloat(value),
                blue: blue,
                alpha: alpha)
            green = CGFloat(value)
        }
        sliderBlue.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(
                red: red,
                green: green,
                blue: CGFloat(value),
                alpha: alpha)
            blue = CGFloat(value)
        }
    }
    
    // MARK: Отображение кнопок
    private func configureButton() {
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.axis = .vertical
        view.addSubview(buttonsStack)
        buttonsStack.spacing = 10
        
        let addWishButton: UIButton = UIButton(type: .system)
        addWishButton.setTitle("My wishes", for: UIControl.State.normal)
        addWishButton.backgroundColor = UIColor.white
        addWishButton.layer.cornerRadius = 10
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
        
        let manuallyBackroundColorChangingButton = UIButton()
        manuallyBackroundColorChangingButton.setTitle("Задать фон слайдерами", for: UIControl.State.normal)
        manuallyBackroundColorChangingButton.backgroundColor = UIColor.systemBlue
        manuallyBackroundColorChangingButton.layer.cornerRadius = 10
        manuallyBackroundColorChangingButton.addTarget(self, action: #selector(self.slidersChanging), for: .touchUpInside)
        
        let randomlyBackroundColorChangingButton = UIButton()
        randomlyBackroundColorChangingButton.setTitle("Сгенерировать фон", for: UIControl.State.normal)
        randomlyBackroundColorChangingButton.backgroundColor = UIColor.systemBlue
        randomlyBackroundColorChangingButton.layer.cornerRadius = 10
        randomlyBackroundColorChangingButton.addTarget(self, action: #selector(generateBackroundColor), for: .touchUpInside)
        
        let colorPickerBackroundColorChangingButton = UIButton()
        colorPickerBackroundColorChangingButton.setTitle("Цветовая палитра", for: UIControl.State.normal)
        colorPickerBackroundColorChangingButton.backgroundColor = UIColor.systemBlue
        colorPickerBackroundColorChangingButton.layer.cornerRadius = 10
        colorPickerBackroundColorChangingButton.addTarget(self, action: #selector(colorPickerChanging), for: .touchUpInside)
        
        
        for button in [addWishButton,
                       manuallyBackroundColorChangingButton, randomlyBackroundColorChangingButton, colorPickerBackroundColorChangingButton] {
            buttonsStack.addArrangedSubview(button)
        }
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let orientation = windowScene.interfaceOrientation
            if orientation.isPortrait {
                NSLayoutConstraint.activate(buttonStackVerticalConstraints)
            } else {
                NSLayoutConstraint.activate(buttonStackHorizontalConstraints)
            }
        }

    }
    
    // MARK: - Обработка изменения интерфейса
    
    // MARK: Обработка кнопки добавления желаний
    @objc
    func addWishButtonPressed() {
        // Открываем табличку
        present(WishStoringViewController(), animated: true)
    }
    
    
    // MARK: Обработка кнопки, включающей/отключающей слайдеры
    @objc func slidersChanging(_ sender: UIButton!) {
        if shouldRemoveSlider == false {
            NSLayoutConstraint.deactivate(outViewStackConstaint)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                let orientation = windowScene.interfaceOrientation
                if orientation.isPortrait {
                    NSLayoutConstraint.deactivate(stackHorizontalConstraint)
                    NSLayoutConstraint.activate(stackVerticalConstaint)
                } else if orientation.isLandscape {
                    NSLayoutConstraint.deactivate(stackVerticalConstaint)
                    NSLayoutConstraint.activate(stackHorizontalConstraint)
                }
            }
            sender.setTitle("Убрать слайдеры", for: .normal)
            shouldRemoveSlider = true
        } else {
            NSLayoutConstraint.deactivate(stackVerticalConstaint)
            NSLayoutConstraint.deactivate(stackHorizontalConstraint)
            NSLayoutConstraint.activate(outViewStackConstaint)
            sender.setTitle("Задать фон слайдерами", for: .normal)
            shouldRemoveSlider = false
        }
    }
    
    // MARK: Обработка кнопки, генерирующей фон в hex
    @objc func generateBackroundColor(_ sender: UIButton!) {
        view.backgroundColor = convertHexCodeStringToUIColor(hex: generateHexCodeColor())
    }
    
    // MARK: Обработка кнопки, открывающей color picker
    @objc func colorPickerChanging(_ sender: UIButton!) {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true)
    }
    
    // MARK: Изменение выбранного цвета фона сразу
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        view.backgroundColor = color
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            NSLayoutConstraint.deactivate(buttonStackVerticalConstraints)
            NSLayoutConstraint.activate(buttonStackHorizontalConstraints)
            NSLayoutConstraint.deactivate(stackVerticalConstaint)
            if (shouldRemoveSlider) {
                NSLayoutConstraint.activate(stackHorizontalConstraint)
            }
        } else if UIDevice.current.orientation.isPortrait {
            NSLayoutConstraint.deactivate(buttonStackHorizontalConstraints)
            NSLayoutConstraint.activate(buttonStackVerticalConstraints)
            NSLayoutConstraint.deactivate(stackHorizontalConstraint)
            if (shouldRemoveSlider) {
                NSLayoutConstraint.activate(stackVerticalConstaint)
            }
          }
    }
}
