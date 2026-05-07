package markerInterface;

public class Main {
    
    public static void main(String[] args) {
        Bird bird = new Bird();
        Dog dog = new Dog();

        checkFly(bird);  // Output: Bird can fly!
        checkFly(dog);   // Output: This cannot fly.
    }

    static void checkFly(Object obj) {
        if (obj instanceof Flyable) {
            System.out.println("This object can fly!");
        } else {
            System.out.println("This cannot fly.");
        }
    }
}

// A marker interface is an interface that has no methods or fields — it is just an empty interface. It is used to indicate that a class belongs to a particular category or has a certain property. In this example, the Flyable interface is a marker interface that indicates that a class can fly. The Bird class implements the Flyable interface, while the Dog class does not. The checkFly method uses the instanceof operator to check if an object is an instance of the Flyable interface and prints the appropriate message.