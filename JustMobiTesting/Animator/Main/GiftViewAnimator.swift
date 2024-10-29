import UIKit

final class GiftViewAnimator {
    private let boxImageView: UIImageView
    private let starImageViews: [UIImageView]

    // MARK: - Initializer
    
    init(boxImageView: UIImageView, starImageViews: [UIImageView]) {
        self.boxImageView = boxImageView
        self.starImageViews = starImageViews
    }

    // MARK: - Public Interface
    
    func animateGift() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.animateBox(count: 6, duration: 0.1) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.repeatAnimateBox()
                }
            }
        }
        animateStars()
    }
    
    // MARK: - Box Animation

    private func animateBox(count: Int, duration: TimeInterval, completion: @escaping () -> Void) {
        boxImageView.transform = .identity
        let shakeAngle: CGFloat = .pi / 30

        for i in 0..<count {
            let direction: CGFloat = (i % 2 == 0) ? -shakeAngle : shakeAngle
            UIView.animate(
                withDuration: duration,
                delay: Double(i) * duration,
                options: [.curveEaseInOut],
                animations: { self.boxImageView.transform = CGAffineTransform(rotationAngle: direction) },
                completion: nil
            )
        }

        UIView.animate(
            withDuration: duration,
            delay: Double(count) * duration,
            options: [],
            animations: { self.boxImageView.transform = .identity },
            completion: { _ in completion() }
        )
    }

    private func repeatAnimateBox() {
        animateBox(count: 6, duration: 0.1) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.animateGift()
            }
        }
    }
    
    // MARK: - Stars Animation

    private func animateStars() {
        for (index, starView) in starImageViews.enumerated() {
            animateStar(starView, delay: Double(index) * 0.3)
        }
    }

    private func animateStar(_ starView: UIImageView, delay: Double) {
        UIView.animateKeyframes(
            withDuration: 6.5,
            delay: delay,
            options: [.repeat],
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.1) { starView.alpha = 1 }
                UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.1) { starView.alpha = 0 }
                UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.1) { starView.alpha = 1 }
                UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.1) { starView.alpha = 0 }
            },
            completion: nil
        )
    }
}
