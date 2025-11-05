public class TestAccess {
    public static void main(String[] args) {
        Parent p = new Parent();
        Child c = new Child();

        System.out.println("From non-subclass (TestAccess):");

        // ✅ Public field/method
        System.out.println(p.publicField);
        p.publicMethod();

        // ❌ Private field/method - NOT accessible outside class
        // System.out.println(p.privateField); // Compile error
        // p.privateMethod(); // Compile error

        // ❌ Protected field/method - NOT accessible in non-subclass from different package
        // (If TestAccess is in same package, protected is accessible)
        // System.out.println(p.protectedField); // Compile error if in different package
        // p.protectedMethod(); // Compile error if in different package

        // Accessing from Child
        c.childTestAccess();

        // Testing Parent's own private access internally
        p.testPrivateAccess();
    }
}
