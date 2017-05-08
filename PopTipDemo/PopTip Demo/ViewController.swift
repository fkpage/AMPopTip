//
//  ViewController.swift
//  PopTip Demo
//
//  Created by Andrea Mazzini on 01/05/2017.
//  Copyright © 2017 Andrea Mazzini. All rights reserved.
//

import UIKit
import AMPopTip

class ViewController: UIViewController {

  enum ButtonType: Int {
    case center, topLeft, topRight, bottomLeft, bottomRight
  }

  let popTip = PopTip()
  var direction = PopTipDirection.up
  var topRightDirection = PopTipDirection.down

  override func viewDidLoad() {
    super.viewDidLoad()

    popTip.font = UIFont(name: "Avenir-Medium", size: 12)!
    popTip.shouldDismissOnTap = true
    popTip.edgeMargin = 5
    popTip.offset = 2
    popTip.bubbleOffset = 0
    popTip.edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10)

    popTip.actionAnimation = .bounce(8)

    popTip.tapHandler = { _ in
      print("tap")
    }

    popTip.dismissHandler = { _ in
      print("dismiss")
    }
  }

  @IBAction func action(sender: UIButton) {
    guard let button = ButtonType(rawValue: sender.tag) else { return }

    switch button {
    case .topLeft:
      let customView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 120))
      let imageView = UIImageView(image: UIImage(named: "comment"))
      imageView.frame = CGRect(x: (80 - imageView.frame.width) / 2, y: 0, width: imageView.frame.width, height: imageView.frame.height)
      customView.addSubview(imageView)
      let label = UILabel(frame: CGRect(x: 0, y: imageView.frame.height, width: 80, height: 120 - imageView.frame.height))
      label.numberOfLines = 0
      label.text = "This is a custom view"
      label.textAlignment = .center
      label.textColor = .white
      label.font = UIFont.systemFont(ofSize: 12)
      customView.addSubview(label)
      popTip.bubbleColor = UIColor(red: 0.95, green: 0.65, blue: 0.21, alpha: 1)
      popTip.show(customView: customView, direction: .down, in: view, from: sender.frame)
    case .topRight:
      popTip.bubbleColor = UIColor(red: 0.97, green: 0.9, blue: 0.23, alpha: 1)
      if topRightDirection == .left {
        topRightDirection = .down
      } else {
        topRightDirection = .left
      }
      popTip.show(text: "I have a offset to move the bubble down or left side.", direction: topRightDirection, maxWidth: 150, in: view, from: sender.frame)
    case .bottomLeft:
      popTip.bubbleColor = UIColor(red: 0.73, green: 0.91, blue: 0.55, alpha: 1)
      let attributes: [String: Any] = [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: UIColor.white]
      let underline: [String: Any] = [NSFontAttributeName: UIFont.systemFont(ofSize: 13), NSForegroundColorAttributeName: UIColor.white, NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
      let attributedText = NSMutableAttributedString(string: "I'm presenting a string ", attributes: attributes)
      attributedText.append(NSAttributedString(string: "with attributes!", attributes: underline))
      popTip.show(attributedText: attributedText, direction: .up, maxWidth: 200, in: view, from: sender.frame)
    case .bottomRight:
      popTip.bubbleColor = UIColor(red: 0.81, green: 0.04, blue: 0.14, alpha: 1)
      popTip.show(text: "Animated popover, great for subtle UI tips and onboarding", direction: .left, maxWidth: 200, in: view, from: sender.frame)
    case .center:
      popTip.bubbleColor = UIColor(red: 0.31, green: 0.57, blue: 0.87, alpha: 1)
      popTip.show(text: "Animated popover, great for subtle UI tips and onboarding", direction: direction, maxWidth: 200, in: view, from: sender.frame)
      direction = direction.cycleDirection()
    }
  }

}

extension PopTipDirection {
  func cycleDirection() -> PopTipDirection {
    switch self {
    case .up:
      return .right
    case .right:
      return .down
    case .down:
      return .left
    case .left:
      return .up
    case .none:
      return .none
    }
  }
}
