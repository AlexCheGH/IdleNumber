import XCTest
@testable import IdleNumber

private final class Environment {
    
    let one = IdleNumber(1, 0)
    let ten = IdleNumber(10, 0)

    let oneTho = IdleNumber(1, 1)
    let tenTho = IdleNumber(10, 1)
    
    let oneMil = IdleNumber(1, 2)
    let tenMil = IdleNumber(10, 2)

    let oneBil = IdleNumber(1, 3)
    let tenBil = IdleNumber(10, 3)

    let oneTril = IdleNumber(1, 4)
    let tenTril = IdleNumber(10, 4)
}

final class IdleNumberTests: XCTestCase {
 
    func testAddition() {
        let env = Environment()
        
        let elevenMil = env.oneMil + env.tenMil
        let elevenMilReverse = env.tenMil + env.oneMil

        let elevenBil = env.oneBil + env.tenBil
        let elevenBilReverse = env.tenBil + env.oneBil
        
        let elevenTril = env.oneTril + env.tenTril
        let elevenTrilReverse = env.tenTril + env.oneTril

        let magnitudeGreaterThanTwo0 = env.oneTril + env.oneMil
        let magnitudeGreaterThanTwo1 = env.tenMil + env.tenTril
        
        let oneMagnitudeAbove0 = env.oneMil + env.oneBil
        let oneMagnitudeAbove1 = env.oneBil + env.tenTril
        
        XCTAssertEqual(
            [
                elevenMil,
                elevenMilReverse,
                elevenBil,
                elevenBilReverse,
                elevenTril,
                elevenTrilReverse,
                magnitudeGreaterThanTwo0,
                magnitudeGreaterThanTwo1,
                oneMagnitudeAbove0,
                oneMagnitudeAbove1
            ],
            [
                IdleNumber(11, 2),
                IdleNumber(11, 2),
                IdleNumber(11, 3),
                IdleNumber(11, 3),
                IdleNumber(11, 4),
                IdleNumber(11, 4),
                IdleNumber(1, 4),
                IdleNumber(10, 4),
                IdleNumber(1.001, 3),
                IdleNumber(10.001, 4)
            ]
        )
    }

    func testSubtraction() {
        let env = Environment()

        let negativeNineMil = env.oneMil - env.tenMil
        let nineMil = env.tenMil - env.oneMil

        let negativeNineBil = env.oneBil - env.tenBil
        let nineBil = env.tenBil - env.oneBil
        
        let zero = env.tenTril - env.tenTril
        
        let nineHundredNintyNineMil = env.oneBil - env.oneMil
        let negativeNineHundredNintyNineMil = env.oneMil - env.oneBil

        XCTAssertEqual(
            [
                negativeNineMil,
                nineMil,
                negativeNineBil,
                nineBil,
                zero,
                nineHundredNintyNineMil,
                negativeNineHundredNintyNineMil
            ],
            [
                IdleNumber(-9, 2),
                IdleNumber(9, 2),
                IdleNumber(-9, 3),
                IdleNumber(9, 3),
                IdleNumber(0, 0),
                IdleNumber(999, 2),
                IdleNumber(-999, 2)
            ]
        )
    }

    func testMultiplication() {
        let env = Environment()
        
        let ten0 = env.one * env.ten
        let ten1 = env.one * 10

        let hundred0 = env.ten * env.ten
        let hundred1 = env.ten * 10
        
        let tenMil0 = env.ten * env.oneMil
        let tenMil1 = env.oneMil * 10
        
        let oneTril = env.oneMil * env.oneTho

        let zero = env.oneTril * 0

        let oneTho = env.oneMil * 0.001
        
        XCTAssertEqual(
            [
                ten0,
                ten1,
                hundred0,
                hundred1,
                tenMil0,
                tenMil1,
                oneTril,
                zero,
                oneTho
            ],
            [
                IdleNumber(10, 0),
                IdleNumber(10, 0),
                IdleNumber(100, 0),
                IdleNumber(100, 0),
                IdleNumber(10, 2),
                IdleNumber(10, 2),
                IdleNumber(1, 3),
                IdleNumber(0, 0),
                IdleNumber(1, 1)
            ]
        )
    }
    
    func testDivision() {
        let env = Environment()
        
        let ten0 = env.tenMil / env.oneMil
        let ten1 = env.oneTho / 100
        
        let tenBil = env.tenTril / env.oneTho

        let zero0 = env.oneTho / env.tenTril
        let zer1 = env.one / 100000
        
        
        XCTAssertEqual(
            [
                ten0,
                ten1,
                tenBil,
                zero0,
                zer1,
            ],
            [
                IdleNumber(10, 0),
                IdleNumber(10, 0),
                IdleNumber(10, 3),
                IdleNumber(0, 0),
                IdleNumber(0, 0)
            ]
        )
    }
}
