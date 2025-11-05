public class Test {
    public static void main(String[] args) {
        Dolphin dolphin = new Dolphin();

        // Abstract class methods
        dolphin.sound();   // From abstract method implementation
        dolphin.breathe(); // Overridden concrete method

        // Interface methods
        dolphin.swim();         // From abstract method implementation
        dolphin.floatOnWater(); // Overridden default method
    }
}