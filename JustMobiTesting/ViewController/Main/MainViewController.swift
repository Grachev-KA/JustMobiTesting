import UIKit

final class MainViewController: UIViewController {
    private var timerManager: TimerManager?

    private let giftView: GiftView = {
        let view = GiftView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundColor()
        setupSubviews()
        setupConstraints()
        initializeTimer(hours: 0, minutes: 25, seconds: 14)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
        startAnimateGiftView()
    }
    
    // MARK: - Initialize Timer
    
    private func initializeTimer(hours: Int, minutes: Int, seconds: Int) {
        guard timerManager == nil else { return }
        
        timerManager = TimerManager(hours: hours, minutes: minutes, seconds: seconds)
        
        timerManager?.onUpdate = { [weak self] hours, minutes, seconds in
            guard let self else { return }
            self.giftView.updateCountdownLabel(hours, minutes, seconds)
        }
        
        timerManager?.onCompletion = { [weak self] in
            guard let self else { return }
            self.stopTimer()
        }
    }
    
    // MARK: - Setup Methods
    
    private func startTimer() {
        timerManager?.startTimer()
    }
    
    private func stopTimer() {
        timerManager?.stopTimer()
        timerManager = nil
    }
    
    private func setupBackgroundColor() {
        view.backgroundColor = .white
    }
    
    private func setupSubviews() {
        view.addSubview(giftView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            giftView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            giftView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            giftView.topAnchor.constraint(equalTo: view.topAnchor),
            giftView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Animation Control
    
    private func startAnimateGiftView() {
        giftView.animateGift()
    }
}
