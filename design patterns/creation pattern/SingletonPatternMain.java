public class Singleton {
    // Step 1: Create a private static variable of the same class
    private static Singleton instance;

    // Step 2: Make the constructor private so that this class cannot be instantiated from outside
    private Singleton() {
        System.out.println("Singleton instance created.");
    }

    // Step 3: Provide a public static method that returns the instance
    public static Singleton getInstance() {
        if (instance == null) {
            instance = new Singleton(); // lazy initialization
        }
        return instance;
    }

    public void showMessage() {
        System.out.println("Hello from Singleton!");
    }
}


public class SingletonPatternMain {
    public static void main(String[] args) {
        Singleton obj1 = Singleton.getInstance();
        Singleton obj2 = Singleton.getInstance();

        obj1.showMessage();

        // Check if both instances are the same
        System.out.println("Are both instances the same? " + (obj1 == obj2));  // true
    }
}
