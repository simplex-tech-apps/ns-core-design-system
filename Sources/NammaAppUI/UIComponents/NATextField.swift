//
//  NATextField.swift
//  NammaAppUI
//
//  Created by apple on 29/01/26.
//


import SwiftUI
import Combine

public struct NATextField: View {
    //MARK: Observed Properties
    @State
    private var appTheme = AppThemeManager.shared
    @Binding
    var value: String
    
    //MARK: Stored Properties
    var placeHolder: String
    var fontDetails: (size: CGFloat, weight: Font.Weight) = (size: 24, weight: .semibold)
    var keyboardType: UIKeyboardType = .alphabet
    var textFieldType: NATextFieldTypes = .defaultStyle
    var textLimit: Int! = nil
    var backspaceEvent: (() -> ())?
    
    public init(value: Binding<String>, placeHolder: String = "", fontDetails: (size: CGFloat, weight: Font.Weight) = (size: 24, weight: .semibold), keyboardType: UIKeyboardType = .alphabet, textFieldType: NATextFieldTypes = .defaultStyle, textLimit: Int! = nil, backspaceEvent: (() -> Void)? = nil) {
        self._value = value
        self.placeHolder = placeHolder
        self.fontDetails = fontDetails
        self.keyboardType = keyboardType
        self.textFieldType = textFieldType
        self.textLimit = textLimit
        self.backspaceEvent = backspaceEvent
    }
    
    //MARK: Computed Properties
    @ViewBuilder
    var getTextFieldBackground: some View {
        switch textFieldType {
        case .withSeparator, .defaultStyle, .singleCharacter, .defaultStyleWithoutPlaceholder:
            RoundedRectangle(cornerRadius: 8).stroke(value != "" ? .black : .gray, lineWidth: 1)
        case .backgroundColor(let backgroundColor):
            RoundedRectangle(cornerRadius:8)
                .foregroundColor(backgroundColor).opacity(0.1)
        }
    }
    
    @ViewBuilder
    var getTextField: some View {
        switch textFieldType {
        case .withSeparator, .defaultStyle, .backgroundColor, .defaultStyleWithoutPlaceholder:
            TextField(textFieldType == .defaultStyle ? "" : placeHolder, text: $value)
                .font(.system(size: fontDetails.size, weight: fontDetails.weight))
                .keyboardType(keyboardType)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .tint(.black)
                .padding(.horizontal, 10)
                .contentShape(Rectangle())
        case .singleCharacter:
            SingleDigitTF(singleDigit: $value, placeholder: placeHolder) { a in
                backspaceEvent?()
            }.fixedSize()
        }
    }
    
    public var body: some View {
        VStack {
            ZStack {
                getTextFieldBackground
                if textFieldType == .defaultStyle {
                    topPlaceHolder(placeHolder: placeHolder)
                }
                HStack(spacing: 0) {
                    if textFieldType == .withSeparator {
                        Text("+91 ").font(.system(size: fontDetails.size, weight: fontDetails.weight))
                            .padding(.horizontal, 10)
                        Divider()
                            .frame(height: 30)
                            .frame(minWidth: 1)
                            .overlay(Color.black)
                    }
                    getTextField
                        .onReceive(Just(value)) { a in
                            if textLimit != nil {
                                limitText(textLimit)
                            }
                        }
                }
            }
            .frame(width: textFieldType == .singleCharacter ? 50 : nil, height: 50)
        }
    }
    
    /// Returns placeholder which will be placed on top left corner of the textfield
    func topPlaceHolder(placeHolder: String) ->  some View {
        VStack {
            HStack {
                ZStack {
                    Rectangle().foregroundColor(appTheme.current.onPrimary)
                    Text(placeHolder).font(.system(size: 12, weight: .regular)).padding(.horizontal, 12)
                }.fixedSize()
                Spacer()
            }
            Spacer()
        }.offset(x: 10, y: -10)
    }
    
    /// Limit the number characters allowed by a textfield
    func limitText(_ upper: Int) {
        if value.count > upper {
            value = String(value.prefix(upper))
        }
    }
}

struct SingleDigitTF: UIViewRepresentable {
    
    @Binding var singleDigit: String
    let placeholder: String
    let onBackspace: (Bool) -> Void
    
    func makeCoordinator() -> SingleDigitTFCoordinator {
        SingleDigitTFCoordinator(singleDigit: $singleDigit)
    }
    
    func makeUIView(context: Context) -> SingleDigitTF {
        let singleDigitTF = SingleDigitTF()
        singleDigitTF.placeholder = placeholder
        singleDigitTF.keyboardType = .numberPad
        singleDigitTF.autocorrectionType = .no
        singleDigitTF.delegate = context.coordinator
        singleDigitTF.font = .systemFont(ofSize: 24)
        return singleDigitTF
    }
    
    func updateUIView(_ singleDigitTF: SingleDigitTF, context: Context) {
        singleDigitTF.text = singleDigit
        singleDigitTF.onBackspace = onBackspace
    }
    
    class SingleDigitTF: UITextField {
        
        var onBackspace: ((Bool) -> Void)?
        
        override init(frame: CGRect) {
            onBackspace = nil
            super.init(frame: frame)
        }
        
        required init?(coder: NSCoder) {
            fatalError()
        }
        
        override func deleteBackward() {
            onBackspace?(text?.isEmpty == true)
            super.deleteBackward()
        }
    }
}

class SingleDigitTFCoordinator: NSObject, UITextFieldDelegate {
    
    var singleDigit: Binding<String>
    
    init(singleDigit: Binding<String>) {
        self.singleDigit = singleDigit
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        singleDigit.wrappedValue = string
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 1
    }
}

public enum NATextFieldTypes: Equatable {
    case defaultStyle
    case defaultStyleWithoutPlaceholder
    case singleCharacter
    case withSeparator
    case backgroundColor(Color)
}

