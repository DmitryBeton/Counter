//
//  ViewController.swift
//  Counter
//
//  Created by Дмитрий Чалов on 31.05.2025.
//

import UIKit

final class ViewController: UIViewController {

    private var count: Int = 0
    
    @IBOutlet private weak var labelCountDisplay: UILabel!
    
    @IBOutlet private weak var buttonSubstract: UIButton!
    
    @IBOutlet private weak var buttonAdd: UIButton!
    
    @IBOutlet private weak var buttonClear: UIButton!
    
    @IBOutlet private weak var textViewHistory: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textViewHistory.text += "История изменений:"
    }

    // обновление счетчика
    private func updateCountDisplay() {
        labelCountDisplay.text = "Значение счётчика: \(count)"
    }
    
    // получение нынешней даты и время
    private func timeNow() -> String {
        let getDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy, HH:mm:ss"
        return dateFormatter.string(from: getDate)
    }
    
    // метод для вывода текста в UITextView
    private func historyPrint(_ s: String) {
        textViewHistory.text += "\n\(s)"
        scrollTextViewToBottom(textViewHistory)
    }
    
    // scroll вниз за новым текстом
    private func scrollTextViewToBottom(_ textView: UITextView) {
        if textView.text.count > 0 {
            let location = textView.text.count - 1
            let bottom = NSMakeRange(location, 1)
            textView.scrollRangeToVisible(bottom)
        }
    }
    
    @IBAction private func subtractOne() {
        count -= 1
        if count < 0 {
            count = 0
            historyPrint("\(timeNow()): попытка уменьшить значение счётчика ниже 0")
        } else {
            historyPrint("\(timeNow()): значение изменено на -1")
        }
        updateCountDisplay()
    }
    
    @IBAction private func addOne() {
        count += 1
        historyPrint("\(timeNow()): значение изменено на +1")
        updateCountDisplay()
    }
        
    @IBAction private func resetCount() {
        count = 0
        historyPrint("\(timeNow()): значение сброшено")

        updateCountDisplay()
    }

}

