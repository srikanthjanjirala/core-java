package constructor;

public class Main {
    public static void main(String[] args) {

        // Using no-args constructor
        User u1 = new User();
        u1.id = 1;
        u1.name = "John";

        System.out.println(u1.id + " " + u1.name);

        // Using all-args constructor
        User u2 = new User(2, "Alice");

        System.out.println(u2.id + " " + u2.name);
    }    
}
