interface A{ void show(); }
interface B extends A{ void display(); }
interface C extends B{ void print(); }

class D implements A,C{
    public void show() {}
    public void display() {}
    public void print() {}
}



