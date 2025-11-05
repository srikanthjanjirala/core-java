public class Parent {   // ✅ removed "public"
    // Fields
    public String publicField = "I am PUBLIC";
    private String privateField = "I am PRIVATE";
    protected String protectedField = "I am PROTECTED";

    // Methods
    public void publicMethod() {
        System.out.println("Public method: " + publicField);
    }

    private void privateMethod() {
        System.out.println("Private method: " + privateField);
    }

    protected void protectedMethod() {
        System.out.println("Protected method: " + protectedField);
    }

    // Method to test private access from inside the class
    public void testPrivateAccess() {
        System.out.println("Accessing private method from inside Parent:");
        privateMethod(); // ✅ Allowed (same class)
    }
}