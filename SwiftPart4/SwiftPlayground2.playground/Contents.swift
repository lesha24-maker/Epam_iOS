import Foundation

protocol Shape {
    func area() -> Double
    func perimeter() -> Double
}

class Circle: Shape {
    let radius: Double

    init(radius: Double) {
        self.radius = radius
    }

    func area() -> Double {
        return Double.pi * radius * radius
    }

    func perimeter() -> Double {
        return 2 * Double.pi * radius
    }
}

class Rectangle: Shape {
    let width: Double
    let height: Double

    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }

    func area() -> Double {
        return width * height
    }

    func perimeter() -> Double {
        return 2 * (width + height)
    }
}

func generateShape() -> some Shape {
    return Circle(radius: 5.0)
}

func calculateShapeDetails(shape: some Shape) -> (area: Double, perimeter: Double) {
    let area = shape.area()
    let perimeter = shape.perimeter()
    return (area: area, perimeter: perimeter)
}

let myShape: some Shape = generateShape()
let details = calculateShapeDetails(shape: myShape)

print("Generated Shape (Circle with radius 5):")
print("Area: \(details.area)")
print("Perimeter: \(details.perimeter)\n")

let myRectangle = Rectangle(width: 4.0, height: 7.0)
let rectangleDetails = calculateShapeDetails(shape: myRectangle)

print("Rectangle (width: 4.0, height: 7.0):")
print("Area: \(rectangleDetails.area)")
print("Perimeter: \(rectangleDetails.perimeter)")

func printShapeDetailsDirectly(shape: some Shape) {
    print("\n--- Direct Print Details ---")
    print("Shape Type: \(type(of: shape))")
    print("Area: \(shape.area())")
    print("Perimeter: \(shape.perimeter())")
    print("--------------------------")
}

printShapeDetailsDirectly(shape: myShape)
printShapeDetailsDirectly(shape: myRectangle)
