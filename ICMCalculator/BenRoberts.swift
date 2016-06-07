//
//  BenRoberts.swift
//  ICMCalculator
//
//  Created by Isaac Flaum on 4/22/16.
//  Copyright © 2016 iflaum. All rights reserved.
//

import Foundation

public class BenRoberts {

    // used to sum up the inverse of all the remaining players' stacks.
    private func helperInverseSummation(stack: Int, stacks: [Int]) -> Double {
        return stacks.reduce(0.0, combine: {
            $0 + (1 / Double($1))
        }) - (1.0 / Double(stack));
    }

    // sums an array of doubles
    private func total(stacks: [Double]) -> Double {
        return stacks.reduce(0.0, combine: +);
    }
    
    // calculates proportions for probability of next elimination
    private func nextEliminationProportions(stacks: [Int]) -> [Double] {
        return stacks.map({
            ( 1.0 / Double($0 * $0) ) * helperInverseSummation($0, stacks: stacks)
        });
    }

    private func proportionsToProbabilities(proportions: [Double]) -> [Double] {
        let sum = total(proportions);
        return proportions.map({
            $0 / sum;
        });
    }

    private func nextEliminationProbabilities(stacks: [Int]) -> [Double] {
        let proportions = nextEliminationProportions(stacks);
        return proportionsToProbabilities(proportions);
    }
    
    private func distributeStackInverselyProportional(stack: Double, stacks: [Double]) -> [Double] {
        let sum = total(stacks);
        let inverseProportions = stacks.map({ sum / $0 });
        let inverseProportionsSum = total(inverseProportions);
        var mutableStackArray = stacks;
        for (index, _) in stacks.enumerate() {
            mutableStackArray[index] = stacks[index] + (inverseProportions[index] / inverseProportionsSum) * stack;
        }
        return mutableStackArray;
    }

}
