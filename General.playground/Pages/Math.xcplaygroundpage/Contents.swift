//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


let nan = Double.nan
let inf = Double.infinity

nan > 10
nan < 10
nan == 10

nan == nan
nan != nan
nan == -nan
nan != -nan

10.0 / 0
-10.0 / 0
10.0 / 1
-10.0 / 1

10.0 / -1
-10.0 / 1

0 / -1
-1 / 0.0
2 / -5

0.0 / 0.0
inf > inf
inf < inf
inf == inf
0 / inf
0 / -inf
5 / inf
-5 / inf
5 / -inf
5.0 / 0
inf / 0
-inf / 0
inf - inf
inf + inf

-inf + -inf

12 % 1
12 % 5
12 % -5
-12 % 5
-12 % -5
5 % 12
5 % -12
-5 % 12
-5 % -12

5 % 5
5 % -5
-5 % 5
-5 % -5

0 % 3
//3 % 0

5 % 2
5.0.remainder(dividingBy: 2.0)
5.0.remainder(dividingBy: -2.0)
-5.0.remainder(dividingBy: -2.0)
5.0.remainder(dividingBy: Double.infinity)
Double.infinity.remainder(dividingBy: Double.infinity)
Double.infinity.remainder(dividingBy: -Double.infinity)
Double.infinity.remainder(dividingBy: 2.0)
0.0.remainder(dividingBy: 0.0)
0.0.remainder(dividingBy: Double.infinity)
0.0.remainder(dividingBy: -Double.infinity)
5.0.remainder(dividingBy: 0.0)
-5.0.remainder(dividingBy: 0.0)

5.0.remainder(dividingBy: 5.0)
5.0.remainder(dividingBy: -5.0)
-5.0.remainder(dividingBy: 5.0)
-5.0.remainder(dividingBy: -5.0)

5.0.remainder(dividingBy: 6.0)
5.0.remainder(dividingBy: -6.0)
-5.0.remainder(dividingBy: 6.0)
-5.0.remainder(dividingBy: -6.0)

0.0.remainder(dividingBy: 5.0)
0.0.remainder(dividingBy: -5.0)

0.0.remainder(dividingBy: 1.0)
0.0.remainder(dividingBy: -1.0)

5.0.remainder(dividingBy: Double.nan)
-0

inf > -inf
inf < -inf
-inf > inf
-inf < inf
inf == -inf

inf - inf
inf + inf
inf * inf
inf / inf

10.0 / inf

inf / 10.0

let a = -5 / inf
a.isZero
a.isFinite
a.isNormal
a.isSubnormal
a == 0
a.magnitude
a.sign
a.description

let b = Double(-0)
let c = Double(-0.0)
c.isZero
c.isFinite
c.isNormal
c.isSubnormal
c == 0
c.magnitude
c.sign
c.description
c.isCanonical

0.0.isCanonical



// Converting

UInt(abs(-42344234))

// Power

pow(5.0, 2.0)
pow(5.0, -2.0)
pow(5.0, 2.0)





