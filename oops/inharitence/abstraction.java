abstract class A {
    abstract void java(); // abstract method

    void python() {       // concrete method
        System.out.println("Python");
    }
}

class B extends A {
    @Override
    void java() {
        System.out.println("Java");
    }
}

public class Main {
    public static void main(String[] args) {
        B b = new B();
        b.python();  // prints "Python"
        b.java();    // prints "Java"
    }
}
