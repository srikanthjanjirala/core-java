package assessment;

public class First {
    public static void main(String[] args) {
        Second foo = new Third();
        foo.show();
    }
}


class Second {
    public static void show() {
        System.out.println("Second::show() called");
    }
}

class Third extends Second {
    public static void show() {
        System.out.println("Third::show() called");
    }
}