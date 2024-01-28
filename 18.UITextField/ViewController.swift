import UIKit

class ViewController: UIViewController {

    let textField = UITextField()
    let sendButton = UIButton()
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        setupTextField()
        setupButton()
        setupLabel()
    }

    func setupTextField() {
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOpacity = 0.8
        textField.layer.shadowOffset = CGSize(width: 2, height: 2)
        textField.layer.shadowRadius = 2
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 10
        textField.placeholder = "write text"
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.black.cgColor
        textField.backgroundColor = .white
        textField.keyboardType = .default
        textField.returnKeyType = .send
        textField.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(textField)

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 600),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            textField.heightAnchor.constraint(equalToConstant: 31)
        ])
    }

    func setupButton() {
        sendButton.setTitle("SEND", for: .normal)
        sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)

        sendButton.setTitleColor(.black, for: .normal)
        sendButton.layer.shadowColor = UIColor.black.cgColor
        sendButton.layer.shadowOpacity = 0.8
        sendButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        sendButton.layer.shadowRadius = 2
        sendButton.layer.cornerRadius = 15
        sendButton.layer.borderWidth = 1.0
        sendButton.backgroundColor = .orange
        sendButton.addTarget(self, action: #selector(buttonAnimation(_:)), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(buttonSend), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sendButton)

        NSLayoutConstraint.activate([
            sendButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150 ),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150 ),
            sendButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc func buttonAnimation(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { finished in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            }
        }
    }

    @objc func buttonSend() {
        if let text = textField.text, !text.isEmpty {
            label.text = text
            textField.text = ""
        }
    }

    func setupLabel() {
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1.0
        label.backgroundColor = .white
        label .textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)

        NSLayoutConstraint.activate([
            
            label.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -30),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            label.heightAnchor.constraint(equalToConstant: 150)
        ])
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }

    @objc private func keyboardShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let bottomSpace = view.frame.height - (sendButton.frame.origin.y + sendButton.frame.height + view.frame.origin.y + 10)
            view.frame.origin.y -= keyboardHeight - bottomSpace
        }
    }

    @objc private func keyboardHide() {
        view.frame.origin.y = 0
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
