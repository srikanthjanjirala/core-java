abstract class AnimalAbstract {

    // Instance variables
    String name;
    double salary;

    // Abstract method (must be implemented in child)
    abstract void sound();

    // Concrete method in abstract class
    void breathe() {
        System.out.println("All animals breathe oxygen");
    }
}
