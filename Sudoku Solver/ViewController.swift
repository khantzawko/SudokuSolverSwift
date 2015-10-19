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
            
            for var i = 1; i <= MAXNUM; i++ {
                
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
        
        for var row = 0; row < grid.count; row++ {
            
            for var col = 0; col < grid.count; col++ {
                
                if grid[row][col] == 0 {
                    
                    temp = [row,col]
                    
                    return temp
                }

            }

        }
        
        return temp
    }
    
    func isSafe(row:Int, col:Int, num:Int) -> Bool {
        
        return checkRow(row, col: col, num: num)
            && checkCol(row, col: col, num: num)
            && checkGrid(row, col: col, num: num)

    }
    
    func checkRow(row: Int, col: Int, num: Int) -> Bool {
        
        for var i = 0; i < grid.count; i++ {
            
            if (grid[row][i] == num) {
                
                return false
            }

        }
        
        return true
    }
    
    func checkCol(row: Int, col: Int, num: Int) -> Bool {
        
        for var i = 0; i < grid.count; i++ {
            
            if (grid[i][col] == num) {
                
                return false
            }
            
        }
        
        return true
    }
    
    func checkGrid(var row: Int, var col: Int, num: Int) -> Bool {
        
        row = row - (row % SQN)
        col = col - (col % SQN)

        for var i = 0; i < SQN; i++ {
            
            for var j = 0; j < SQN; j++ {
                
                if grid[i + row][j + col] == num {
                    
                    return false
                }
            }
        }
        
        return true
    }

    
    func printGrid()->() {
        
        for var row = 0; row < grid.count; row++ {
            
            print("\(grid[row])")
            
        }
 
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        grid = [[3, 0, 6, 5, 0, 8, 4, 0, 0],
                [5, 2, 0, 0, 0, 0, 0, 0, 0],
                [0, 8, 7, 0, 0, 0, 0, 3, 1],
                [0, 0, 3, 0, 1, 0, 0, 8, 0],
                [9, 0, 0, 8, 6, 3, 0, 0, 5],
                [0, 5, 0, 0, 9, 0, 6, 0, 0],
                [1, 3, 0, 0, 0, 0, 2, 5, 0],
                [0, 0, 0, 0, 0, 0, 0, 7, 4],
                [0, 0, 5, 2, 0, 6, 3, 0, 0]]
        
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

