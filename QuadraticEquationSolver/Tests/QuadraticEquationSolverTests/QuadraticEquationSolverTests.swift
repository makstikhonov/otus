import XCTest
@testable import QuadraticEquationSolver

final class QuadraticEquationSolverTests: XCTestCase {
    
    // Написать тест, который проверяет, что для уравнения x^2+1 = 0 корней нет (возвращается пустой массив)
    func testNoRoots() throws {
        let roots = try QuadraticEquationSolver.solve(1.0, 0.0, 1.0)
        XCTAssertEqual(roots.count, 0)
    }
    
    // Написать тест, который проверяет, что для уравнения x^2-1 = 0 есть два корня кратности 1 (x1=1, x2=-1)
    func testTwoDistinctRoots() throws {
        let roots = try QuadraticEquationSolver.solve(1.0, 0.0, -1.0)
        XCTAssertEqual(roots.count, 2)
        XCTAssertEqual(roots[0], 1.0)
        XCTAssertEqual(roots[1], -1.0)
    }
    
    // Написать тест, который проверяет, что для уравнения x^2+2x+1 = 0 есть один корень кратности 2 (x1= x2 = -1).
    func testOneRootWithMultiplicityTwo() throws {
        let roots = try QuadraticEquationSolver.solve(1.0, 2.0, 1.0)
        XCTAssertEqual(roots.count, 1)
        XCTAssertEqual(roots[0], -1.0)
    }
    
    // Написать тест, который проверяет, что коэффициент a не может быть равен 0. В этом случае solve выбрасывает исключение.
    func testNonZeroCoefficientA() throws {
        XCTAssertThrowsError(try QuadraticEquationSolver.solve(0.0, 1.0, 1.0)) { error in
            XCTAssertEqual(error as? QuadraticEquationError, QuadraticEquationError.invalidCoefficient)
        }
    }
    
    // Посмотреть какие еще значения могут принимать числа типа double, кроме числовых и написать тест с их использованием на все коэффициенты. solve должен выбрасывать исключение.
    func testInvalidCoefficients() throws {
        let invalidCoefficients: [Double] = [Double.infinity, -Double.infinity, Double.nan]
        
        for coefficient in invalidCoefficients {
            XCTAssertThrowsError(try QuadraticEquationSolver.solve(coefficient, 1.0, 1.0)) { error in
                XCTAssertEqual(error as? QuadraticEquationError, QuadraticEquationError.invalidCoefficient)
            }
        }
        
        XCTAssertThrowsError(try QuadraticEquationSolver.solve(0.0, 1.0, 1.0)) { error in
            XCTAssertEqual(error as? QuadraticEquationError, QuadraticEquationError.invalidCoefficient)
        }
        
        for coefficient in invalidCoefficients {
            XCTAssertThrowsError(try QuadraticEquationSolver.solve(1.0, 1.0, coefficient)) { error in
                XCTAssertEqual(error as? QuadraticEquationError, QuadraticEquationError.invalidCoefficient)
            }
        }
        
        for coefficient in invalidCoefficients {
            XCTAssertThrowsError(try QuadraticEquationSolver.solve(1.0, coefficient, 1.0)) { error in
                XCTAssertEqual(error as? QuadraticEquationError, QuadraticEquationError.invalidCoefficient)
            }
        }
        
    }
}
