//
//  ViewController.swift
//  iyupechikPW1
//
//  Created by Печик Ирина on 14.09.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var body: UIView!
    @IBOutlet weak var fourthLeg: UIView!
    @IBOutlet weak var thirdLeg: UIView!
    @IBOutlet weak var secondLeg: UIView!
    @IBOutlet weak var firstLeg: UIView!
    @IBOutlet weak var head: UIView!
    @IBOutlet weak var firstBlackEye: UIView!
    @IBOutlet weak var firstWhiteEye: UIView!
    @IBOutlet weak var secondBlackEye: UIView!
    @IBOutlet weak var secondWhiteEye: UIView!
    
    @IBOutlet var bodyParts: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyParts = [body, fourthLeg, thirdLeg, secondLeg, firstLeg, head, firstBlackEye, firstWhiteEye, secondBlackEye, secondWhiteEye]
    }
    
    // MARK: - Анимация views при нажатии на кнопку
    @IBAction func buttonWasPressed(_ sender: Any) {
        let button = sender as? UIButton
        // Деактивируем кнопку.
        button?.isEnabled = false;
        
        var viewsColors: Set<UIColor> = makeUniqueColors();
        for view in bodyParts {
            UIView.animate(withDuration: 1, animations: {
                view.backgroundColor = viewsColors.popFirst()
                view.layer.cornerRadius = .random(in: 0...15)
            },
              completion: {_ in button?.isEnabled = true})
        }
    }
    
    // MARK: Cоздание уникальных цветов view.
    func makeUniqueColors() -> Set<UIColor> {
        var uniqueColorsSet = Set<UIColor>()
        while uniqueColorsSet.count < bodyParts.count {
            uniqueColorsSet.insert(convertHexCodeStringToUIColor(hex: generateHexCodeColor()))
        }
        return uniqueColorsSet
    }
    
    // MARK: Генерация hex-кода
    func generateHexCodeColor() -> String {
        let hexSymbols = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
        var generatedHexColor: String = ""
        let hexCodeSize = 6
        for _ in 1...hexCodeSize {
            // генерируем индекс массива возможных символов ([0, 15])
            let index = Int.random(in: 0..<hexSymbols.count)
            generatedHexColor += hexSymbols[index]
        }
        generatedHexColor = "#" + generatedHexColor;
        return generatedHexColor
    }
    
    // MARK: Конвертация hex-кода в RGB
    func convertHexCodeStringToUIColor (hex: String) -> UIColor {
        var stringWithoutHash = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        // Clean our string for future operations
        if stringWithoutHash.hasPrefix("#") {
            stringWithoutHash.remove(at: stringWithoutHash.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        // Преобразуем 16-ричное представление строки в Int64
        Scanner(string: stringWithoutHash).scanHexInt64(&rgbValue)
        
        // bitmask: 0xRRGGBB
        return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                       alpha: 1)
    }
}
