import UIKit

class RatingControl: UIView {
    
    // MARK: Properties
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton] ()
    var spacing = 5
    var stars = 5
    
    
    
    //MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        
        
        for _ in 0..<stars {
            let button = UIButton()
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            button.adjustsImageWhenDisabled = false
            
            // this is the programmatic way to link a ui element to code
            // to be executed when an action is triggered.
            // self refers to the RatingControl class because that's where
            // the action is defined
            //
            // because we're not using Interface Builder, we don't have to
            // define the action method ratingButtonTapped with IBOutlet
            // attribute
            button.addTarget(self, action: "ratingButtonTapped:", forControlEvents: .TouchDown)
            ratingButtons += [button]
            addSubview(button)
        }

    }
    
    override func layoutSubviews() {
        //print("hello from layoutSubviews()")
        
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + 5))
            button.frame = buttonFrame
        
        }
        
        updateButtonSelectionStates()
    }

    
    // to tell the stackview how to layout this custom view you must
    // override this method and match it to be what dimensions are set
    // for it in interface builder
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize + spacing) * stars
        return CGSize(width: width, height: buttonSize)
    }
    
    

    // MARK: Button Action
    func ratingButtonTapped(button: UIButton) {
        rating = ratingButtons.indexOf(button)! + 1
        
        updateButtonSelectionStates()
    }


    func updateButtonSelectionStates() {
        
        for (index, button) in ratingButtons.enumerate() {
            
            // if the index of the button is less than the rating, that button should
            // selected.
            button.selected = index < rating
        }
    
    
    }
}
