//
//  HoursViewController.swift
//  Access News Uploader
//
//  Created by Society for the Blind on 1/3/18.
//  Copyright © 2018 Society for the Blind. All rights reserved.
//

import UIKit
import Social

class HoursViewController: ConfigurationItemViewController {

    lazy var durationPicker: UIDatePicker = {

        let picker = self.createView(from: UIDatePicker.self)
        picker.datePickerMode = .countDownTimer
        picker.minuteInterval = 5

        return picker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

/* ===========================================================================
 TODO: DRY up:

 This block is the same for any configuration item. How could this be
 moved up to ConfigurationItemViewController? The button pushes the
 new value back to main interface. */

        self.title = "Time spent reading?"
        self.view.addSubview(durationPicker)

        let doneButton = UIBarButtonItem(title:   "Done"
                                        , style:  .done
                                        , target: self
                                        , action: #selector(doneButtonClicked)
                                        )
        self.navigationItem.rightBarButtonItem = doneButton
    }

    @objc func doneButtonClicked() {

        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated

        let durationInSeconds = durationPicker.countDownDuration
        guard let durationString = formatter.string(from: durationInSeconds)
            else { return }

        self.delegate.updateValue(durationString)
        self.delegate.backToMain()
    }
/* ===========================================================================*/


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
