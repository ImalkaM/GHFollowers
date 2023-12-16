//
//  GFButton.swift
//  GHFollowers
//
//  Created by Imalka Muthukumara on 2023-06-11.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor:UIColor,title:String,systemImageName:String){
        self.init(frame: .zero)
        set(color: backgroundColor, title: title, systemImageName: systemImageName)
    }
    
    private func configure(){
        
        if #available(iOS 15.0, *) {
            configuration = .tinted()
            configuration?.cornerStyle = .medium
        } else {
            layer.cornerRadius    = 10
            setTitleColor(.white, for: .normal)
        }
        titleLabel?.font      = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(color:UIColor,title:String,systemImageName:String){
        
        if #available(iOS 15.0, *) {
            configuration?.baseBackgroundColor = color
            configuration?.baseForegroundColor = color
            configuration?.image = UIImage(systemName: systemImageName)
            configuration?.imagePadding = 6
            configuration?.imagePlacement = .leading
        } else {
            self.backgroundColor = backgroundColor
        }
        setTitle(title, for: .normal)
    }
    
}

#Preview{
    let image = GFButton(backgroundColor: .red, title: "Okay", systemImageName: "calendar")
    
    return image
}
