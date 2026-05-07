package constructor;

public class User {
    int id;
    String name;

    // ✅ No-args constructor
    public User() {
        System.out.println("No-args constructor called");
    }

    // ✅ All-args constructor
    public User(int id, String name) {
        this.id = id;
        this.name = name;
        System.out.println("All-args constructor called");
    }
}
