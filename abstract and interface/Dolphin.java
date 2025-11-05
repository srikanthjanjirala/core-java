// Child class using both abstract class and interface
class Dolphin extends AnimalAbstract implements SwimmableInterface {
    // Implement abstract method from Animal
    @Override
    void sound() {
        System.out.println("Dolphin clicks and whistles");
    }

    // Implement abstract method from Swimmable
    @Override
    public void swim() {
        System.out.println("Dolphin swims gracefully");
    }

    // Optional: Override interface's default method
    @Override
    public void floatOnWater() {
        System.out.println("Dolphin floats playfully");
    }

    // Optional: Override abstract class's concrete method
    @Override
    void breathe() {
        System.out.println("Dolphin breathes through blowhole");
    }
}