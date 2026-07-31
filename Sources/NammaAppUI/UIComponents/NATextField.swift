//
//  NATextField.swift
//  NammaAppUI
//
//  Created by apple on 29/01/26.
//


import SwiftUI
import Combine

public struct NASearchBar: View {
    @Binding public var searchText: String
    @FocusState private var isFocused: Bool
    
    public var onBackTap: (() -> Void)?
    public var onMicTap: (() -> Void)?
    public var onSubmit: (() -> Void)?

    public init(
        searchText: Binding<String>,
        onBackTap: (() -> Void)? = nil,
        onMicTap: (() -> Void)? = nil,
        onSubmit: (() -> Void)? = nil
    ) {
        self._searchText = searchText
        self.onBackTap = onBackTap
        self.onMicTap = onMicTap
        self.onSubmit = onSubmit
    }

    public var body: some View {
        HStack(spacing: 12) {
            Button(action: {
                onBackTap?()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
            }

            TextField("Search for atta, dal, coke and more", text: $searchText)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.15))
                .focused($isFocused)
                .submitLabel(.search)
                .onSubmit {
                    onSubmit?()
                }

            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.gray.opacity(0.7))
                }
            }

            Rectangle()
                .fill(Color.gray.opacity(0.25))
                .frame(width: 1, height: 22)
                .padding(.horizontal, 2)
            
            Button(action: {
                onMicTap?()
            }) {
                Image(systemName: "mic.fill")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color(red: 253/255, green: 252/255, blue: 248/255))
        .clipShape(Capsule())
        .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
        .shadow(color: Color.black.opacity(0.03), radius: 2, x: 0, y: 1)
    }
}

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

