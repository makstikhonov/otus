import XCTest
import Foundation

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
        let move = MoveCommand(movableAdapter)
        try move.execute()
        
        let delta = try movableAdapter.getPosition() - startPosition
        XCTAssertEqual(delta, Vector2D(x: 5.0, y: 8.0))
    }
    
    // Попытка сдвинуть объект, у которого невозможно прочитать положение в пространстве, приводит к ошибке
    func testMovablePositionKey() throws {
        let properties: [String: Any] = [
            "Pos": Vector2D(x: 12.0, y: 5.0),
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
            "Vel": Vector2D(x: 5.0, y: 8.0)
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
        let rotate = RotateCommand(rotableAdapter)
        try rotate.execute()
        let delta = try rotableAdapter.getDirection() - startDirection
        
        XCTAssertEqual(delta, Direction(number: 1))
    }
    
    // Попытка повернуть объект, у которого невозможно прочитать положение в пространстве, приводит к ошибке
    func testRotableDirectionKey() throws {
        let properties: [String: Any] = [
            RotablePropertyKey.angularVelocity.rawValue : 1,
            "Dir": Direction(number: 1)
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
            "AV": 1,
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
    
    // Тест для проверки того, что объект, имеющий уровень топлива, может сжечь топливо
    func testFuelBurnableLevelAfterBurn() throws {
        let properties: [String: Float] = [
            "FuelConsumption": 3.0,
            "FuelLevel": 10.0
        ]
        let testSpaceShip = TestSpaceShip(properties: properties)
        let fuelBurnableAdapter = FuelBurnableAdapter(o: testSpaceShip)
        let startFuelLevel = try fuelBurnableAdapter.getFuelLevel()
        let burn = BurnFuelCommand(fuelBurnableAdapter)
        try burn.execute()
        let fuelLevelAfterBurn = try fuelBurnableAdapter.getFuelLevel()
        let delta = startFuelLevel - fuelLevelAfterBurn
        XCTAssertEqual(delta, 3.0)
    }
    
    // Попытка сжечь топливо у объекта, у которого невозможно прочитать скорость сжигания топлива, приводит к ошибке
    func testFuelBurnableFuelConsumptionKey() throws {
        let properties: [String: Float] = [
            "FuelLevel": 10.0,
            "FuelCons": 3.0
        ]
        let testSpaceShip = TestSpaceShip(properties: properties)
        let fuelBurnableAdapter = FuelBurnableAdapter(o: testSpaceShip)
        XCTAssertThrowsError(try fuelBurnableAdapter.getConsumption()) { error in
            XCTAssertEqual(
                error as? SpaceBattleGameError,
                SpaceBattleGameError.getProperty("FuelConsumption")
            )
        }
    }
    
    // Попытка сжечь топливо у объекта, у которого невозможно прочитать уровень топлива, приводит к ошибке
    func testFuelBurnableFuelLevelKey() throws {
        let properties: [String: Float] = [
            "FuelConsumption": 3.0,
            "FuelLvl": 10.0
        ]
        let testSpaceShip = TestSpaceShip(properties: properties)
        let fuelBurnableAdapter = FuelBurnableAdapter(o: testSpaceShip)
        XCTAssertThrowsError(try fuelBurnableAdapter.getFuelLevel()) { error in
            XCTAssertEqual(
                error as? SpaceBattleGameError,
                SpaceBattleGameError.getProperty("FuelLevel")
            )
        }
    }
    
    // Попытка установить уровень топлива у объекта, у которого невозможно прочитать уровень топлива, приводит к ошибке
    func testFuelBurnableSettingFuelLevel() throws {
        let properties: [String: Float] = [
            "FuelConsumption": 3.0
        ]
        let testSpaceShip = TestSpaceShip(properties: properties)
        let fuelBurnableAdapter = FuelBurnableAdapter(o: testSpaceShip)
        XCTAssertThrowsError(try fuelBurnableAdapter.setFuelLevel(10.0)) { error in
            XCTAssertEqual(
                error as? SpaceBattleGameError,
                SpaceBattleGameError.setProperty("FuelLevel")
            )
        }
    }
    
    //Тест для проверки того, что объект, имеющий уровень топлива, может вернуть уровень топлива
    func testFuelCheckableFuelLevel() throws {
        let properties: [String: Float] = [
            "FuelLevel": 10.0
        ]
        let testSpaceShip = TestSpaceShip(properties: properties)
        let fuelCheckableAdapter = FuelCheckableAdapter(o: testSpaceShip)
        let fuelLevel = try fuelCheckableAdapter.getFuelLevel()
        XCTAssertEqual(fuelLevel, 10.0)
    }
    
    //Попытка вернуть уровень топлива у объекта, у которого невозможно прочитать уровень топлива, приводит к ошибке
    func testFuelCheckableFuelLevelKey() throws {
        let properties: [String: Float] = [
            "FuelLvl": 10.0
        ]
        let testSpaceShip = TestSpaceShip(properties: properties)
        let fuelCheckableAdapter = FuelCheckableAdapter(o: testSpaceShip)
        XCTAssertThrowsError(try fuelCheckableAdapter.getFuelLevel()) { error in
            XCTAssertEqual(
                error as? SpaceBattleGameError,
                SpaceBattleGameError.getProperty("FuelLevel")
            )
        }
    }
    
    //Тест для проверки уровня топлива ниже порогового значения
    func testFuelCheckableLowFuelLevel() throws {
        let properties: [String: Float] = [
            "FuelLevel": 2.0,
            "FuelConsumption": 3.0
        ]
        let testSpaceShip = TestSpaceShip(properties: properties)
        let fuelCheckableAdapter = FuelCheckableAdapter(o: testSpaceShip)
        let checkFuel = CheckFuelCommand(fuelCheckableAdapter)
        XCTAssertThrowsError(try checkFuel.execute()) { error in
            XCTAssertEqual(
                error as? CheckFuelError,
                CheckFuelError.noFuelToBurn()
            )
        }
    }
    
    func testMacroCommand() throws {
        let properties: [String: Float] = [
            "FuelConsumption": 12.0,
            "FuelLevel": 10.0
        ]
        let testSpaceShip = TestSpaceShip(properties: properties)
        let fuelBurnableAdapter = FuelBurnableAdapter(o: testSpaceShip)
        let fuelCheckableAdapter = FuelCheckableAdapter(o: testSpaceShip)
        
        let burn = BurnFuelCommand(fuelBurnableAdapter)
        let checkFuel = CheckFuelCommand(fuelCheckableAdapter)
        let repeatableCommand = MacroCommand(commands: [checkFuel, burn])
        
        let queue = Queue()
        let cmd = InjectableCommand(cmd: repeatableCommand)
        let repeater: ICommand = RepeatCommand(queue: queue, command: cmd)
        let macroCommand: ICommand = MacroCommand(commands: [repeatableCommand, repeater])
        cmd.inject(cmd: macroCommand)
        
        queue.put(cmd)
        while !queue.isEmpty {
            XCTAssertThrowsError(try queue.take().execute()) { error in
                cmd.inject(cmd: EmptyCommand())
                XCTAssertEqual(error as? CheckFuelError, CheckFuelError.noFuelToBurn())
            }
        }
    }
    
    func testMoveWithFuelBurningMacroCommand() {
        let properties: [String: Any] = [
            "Position": Vector2D(x: 12.0, y: 5.0),
            "Velocity": Vector2D(x: 5.0, y: 8.0),
            "FuelConsumption": 3.0 as Float,
            "FuelLevel": 10.0 as Float
        ]
        let testSpaceShip = TestSpaceShip(properties: properties)
        
        let fuelBurnableAdapter = FuelBurnableAdapter(o: testSpaceShip)
        let fuelCheckableAdapter = FuelCheckableAdapter(o: testSpaceShip)
        let moveableAdapter = MovableAdapter(o: testSpaceShip)
        
        let burn = BurnFuelCommand(fuelBurnableAdapter)
        let checkFuel = CheckFuelCommand(fuelCheckableAdapter)
        let move = MoveCommand(moveableAdapter)
        let repeatableCommand = MacroCommand(commands: [checkFuel, burn, move])
        
        let queue = Queue()
        let cmd = InjectableCommand(cmd: repeatableCommand)
        let repeater: ICommand = RepeatCommand(queue: queue, command: cmd)
        let macroCommand: ICommand = MacroCommand(commands: [repeatableCommand, repeater])
        cmd.inject(cmd: macroCommand)
        
        queue.put(cmd)
        
        var fuel: Float = 0.0
        var position: Vector2D = Vector2D(x: 0.0, y: 0.0)
        while !queue.isEmpty {
            do {
                fuel = try fuelCheckableAdapter.getFuelLevel()
                position = try moveableAdapter.getPosition()
                try queue.take().execute()
            } catch {
                cmd.inject(cmd: EmptyCommand())
                XCTAssertEqual(error as? CheckFuelError, CheckFuelError.noFuelToBurn())
                XCTAssertEqual(position, Vector2D(x: 27.0, y: 29.0))
                XCTAssertEqual(fuel, 1.0)
            }
        }
    }
    
    func testMoveWithRotationMacroCommand() {
        let properties: [String: Any] = [
            "Position": Vector2D(x: 12.0, y: 5.0),
            "Velocity": Vector2D(x: 5.0, y: 8.0),
            "FuelConsumption": 3.0 as Float,
            "FuelLevel": 10.0 as Float,
            "Direction": Direction(number: 0),
            "AngularVelocity": 1
        ]
        let testSpaceShip = TestSpaceShip(properties: properties)
        
        let fuelBurnableAdapter = FuelBurnableAdapter(o: testSpaceShip)
        let fuelCheckableAdapter = FuelCheckableAdapter(o: testSpaceShip)
        let moveableAdapter = MovableAdapter(o: testSpaceShip)
        let rotableAdapter = RotableAdapter(o: testSpaceShip)
        let changeVelocityAdapter = ChangeVelocityAdapter(o: testSpaceShip)
        
        let burn = BurnFuelCommand(fuelBurnableAdapter)
        let checkFuel = CheckFuelCommand(fuelCheckableAdapter)
        let move = MoveCommand(moveableAdapter)
        let rotate = RotateCommand(rotableAdapter)
        let changeVelocity = ChangeVelocityCommand(changeVelocityAdapter)
        
        let repeatableCommand = MacroCommand(commands: [checkFuel, burn, move, rotate, changeVelocity])
        
        let queue = Queue()
        let cmd = InjectableCommand(cmd: repeatableCommand)
        let repeater: ICommand = RepeatCommand(queue: queue, command: cmd)
        let macroCommand: ICommand = MacroCommand(commands: [repeatableCommand, repeater])
        cmd.inject(cmd: macroCommand)
        
        queue.put(cmd)
        
        var fuel: Float = 0.0
        var position: Vector2D = Vector2D(x: 0.0, y: 0.0)
        var direction: Direction = Direction(number: 0)
        
        while !queue.isEmpty {
            do {
                fuel = try fuelCheckableAdapter.getFuelLevel()
                position = try moveableAdapter.getPosition()
                direction = try rotableAdapter.getDirection()
                
                try queue.take().execute()
            } catch {
                cmd.inject(cmd: EmptyCommand())
                XCTAssertEqual(error as? CheckFuelError, CheckFuelError.noFuelToBurn())
                XCTAssertEqual(position, Vector2D(x: 27.0, y: 29.0))
                XCTAssertEqual(direction, Direction(number: 3))
                XCTAssertEqual(fuel, 1.0)
            }
        }
    }
    
    // Exception handler tests
    
    private func putTestCommandInTheQueue() -> Queue {
        let properties: [String: Float] = [
            "FuelConsumption": 12.0,
            "FuelLevel": 10.0
        ]
        let testSpaceShip = TestSpaceShip(properties: properties)
        let fuelCheckableAdapter = FuelCheckableAdapter(o: testSpaceShip)
        let checkFuel = CheckFuelCommand(fuelCheckableAdapter)
        let queue = Queue()
        queue.put(checkFuel)
        return queue
    }
    
    func testExceptionHandlerLogCommand() {
        let queue = putTestCommandInTheQueue()
        let store: [String: [String: (ICommand, Error) -> ICommand]] = [
            // Реализовать Команду, которая записывает информацию о выброшенном исключении в лог.
            "\(CheckFuelCommand.self)": [
                "\(CheckFuelError.self).\(CheckFuelError.noFuelToBurn().self)": { (cmd: ICommand, e: Error) -> ICommand in
                    let logger = Logger()
                    let logCommand = ExceptionLogCommand(loggable: logger, exception: e)
                    return logCommand
                }
            ]
        ]
        
        let exceptionHandler = ExceptionHandler()
        exceptionHandler.store = store
        
        while !queue.isEmpty {
            let command = queue.take()
            do {
                try command.execute()
            } catch {
                let logCommand = exceptionHandler.handle(e: error, cmd: command)
                XCTAssertEqual(error as? CheckFuelError, CheckFuelError.noFuelToBurn())
                XCTAssertEqual(logCommand is ExceptionLogCommand, true)
                try? logCommand.execute()
            }
        }
    }
    
    func testExceptionHandlerLogCommandInTheQueue() {
        let queue = putTestCommandInTheQueue()
        let store: [String: [String: (ICommand, Error) -> ICommand]] = [
            // Реализовать обработчик исключения, который ставит Команду, пишущую в лог в очередь Команд.
            "\(CheckFuelCommand.self)": [
                "\(CheckFuelError.self).\(CheckFuelError.noFuelToBurn().self)": { (cmd: ICommand, e: Error) -> ICommand in
                    let logger = Logger()
                    let logCommand = ExceptionLogCommand(loggable: logger, exception: e)
                    let repeater = RepeatCommand(queue: queue, command: logCommand)
                    return repeater
                }
            ]
        ]
        
        let exceptionHandler = ExceptionHandler()
        exceptionHandler.store = store
        
        while !queue.isEmpty {
            let command = queue.take()
            do {
                try command.execute()
            } catch {
                try? exceptionHandler.handle(e: error, cmd: command).execute()
                XCTAssertEqual(error as? CheckFuelError, CheckFuelError.noFuelToBurn())
                let nextCommand = queue.take()
                XCTAssertEqual(nextCommand is ExceptionLogCommand, true)
            }
        }
    }
    
    func testExceptionHandlerRepeatExceptionCommand() {
        let queue = putTestCommandInTheQueue()
        let store: [String: [String: (ICommand, Error) -> ICommand]] = [
            //Реализовать Команду, которая повторяет Команду, выбросившую исключение.
            "\(CheckFuelCommand.self)": [
                "\(CheckFuelError.self).\(CheckFuelError.noFuelToBurn().self)": { (cmd: ICommand, e: Error) -> ICommand in
                    return cmd
                }
            ],
        ]
        
        let exceptionHandler = ExceptionHandler()
        exceptionHandler.store = store
        
        while !queue.isEmpty {
            let command = queue.take()
            do {
                try command.execute()
            } catch {
                let exceptionCommand = exceptionHandler.handle(e: error, cmd: command)
                XCTAssertEqual(error as? CheckFuelError, CheckFuelError.noFuelToBurn())
                XCTAssertEqual(exceptionCommand is CheckFuelCommand, true)
                try? exceptionCommand.execute()
            }
        }
    }
    
    func testExceptionHandlerPutRepeatExceptionCommandInTheQueue() {
        let queue = putTestCommandInTheQueue()
        let store: [String: [String: (ICommand, Error) -> ICommand]] = [
            // Реализовать обработчик исключения, который ставит в очередь Команду - повторитель команды, выбросившей исключение.
            "\(CheckFuelCommand.self)": [
                "\(CheckFuelError.self).\(CheckFuelError.noFuelToBurn().self)": { (cmd: ICommand, e: Error) -> ICommand in
                    let repeater = RepeatCommand(queue: queue, command: cmd)
                    return repeater
                }
            ],
        ]
        
        let exceptionHandler = ExceptionHandler()
        exceptionHandler.store = store
        
        while !queue.isEmpty {
            let command = queue.take()
            do {
                try command.execute()
            } catch {
                try? exceptionHandler.handle(e: error, cmd: command).execute()
                XCTAssertEqual(error as? CheckFuelError, CheckFuelError.noFuelToBurn())
                let nextCommand = queue.take()
                XCTAssertEqual(nextCommand is CheckFuelCommand, true)
            }
        }
    }
    
    func testExceptionHandlerRepeatedException() {
        let queue = putTestCommandInTheQueue()
        let store: [String: [String: (ICommand, Error) -> ICommand]] = [
            "\(CheckFuelCommand.self)": [
                "\(CheckFuelError.self).\(CheckFuelError.noFuelToBurn(1).self)": { (cmd: ICommand, e: Error) -> ICommand in
                    return cmd
                },
                "\(CheckFuelError.self).\(CheckFuelError.noFuelToBurn(2).self)": { (cmd: ICommand, e: Error) -> ICommand in
                    let logger = Logger()
                    let logCommand = ExceptionLogCommand(loggable: logger, exception: e)
                    return logCommand
                }
            ]
        ]
        
        let exceptionHandler = ExceptionHandler()
        exceptionHandler.store = store
        
        while !queue.isEmpty {
            let command = queue.take()
            do {
                try command.execute()
            } catch {
                let returnedCommand = exceptionHandler.handle(e: error, cmd: command)
                if case let CheckFuelError.noFuelToBurn(code) = error, code == 1 {
                    XCTAssertEqual(error as? CheckFuelError, CheckFuelError.noFuelToBurn(1))
                    XCTAssertEqual(returnedCommand is CheckFuelCommand, true)
                } else if case let CheckFuelError.noFuelToBurn(code) = error, code == 2 {
                    XCTAssertEqual(error as? CheckFuelError, CheckFuelError.noFuelToBurn(2))
                    XCTAssertEqual(returnedCommand is ExceptionLogCommand, true)
                }
            }
        }
    }
}
