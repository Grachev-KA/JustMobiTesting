import UIKit

final class GiftView: UIView {
    private let giftViewAnimator: GiftViewAnimator?
    
    private let countdownLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let boxImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "box"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let circleBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 75
        return view
    }()
    
    private let starImageViews: [UIImageView] = {
        (0..<5).map { _ in
            let starView = UIImageView(image: UIImage(named: "star"))
            starView.translatesAutoresizingMaskIntoConstraints = false
            starView.alpha = 0
            return starView
        }
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        self.giftViewAnimator = GiftViewAnimator(boxImageView: boxImageView, starImageViews: starImageViews)
        super.init(frame: frame)
        setupSubviews()
        setupBoxConstraints()
        setupStarsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Interfaces
    
    func updateCountdownLabel(_ hours: Int, _ minutes: Int, _ seconds: Int) {
        countdownLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func animateGift() {
        giftViewAnimator?.animateGift()
    }
    
    // MARK: - Setup Methods
    
    private func setupSubviews() {
        addSubview(circleBackgroundView)
        circleBackgroundView.addSubview(boxImageView)
        circleBackgroundView.addSubview(countdownLabel)
        starImageViews.forEach { addSubview($0) }
    }
    
    private func setupBoxConstraints() {
        NSLayoutConstraint.activate([
            circleBackgroundView.widthAnchor.constraint(equalToConstant: 150),
            circleBackgroundView.heightAnchor.constraint(equalTo: circleBackgroundView.widthAnchor),
            circleBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleBackgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            boxImageView.topAnchor.constraint(equalTo: circleBackgroundView.topAnchor, constant: 20),
            boxImageView.centerXAnchor.constraint(equalTo: circleBackgroundView.centerXAnchor),
            boxImageView.widthAnchor.constraint(equalToConstant: 100),
            boxImageView.heightAnchor.constraint(equalTo: boxImageView.widthAnchor, constant: -10),
            
            countdownLabel.topAnchor.constraint(equalTo: boxImageView.bottomAnchor),
            countdownLabel.centerXAnchor.constraint(equalTo: circleBackgroundView.centerXAnchor),
            countdownLabel.widthAnchor.constraint(equalTo: circleBackgroundView.widthAnchor, multiplier: 0.8)
        ])
    }
    
    private func setupStarsConstraints() {
        guard starImageViews.count == 5 else { return }
        
        NSLayoutConstraint.activate([
            starImageViews[0].centerXAnchor.constraint(equalTo: boxImageView.centerXAnchor, constant: -30),
            starImageViews[0].centerYAnchor.constraint(equalTo: boxImageView.centerYAnchor, constant: -20),
            
            starImageViews[1].centerXAnchor.constraint(equalTo: boxImageView.centerXAnchor, constant: 30),
            starImageViews[1].centerYAnchor.constraint(equalTo: boxImageView.centerYAnchor, constant: -30),
            
            starImageViews[2].centerXAnchor.constraint(equalTo: boxImageView.centerXAnchor, constant: 5),
            starImageViews[2].centerYAnchor.constraint(equalTo: boxImageView.centerYAnchor, constant: -45),
            
            starImageViews[3].centerXAnchor.constraint(equalTo: boxImageView.centerXAnchor, constant: 25),
            starImageViews[3].centerYAnchor.constraint(equalTo: boxImageView.centerYAnchor, constant: -50),
            
            starImageViews[4].centerXAnchor.constraint(equalTo: boxImageView.centerXAnchor, constant: -20),
            starImageViews[4].centerYAnchor.constraint(equalTo: boxImageView.centerYAnchor, constant: -55)
        ])
        
        for (index, starView) in starImageViews.enumerated() {
            let size: CGFloat = 18 - CGFloat(index) * 2
            NSLayoutConstraint.activate([
                starView.widthAnchor.constraint(equalToConstant: size),
                starView.heightAnchor.constraint(equalTo: starView.widthAnchor)
            ])
        }
    }
}
