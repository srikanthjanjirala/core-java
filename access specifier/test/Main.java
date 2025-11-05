public class Main {
    public static void main(String[] args) {
        Parent p = new Parent();
        Child c = new Child();
        System.out.println(p.publicField);

        p.publicMethod();
        c.protectedMethod();

    }
}