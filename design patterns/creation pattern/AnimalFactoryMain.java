class Animal {
    public void veg() {
        System.out.println("Animal eats grass");
    }
}

class Dog extends Animal {
    public void nonVeg() {
        System.out.println("Dog eats meat");
    }
}

class Cat extends Animal {
    public void mix() {
        System.out.println("anything");
    }
}

class AnimalFactory {
    public static Animal getAnimal(String animalType) {
        if (animalType == null) {
            return null;
        }
        // Use .equals() to compare string values instead of '=='
        if (animalType.equalsIgnoreCase("DOG")) {
            return new Dog();
        } else if (animalType.equalsIgnoreCase("CAT")) {
            return new Cat();
        }
        return null;
    }
}

// Create a new Main class with the main method to run the program
public class AnimalFactoryMain {
    public static void main(String[] args) {
        // Get a Dog object
        Animal animal1 = AnimalFactory.getAnimal("DOG");
        if (animal1 != null) {
            animal1.veg();  // This will print: Animal eats grass
            if (animal1 instanceof Dog) {
                ((Dog) animal1).nonVeg();  // This will print: Dog eats meat
            }
        }

        // Get a Cat object
        Animal animal2 = AnimalFactory.getAnimal("CAT");
        if (animal2 != null) {
            animal2.veg();  // This will print: Animal eats grass
            if (animal2 instanceof Cat) {
                ((Cat) animal2).mix();  // This will print: anything
            }
        }

        // Try with an unknown type
        Animal animal3 = AnimalFactory.getAnimal("BIRD");
        if (animal3 == null) {
            System.out.println("Unknown animal type");
        }
    }
}
