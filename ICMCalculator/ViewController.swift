//
//  ViewController.swift
//  ICMCalculator
//
//  Created by Isaac Flaum on 3/27/16.
//  Copyright © 2016 iflaum. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var firstPlacePayout: UITextField!
    @IBOutlet weak var secondPlacePayout: UITextField!
    @IBOutlet var playerStackSizes: [UITextField]!
    @IBOutlet var playerEquityLabels: [UILabel]!
    @IBOutlet weak var algorithmToggle: UISegmentedControl!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var chipTotalLabel: UILabel!
    var mwAlgorithm = MWAlgorithm();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // add action to dismiss keyboard when tap
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    // gesture recognizer calls this function when tap is recognized.
    func dismissKeyboard() {
        view.endEditing(true)
    }
    

    // MARK: Actions
    @IBAction func calculateEquities(sender: UIButton) {
        
        // add stacks safely to array
        var stacks = [Int]();
        for s in self.playerStackSizes {
            if let text = s.text {
                if let stack = Int(text) {
                    stacks.append(stack);
                } else {
                    stacks.append(0);
                }
            }
        }
        
        // calculate probabilities of coming in first and second using 
        // Malmuth-Weitzman algorithm
        var p1sts = mwAlgorithm.pFirsts(stacks);
        var p2nds = mwAlgorithm.pSeconds(stacks);
        print(p1sts);
        print(p2nds);
        
        // calculate equities using expected value formula
        var equities : [Double] = [];
        if let firstText = firstPlacePayout.text {
            if let firstDouble = Double(firstText) {
                if let secondText = secondPlacePayout.text {
                    if let secondDouble = Double(secondText) {
                        for (index, _) in p1sts.enumerate() {
                            var equity : Double = 0;
                            equity += p1sts[index] * firstDouble;
                            equity += p2nds[index] * secondDouble;
                            equities.append(equity);
                        }
                    }
                }
            }
        }
        
        // update equity labels
        for (index, label) in self.playerEquityLabels.enumerate() {
            if equities.count > 0 {
                label.text = String( round( 1000 * equities[index]) / 1000 );
            }
        }

    }
    
    // update the total chip count
    @IBAction func updateTotal(sender: UITextField) {
        var total = 0;
        for s in self.playerStackSizes {
            if let text = s.text {
                if let stack = Int(text) {
                    total += stack;
                }
            }
        }
        chipTotalLabel.text = "Total: \(total)";
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

