class Animal {
    public Animal getAnimal() {
        System.out.println("Animal returned");
        return new Animal();
    }
}

class Dog extends Animal {
    @Override
    public Dog getAnimal() {  // Covariant return type: Dog is a subclass of Animalpa
        System.out.println("Dog returned");
        return new Dog();
    }
}
