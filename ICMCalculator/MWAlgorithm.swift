//
//  MWAlgorithm.swift
//  ICMCalculator
//
//  Created by Isaac Flaum on 3/27/16.
//  Copyright © 2016 iflaum. All rights reserved.
//

import Foundation

public class MWAlgorithm {
    
    // Probability each player comes in first
    public func pFirsts(stacks: [Int]) -> [Double] {
        let stackTotal = total(stacks);
        return stacks.map({ Double($0) / Double(stackTotal) });
    }
    
    // Probability each player comes in second
    public func pSeconds(stacks: [Int]) -> [Double] {
        let stackTotal = total(stacks);
        let pFirstPlaces = pFirsts(stacks);
        var seconds : [Double] = [];
        
        for (index, player) in stacks.enumerate() {
            // stack is current player, lets calculate probabilities
            // current stack comes in second when each player wins
            var pSecondSum : Double = 0;
            for (index2, player2) in stacks.enumerate() {
                if index == index2 {
                    continue;
                }
                // weighting for p2 winning, lets calculate player's odds of
                // winning an indipendent tournament with the remaining players
                pSecondSum += Double(pFirstPlaces[index2]) * (Double(player) / (Double(stackTotal) - Double(player2)));
            }
            seconds.append(pSecondSum);
        }
        return seconds;
    }
    
    // totals an array of stack integers
    func total(stacks: [Int]) -> Int {
        return stacks.reduce(0, combine: +);
    }
}
