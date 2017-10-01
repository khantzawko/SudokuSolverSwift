//
//  ViewController.swift
//  Sudoku Solver
//
//  Created by Khant Zaw Ko on 4/7/15.
//  Copyright © 2015 Khant Zaw Ko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let UNASSIGNED = 0
    let MAXNUM = 9
    let SQN = 3

    var grid = [[Int]]()
    
    func solveSudoku() -> Bool {
        
        var temp = findUnassignedLocation()
        
        if !temp.isEmpty {
            
            let row = temp[0]
            let col = temp[1]
            
            for i in 1...MAXNUM {
                
                if isSafe(row, col: col, num: i) {
                    grid[row][col] = i
                    
                    if solveSudoku() {
                        return true
                    }
                    grid[row][col] = UNASSIGNED
                }
            }

        } else {
            return true
        }
        
        return false
    }
    
    func findUnassignedLocation() -> [Int] {
        
        var temp = [Int]()
        for row in 0 ..< grid.count {
            for col in 0 ..< grid.count {
                if grid[row][col] == 0 {
                    temp = [row,col]
                    return temp
                }
            }
        }
        return temp
    }
    
    func isSafe(_ row:Int, col:Int, num:Int) -> Bool {
        
        return checkRow(row, col: col, num: num)
            && checkCol(row, col: col, num: num)
            && checkGrid(row, col: col, num: num)

    }
    
    func checkRow(_ row: Int, col: Int, num: Int) -> Bool {
        
        for i in 0 ..< grid.count {
            if (grid[row][i] == num) {
                return false
            }
        }
        return true
    }
    
    func checkCol(_ row: Int, col: Int, num: Int) -> Bool {
        
        for i in 0 ..< grid.count {
            if (grid[i][col] == num) {
                return false
            }
        }
        return true
    }
    
    func checkGrid(_ row: Int, col: Int, num: Int) -> Bool {
        var row = row, col = col
        
        row = row - (row % SQN)
        col = col - (col % SQN)

        for i in 0 ..< SQN {
            for j in 0 ..< SQN {
                if grid[i + row][j + col] == num {
                    return false
                }
            }
        }
        return true
    }

    
    func printGrid()->() {
        
        for row in 0 ..< grid.count {
            
            print("\(grid[row])")
            
        }
 
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        grid = [[5, 6, 0, 0, 0, 1, 0, 7, 0],
                [0, 0, 8, 0, 0, 2, 0, 0, 0],
                [0, 1, 0, 8, 6, 0, 0, 0, 9],
                [0, 0, 0, 9, 0, 0, 0, 0, 1],
                [1, 0, 5, 0, 0, 0, 0, 0, 0],
                [0, 4, 0, 0, 8, 0, 0, 5, 6],
                [0, 0, 2, 0, 0, 0, 0, 8, 0],
                [8, 7, 0, 0, 0, 0, 0, 0, 0],
                [6, 0, 1, 0, 0, 0, 0, 0, 5]]
        
        print("unsolved sudoku");
        
        printGrid()
        
        if solveSudoku() == true {
            
            print("\n" + "solved sudoku");
            
            printGrid()
            
        } else {
            
            print("The data you give me is wrong!")
        }
    }
}

