public class Parent {
    public String publicField = "I am a public";
    private String privateField = "I am a private";
    protected String protectedField = "I am a protected";

    public void publicMethod(){
        System.out.println("public "+ publicField);
    }

    public void privateMethod(){
        System.out.println("Private "+ privateField);
    }

    public void protectedMethod(){
        System.out.println("Protected "+ protectedField);
    }
}    