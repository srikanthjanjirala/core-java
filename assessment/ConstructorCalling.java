package assessment;

public class ConstructorCalling extends Sub {
    public ConstructorCalling(String text){
//        super(text);
        i = 2;
    }

    public static void main(String args[])
    {
        ConstructorCalling sub = new ConstructorCalling("Hello"); 
        System.out.println(sub.i); 
    } 
}

class Sub {
    public int i = 0;
    public Sub(){
        i = 1;
    }
    
    public Sub(String text){
        i = 1;
    }
}

// Case 1: If parent has ONLY parameterized constructor
// Now child constructor: must have super() with parameter, otherwise compile time error
// Case 2: If parent has ONLY default constructor
// Now child constructor: super() is called by default, so no compile time error
// Case 3: If parent has BOTH default and parameterized constructor
// Now child constructor: super() is called by default, so no compile time error