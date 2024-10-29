import Foundation

final class TimerManager {
    private var timer: Timer?
    private var countdownTime: Int
    
    var onUpdate: ((Int, Int, Int) -> Void)?
    var onCompletion: (() -> Void)?
    
    // MARK: - Initializer
    
    init(hours: Int, minutes: Int, seconds: Int) {
        self.countdownTime = TimerManager.convertToTotalSeconds(hours: hours, minutes: minutes, seconds: seconds)
    }
    
    init(totalSeconds: Int) {
        self.countdownTime = totalSeconds
    }

    // MARK: - Public Interfaces
    
    func startTimer() {
        updateUI()
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateCountdown),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    // MARK: - Private Methods
    
    @objc private func updateCountdown() {
        if countdownTime > 0 {
            countdownTime -= 1
            updateUI()
        } else {
            timer?.invalidate()
            timer = nil
            onCompletion?()
        }
    }

    private func updateUI() {
        let (hours, minutes, seconds) = TimerManager.convertToHMS(countdownTime)
        onUpdate?(hours, minutes, seconds)
    }
    
    private static func convertToTotalSeconds(hours: Int, minutes: Int, seconds: Int) -> Int {
        return (hours * 3600) + (minutes * 60) + seconds
    }
    
    private static func convertToHMS(_ totalSeconds: Int) -> (Int, Int, Int) {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return (hours, minutes, seconds)
    }
}
