public class Child extends Parent {

    public void childTestAccess() {
        System.out.println("From Child class:");

        // ✅ Public field/method - accessible everywhere
        System.out.println(publicField);
        publicMethod();

        // ❌ Private field/method - NOT accessible in subclass
        // System.out.println(privateField); // Compile error
        // privateMethod(); // Compile error

        // ✅ Protected field/method - accessible in subclass
        System.out.println(protectedField);
        protectedMethod();
    }
    // public String iamchild = "I am child";

    // public void childMethod() {
    //     System.out.println("Child method: " + iamchild);
    //     publicMethod();
    //     protectedMethod();
    // }

    // public static void main(String[] args) {
    //     Child c = new Child();
    //     c.childMethod();
    // }
}