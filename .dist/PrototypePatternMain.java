class Animal implements Cloneable {
    String name;

    public Animal(String name) {
        this.name = name;
    }

    public void display() {
        System.out.println("Animal: " + name);
    }

    // Override clone method
    public Animal clone() {
        try {
            return (Animal) super.clone();
        } catch (CloneNotSupportedException e) {
            return null;
        }
    }
}

public class PrototypePatternMain {
    public static void main(String[] args) {
        Animal original = new Animal("Dog");
        Animal copy = original.clone();

        original.display();  // Animal: Dog
        copy.display();      // Animal: Dog

        // Modify the copy
        copy.name = "Cat";

        original.display();  // Animal: Dog
        copy.display();      // Animal: Cat
    }
}
