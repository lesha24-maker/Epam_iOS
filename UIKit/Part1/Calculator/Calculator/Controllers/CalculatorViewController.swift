import UIKit

class CalculatorViewController: UIViewController {
    
    private var displayLabel: UILabel!
    private var currentNumber: Double = 0
    private var previousNumber: Double = 0
    private var operation: String = ""
    private var isTypingNumber = false
    private var displayText: String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.black
        
        displayLabel = UILabel(frame: CGRect(x: 20, y: 300, width: view.frame.width - 40, height: 80))
        displayLabel.text = "0"
        displayLabel.textColor = UIColor.white
        displayLabel.font = UIFont.systemFont(ofSize: 40, weight: .light)
        displayLabel.textAlignment = .right
        displayLabel.backgroundColor = UIColor.clear
        view.addSubview(displayLabel)
        
        createButtons()
    }
    
    private func createButtons() {
        let buttonWidth: CGFloat = (view.frame.width - 50) / 4
        let buttonHeight: CGFloat = 70
        let spacing: CGFloat = 10
        let startY: CGFloat = 400
        
        let clearButton = createButton(title: "C", frame: CGRect(x: 10, y: startY, width: buttonWidth, height: buttonHeight), backgroundColor: UIColor.lightGray, titleColor: UIColor.black)
        clearButton.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        
        let plusMinusButton = createButton(title: "±", frame: CGRect(x: 25 + buttonWidth, y: startY, width: buttonWidth, height: buttonHeight), backgroundColor: UIColor.lightGray, titleColor: UIColor.black)
        plusMinusButton.addTarget(self, action: #selector(plusMinusTapped), for: .touchUpInside)
        
        let percentButton = createButton(title: "%", frame: CGRect(x: 40 + buttonWidth * 2, y: startY, width: buttonWidth, height: buttonHeight), backgroundColor: UIColor.lightGray, titleColor: UIColor.black)
        percentButton.addTarget(self, action: #selector(percentTapped), for: .touchUpInside)
        
        let divideButton = createButton(title: "÷", frame: CGRect(x: 50 + buttonWidth * 3, y: startY, width: buttonWidth, height: buttonHeight), backgroundColor: UIColor.orange, titleColor: UIColor.white)
        divideButton.addTarget(self, action: #selector(operationTapped(_:)), for: .touchUpInside)
        
        let button7 = createButton(title: "7", frame: CGRect(x: 10, y: startY + buttonHeight + spacing, width: buttonWidth, height: buttonHeight), backgroundColor: UIColor.darkGray, titleColor: UIColor.white)
        button7.addTarget(self, action: #selector(numberTapped(_:)), for: .touchUpInside)
        
        let button8 = createButton(title: "8", frame: CGRect(x: 25 + buttonWidth, y: startY + buttonHeight + spacing, width: buttonWidth, height: buttonHeight), backgroundColor: UIColor.darkGray, titleColor: UIColor.white)
        button8.addTarget(self, action: #selector(numberTapped(_:)), for: .touchUpInside)
        
        let button9 = createButton(title: "9", frame: CGRect(x: 40 + buttonWidth * 2, y: startY + buttonHeight + spacing, width: buttonWidth, height: buttonHeight), backgroundColor: UIColor.darkGray, titleColor: UIColor.white)
        button9.addTarget(self, action: #selector(numberTapped(_:)), for: .touchUpInside)
        
        let multiplyButton = createButton(title: "×", frame: CGRect(x: 50 + buttonWidth * 3, y: startY + buttonHeight + spacing, width: buttonWidth, height: buttonHeight), backgroundColor: UIColor.orange, titleColor: UIColor.white)
        multiplyButton.addTarget(self, action: #selector(operationTapped(_:)), for: .touchUpInside)
        
        let button4 = createButton(title: "4", frame: CGRect(x: 10, y: startY + (buttonHeight + spacing) * 2, width: buttonWidth, height: buttonHeight), backgroundColor: UIColor.darkGray, titleColor: UIColor.white)
        button4.addTarget(self, action: #selector(numberTapped(_:)), for: .touchUpInside)
        
        let button5 = createButton(title: "5", frame: CGRect(x: 25 + buttonWidth, y: startY + (buttonHeight + spacing) * 2, width: buttonWidth, height: buttonHeight), backgroundColor: UIColor.darkGray, titleColor: UIColor.white)
        button5.addTarget(self, action: #selector(numberTapped(_:)), for: .touchUpInside)
        
        let button6 = createButton(title: "6", frame: CGRect(x: 40 + buttonWidth * 2, y: startY + (buttonHeight + spacing) * 2, width: buttonWidth, height: buttonHeight), backgroundColor: UIColor.darkGray, titleColor: UIColor.white)
        button6.addTarget(self, action: #selector(numberTapped(_:)), for: .touchUpInside)
        
        let minusButton = createButton(title: "-", frame: CGRect(x: 50 + buttonWidth * 3, y: startY + (buttonHeight + spacing) * 2, width: buttonWidth, height: buttonHeight), backgroundColor: UIColor.orange, titleColor: UIColor.white)
        minusButton.addTarget(self, action: #selector(operationTapped(_:)), for: .touchUpInside)
        
        let button1 = createButton(title: "1", frame: CGRect(x: 10, y: startY + (buttonHeight + spacing) * 3, width: buttonWidth, height: buttonHeight), backgroundColor: UIColor.darkGray, titleColor: UIColor.white)
        button1.addTarget(self, action: #selector(numberTapped(_:)), for: .touchUpInside)
        
        let button2 = createButton(title: "2", frame: CGRect(x: 25 + buttonWidth, y: startY + (buttonHeight + spacing) * 3, width: buttonWidth, height: buttonHeight), backgroundColor: UIColor.darkGray, titleColor: UIColor.white)
        button2.addTarget(self, action: #selector(numberTapped(_:)), for: .touchUpInside)
        
        let button3 = createButton(title: "3", frame: CGRect(x: 40 + buttonWidth * 2, y: startY + (buttonHeight + spacing) * 3, width: buttonWidth, height: buttonHeight), backgroundColor: UIColor.darkGray, titleColor: UIColor.white)
        button3.addTarget(self, action: #selector(numberTapped(_:)), for: .touchUpInside)
        
        let plusButton = createButton(title: "+", frame: CGRect(x: 50 + buttonWidth * 3, y: startY + (buttonHeight + spacing) * 3, width: buttonWidth, height: buttonHeight), backgroundColor: UIColor.orange, titleColor: UIColor.white)
        plusButton.addTarget(self, action: #selector(operationTapped(_:)), for: .touchUpInside)
        
        let button0 = createButton(title: "0", frame: CGRect(x: 10, y: startY + (buttonHeight + spacing) * 4, width: buttonWidth * 2 + 10, height: buttonHeight), backgroundColor: UIColor.darkGray, titleColor: UIColor.white)
        button0.addTarget(self, action: #selector(numberTapped(_:)), for: .touchUpInside)
        
        let decimalButton = createButton(title: ".", frame: CGRect(x: 40 + buttonWidth * 2, y: startY + (buttonHeight + spacing) * 4, width: buttonWidth, height: buttonHeight), backgroundColor: UIColor.darkGray, titleColor: UIColor.white)
        decimalButton.addTarget(self, action: #selector(decimalTapped), for: .touchUpInside)
        
        let equalsButton = createButton(title: "=", frame: CGRect(x: 50 + buttonWidth * 3, y: startY + (buttonHeight + spacing) * 4, width: buttonWidth, height: buttonHeight), backgroundColor: UIColor.orange, titleColor: UIColor.white)
        equalsButton.addTarget(self, action: #selector(equalsTapped), for: .touchUpInside)
    }
    
    private func createButton(title: String, frame: CGRect, backgroundColor: UIColor, titleColor: UIColor) -> UIButton {
        let button = UIButton(frame: frame)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        button.layer.cornerRadius = min(frame.width, frame.height) / 2
        view.addSubview(button)
        return button
    }
    
    @objc private func numberTapped(_ sender: UIButton) {
        guard let numberText = sender.currentTitle else { return }
        
        if isTypingNumber {
            if displayText == "0" {
                displayText = numberText
            } else {
                displayText += numberText
            }
        } else {
            displayText = numberText
            isTypingNumber = true
        }
        
        displayLabel.text = displayText
        currentNumber = Double(displayText) ?? 0
    }
    
    @objc private func operationTapped(_ sender: UIButton) {
        guard let operationText = sender.currentTitle else { return }
        
        if !operation.isEmpty && isTypingNumber {
            equalsTapped()
        }
        
        previousNumber = currentNumber
        operation = operationText
        displayText = formatResult(currentNumber) + " " + operationText + " "
        displayLabel.text = displayText
        isTypingNumber = false
    }
    
    @objc private func equalsTapped() {
        guard !operation.isEmpty else { return }
        
        if operation == "÷" && currentNumber == 0 {
            displayText = "Cannot divide by zero"
            displayLabel.text = displayText
            displayLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
            currentNumber = 0
            previousNumber = 0
            operation = ""
            isTypingNumber = false
            return
        }
        
        let result = performCalculation()
        displayText = formatResult(result)
        displayLabel.text = displayText
        currentNumber = result
        previousNumber = 0
        operation = ""
        isTypingNumber = false
    }
    
    @objc private func clearTapped() {
        displayText = "0"
        displayLabel.text = displayText
        currentNumber = 0
        previousNumber = 0
        operation = ""
        isTypingNumber = false
    }
    
    @objc private func plusMinusTapped() {
        currentNumber = -currentNumber
        displayText = formatResult(currentNumber)
        displayLabel.text = displayText
    }
    
    @objc private func percentTapped() {
        currentNumber = currentNumber / 100
        displayText = formatResult(currentNumber)
        displayLabel.text = displayText
    }
    
    @objc private func decimalTapped() {
        if !isTypingNumber {
            displayText = "0."
            isTypingNumber = true
        } else if !displayText.contains(".") {
            displayText += "."
        }
        displayLabel.text = displayText
    }
    
    private func performCalculation() -> Double {
        switch operation {
        case "+":
            return previousNumber + currentNumber
        case "-":
            return previousNumber - currentNumber
        case "×":
            return previousNumber * currentNumber
        case "÷":
            return previousNumber / currentNumber
        default:
            return currentNumber
        }
    }
    
    private func formatResult(_ number: Double) -> String {
        if number.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", number)
        } else {
            return String(number)
        }
    }
}
