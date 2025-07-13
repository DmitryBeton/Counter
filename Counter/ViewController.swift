//
//  ViewController.swift
//  Counter
//
//  Created by Дмитрий Чалов on 31.05.2025.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var labelCountDisplay: UILabel!
    @IBOutlet private weak var buttonSubstract: UIButton!
    @IBOutlet private weak var buttonAdd: UIButton!
    @IBOutlet private weak var buttonClear: UIButton!
    @IBOutlet private weak var textViewHistory: UITextView!
    
    // MARK: - Properties
    private var count: Int = 0
    private var history: [String] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        count = UserDefaults.standard.integer(forKey: "count")
        history = UserDefaults.standard.stringArray(forKey: "history") ?? []
        textViewHistory.text += "История изменений:"
        // Чтение массива
        for line in history {
            historyPrint(line)
        }
        // обновление счетчика
        updateCountDisplay()
    }

    // MARK: - Private Methods
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
    // метод для сохранения истории изменений
    private func historySave(_ s: String) {
        history += [s]
        UserDefaults.standard.set(history, forKey: "history")
//        print("Данные сохранены: \(UserDefaults.standard.stringArray(forKey: "history") ?? ["error"])")
        historyPrint(s)
    }
    // scroll вниз за новым текстом
    private func scrollTextViewToBottom(_ textView: UITextView) {
        if textView.text.count > 0 {
            let location = textView.text.count - 1
            let bottom = NSMakeRange(location, 1)
            textView.scrollRangeToVisible(bottom)
        }
    }
    
    // MARK: - Actions
    @IBAction private func subtractOne() {
        count -= 1
        if count < 0 {
            count = 0
            historySave("\(timeNow()): попытка уменьшить значение счётчика ниже 0")
        } else {
            historySave("\(timeNow()): значение изменено на -1")
        }
        UserDefaults.standard.set(count, forKey: "count")
        updateCountDisplay()
    }
    @IBAction private func addOne() {
        count += 1
        historySave("\(timeNow()): значение изменено на +1")
        UserDefaults.standard.set(count, forKey: "count")
        updateCountDisplay()
    }
    @IBAction private func resetCount() {
        count = 0
        historySave("\(timeNow()): значение сброшено")
        UserDefaults.standard.set(count, forKey: "count")
        updateCountDisplay()
    }
}
