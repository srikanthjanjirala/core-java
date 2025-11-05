class Person implements Cloneable {
    String name;

    Person(String name) {
        this.name = name;
    }

    public Person clone() {
        try {
            return (Person) super.clone();  // shallow copy
        } catch (CloneNotSupportedException e) {
            return null;
        }
    }

    public void display() {
        System.out.println("Person name: " + name);
    }
}


public class PrototypePatternMain {
    public static void main(String[] args) {
        Person original = new Person("Alice");
        Person copy = original.clone();

        original.display();  // Person name: Alice
        copy.display();      // Person name: Alice

        // Changing copy's name
        copy.name = "Bob";
        original.display();  // Person name: Alice
        copy.display();      // Person name: Bob
    }
}

// Response: 
// Person name: Alice
// Person name: Alice
// Person name: Alice
// Person name: Bob