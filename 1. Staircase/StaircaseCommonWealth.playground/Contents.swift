import UIKit

// MARK: - CREATED BY NUR IRFAN PANGESTU
func staircase(n: Int) -> Void {
    
    for index in 1...n {
        let counter = n - index
        if (index != 1) {
            print()
        }
        for i in 1...n {
            if (counter < i) {
                print("#", terminator: "")
            } else {
                print(" ", terminator: "")
            }
        }
    }
    
}

print("\(staircase(n: 7))")
