//
//  ViewController.swift
//  ThreadOrder
//
//  Created by Kira on 30.03.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        completeThreadOrder()
    }

    // Каждый метод запускать по отдельности
    private func completeThreadOrder() {
        // кейс 123
        //completeOrderOne()
        // кейс 321
        //completeOrderTwo()
        // кейс 312
        //completeOrderThree()
    }
    
    private func completeOrderOne() {
        let lock = NSLock()
        
        let thread1 = Thread {
            lock.lock()
            print("1")
            lock.unlock()
        }
        
        let thread2 = Thread {
            lock.lock()
            print("2")
            lock.unlock()
        }
        
        let thread3 = Thread {
            lock.lock()
            print("3")
            lock.unlock()
        }
        
        thread1.start()
        thread2.start()
        thread3.start()
    }
    
    private func completeOrderTwo() {
        let lock = NSRecursiveLock()
        
        let thread1 = Thread {
            lock.lock()
            print("1")
            lock.unlock()
        }
        
        let thread3 = Thread {
            lock.lock()
            thread1.start()
            print("3")
            lock.unlock()
        }
        
        let thread2 = Thread {
            lock.lock()
            thread3.start()
            print("2")
            lock.unlock()
        }
        
        thread2.start()
    }
    
    private func completeOrderThree() {
        var check1 = false
        var check2 = false
        
        let condition = NSCondition()
        
        let thread2 = Thread {
            condition.lock()
            while(!check1) {
                condition.wait()
            }
            print("2")
            condition.unlock()
        }
        
        let thread1 = Thread {
            condition.lock()
            while(!check2) {
                condition.wait()
            }
            print("1")
            check1 = true
            condition.signal()
            condition.unlock()
        }
        
        let thread3 = Thread {
            condition.lock()
            print("3")
            check2 = true
            condition.signal()
            condition.unlock()
        }
        
        thread1.start()
        thread2.start()
        thread3.start()
    }
}

