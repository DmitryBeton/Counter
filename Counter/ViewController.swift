//
//  ViewController.swift
//  Counter
//
//  Created by Дмитрий Чалов on 31.05.2025.
//

import UIKit

class ViewController: UIViewController {
    
    private var count: Int = 0
    
    @IBOutlet weak var labelCountDisplay: UILabel!
    
    @IBOutlet weak var buttonSubstract: UIButton!
    
    @IBOutlet weak var buttonAdd: UIButton!
    
    @IBOutlet weak var buttonClear: UIButton!
    
    @IBOutlet weak var textViewHistory: UITextView!
    
    @IBAction func subtractOne() {
        count -= 1
        if count < 0 {
            count = 0
            historyPrint("\(timeNow()): попытка уменьшить значение счётчика ниже 0")
        } else {
            historyPrint("\(timeNow()): значение изменено на -1")
        }
        updateCountDisplay()
    }
    
    @IBAction func addOne() {
        count += 1
        historyPrint("\(timeNow()): значение изменено на +1")
        updateCountDisplay()
    }
        
    @IBAction func resetCount() {
        count = 0
        historyPrint("\(timeNow()): значение сброшено")

        updateCountDisplay()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textViewHistory.text += "История изменений:"
    }


}

