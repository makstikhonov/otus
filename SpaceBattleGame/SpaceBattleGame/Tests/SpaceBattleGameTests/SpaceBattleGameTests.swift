import XCTest
@testable import SpaceBattleGame

final class SpaceBattleGameTests: XCTestCase {
    
    // Для объекта, находящегося в точке (12, 5) и движущегося со скоростью (-7, 3) движение меняет положение объекта на (5, 8)
    func testMovablePositionAfterMove() throws {
        let properties: [String: Any] = [
            MovablePropertyKey.position.rawValue : Vector2D(x: 12.0, y: 5.0),
            MovablePropertyKey.velocity.rawValue : Vector2D(x: 5.0, y: 8.0)
        ]
        let testSpaceShip = TestSpaceShip(properties: properties)
        let movableAdapter = MovableAdapter(o: testSpaceShip)
        let startPosition = try movableAdapter.getPosition()
        let move = Move(movableAdapter)
        try move.execute()
        
        let delta = try movableAdapter.getPosition() - startPosition
        XCTAssertEqual(delta, Vector2D(x: 5.0, y: 8.0))
    }
    
    // Попытка сдвинуть объект, у которого невозможно прочитать положение в пространстве, приводит к ошибке
    func testMovablePositionKey() throws {
        let properties: [String: Any] = [
            "Pos" : Vector2D(x: 12.0, y: 5.0),
            MovablePropertyKey.velocity.rawValue : Vector2D(x: 5.0, y: 8.0)
        ]
        let testSpaceShip = TestSpaceShip(properties: properties)
        let movableAdapter = MovableAdapter(o: testSpaceShip)
        XCTAssertThrowsError(try movableAdapter.getPosition()) { error in
            XCTAssertEqual(
                error as? SpaceBattleGameError,
                SpaceBattleGameError.getProperty(MovablePropertyKey.position.rawValue)
            )
        }
    }
    
    // Попытка сдвинуть объект, у которого невозможно прочитать значение мгновенной скорости, приводит к ошибке
    func testMovableVelocityKey() throws {
        let properties: [String: Any] = [
            MovablePropertyKey.position.rawValue : Vector2D(x: 12.0, y: 5.0),
            "Vel" : Vector2D(x: 5.0, y: 8.0)
        ]
        let testSpaceShip = TestSpaceShip(properties: properties)
        let movableAdapter = MovableAdapter(o: testSpaceShip)
        XCTAssertThrowsError(try movableAdapter.getVelocity()) { error in
            XCTAssertEqual(
                error as? SpaceBattleGameError,
                SpaceBattleGameError.getProperty(MovablePropertyKey.velocity.rawValue)
            )
        }
    }
    
    // Попытка сдвинуть объект, у которого невозможно изменить положение в пространстве, приводит к ошибке
    func testMovableSettingPosition() throws {
        let properties: [String: Any] = [
            MovablePropertyKey.velocity.rawValue : Vector2D(x: 5.0, y: 8.0)
        ]
        let testSpaceShip = TestSpaceShip(properties: properties)
        let movableAdapter = MovableAdapter(o: testSpaceShip)
        XCTAssertThrowsError(try movableAdapter.setPosition(Vector2D(x: 1.0, y: 2.0))) { error in
            XCTAssertEqual(
                error as? SpaceBattleGameError,
                SpaceBattleGameError.setProperty(MovablePropertyKey.position.rawValue)
            )
        }
    }
    
    // Для объекта, имеющего направление (1) и уловую скорость (1) поворот меняет положение объекта на (1)
    func testRotablePositionAfertRotate() throws {
        let properties: [String: Any] = [
            RotablePropertyKey.angularVelocity.rawValue : 1,
            RotablePropertyKey.direction.rawValue : Direction(number: 1)
        ]
        let testSpaceShip = TestSpaceShip(properties: properties)
        let rotableAdapter = RotableAdapter(o: testSpaceShip)
        let startDirection = try rotableAdapter.getDirection()
        let rotate = Rotate(rotableAdapter)
        try rotate.execute()
        let delta = try rotableAdapter.getDirection() - startDirection

        XCTAssertEqual(delta, Direction(number: 1))
    }
    
    // Попытка повернуть объект, у которого невозможно прочитать положение в пространстве, приводит к ошибке
    func testRotableDirectionKey() throws {
        let properties: [String: Any] = [
            RotablePropertyKey.angularVelocity.rawValue : 1,
            "Dir" : Direction(number: 1)
        ]
        let testSpaceShip = TestSpaceShip(properties: properties)
        let rotableAdapter = RotableAdapter(o: testSpaceShip)
        XCTAssertThrowsError(try rotableAdapter.getDirection()) { error in
            XCTAssertEqual(
                error as? SpaceBattleGameError,
                SpaceBattleGameError.getProperty(RotablePropertyKey.direction.rawValue)
            )
        }
    }
    
    // Попытка повернуть объект, у которого невозможно прочитать значение угловой скорости, приводит к ошибке
    func testRotableAngularVelocityKey() throws {
        let properties: [String: Any] = [
            "AV" : 1,
            RotablePropertyKey.direction.rawValue : Direction(number: 1)
        ]
        let testSpaceShip = TestSpaceShip(properties: properties)
        let rotableAdapter = RotableAdapter(o: testSpaceShip)
        XCTAssertThrowsError(try rotableAdapter.getAngularVelocity()) { error in
            XCTAssertEqual(
                error as? SpaceBattleGameError,
                SpaceBattleGameError.getProperty(RotablePropertyKey.angularVelocity.rawValue)
            )
        }
    }
    
    // Попытка сдвинуть объект, у которого невозможно изменить положение в пространстве, приводит к ошибке
    func testRotableSettingDirection() throws {
        let properties: [String: Any] = [
            RotablePropertyKey.angularVelocity.rawValue : 1
        ]
        let testSpaceShip = TestSpaceShip(properties: properties)
        let rotableAdapter = RotableAdapter(o: testSpaceShip)
        XCTAssertThrowsError(try rotableAdapter.setDirection(Direction(number: 1))) { error in
            XCTAssertEqual(
                error as? SpaceBattleGameError,
                SpaceBattleGameError.setProperty(RotablePropertyKey.direction.rawValue)
            )
        }
    }
    
}
