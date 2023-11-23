//
//  colorFunctions.swift
//  iyupechikPW2
//
//  Created by Печик Ирина on 04.10.2023.
//

import UIKit

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
