import Foundation

public struct QuadraticEquationSolver {
    public static func solve(_ a: Double, _ b: Double, _ c: Double, epsilon: Double = 1e-10) throws -> [Double] {
        guard !a.isZero, !a.isInfinite, !b.isInfinite, !c.isInfinite, !a.isNaN, !b.isNaN, !c.isNaN else {
                throw QuadraticEquationError.invalidCoefficient
            }
        
        if a <= epsilon {
            throw QuadraticEquationError.invalidCoefficient
        }

        let discriminant: Double = b * b - 4 * a * c

        if discriminant < -epsilon {
            return []
        }
        if abs(discriminant) <= epsilon {
            return [-b / (2 * a)]
        }
        if discriminant > epsilon {
            let sqrtDiscriminant = sqrt(discriminant)
            let root1 = (-b + sqrtDiscriminant) / (2 * a)
            let root2 = (-b - sqrtDiscriminant) / (2 * a)
            return [root1, root2]
        }
        return []
    }
}

enum QuadraticEquationError: Error {
    case invalidCoefficient
}
