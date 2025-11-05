interface SwimmableInterface {
    // Abstract method (must be implemented in child)
    void swim();

    // Concrete method in interface (Java 8+ default method)
    default void floatOnWater() {
        System.out.println("Floating on water (default from interface)");
    }
}