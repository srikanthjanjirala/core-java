public interface Printer {
    void print(String message);
}

public class OldPrinter {
    public void oldPrint(String msg) {
        System.out.println("Old Printer: " + msg);
    }
}

public class PrinterAdapter implements Printer {
    private OldPrinter oldPrinter;

    public PrinterAdapter(OldPrinter oldPrinter) {
        this.oldPrinter = oldPrinter;
    }

    @Override
    public void print(String message) {
        oldPrinter.oldPrint(message);
    }
}

public class AdapterMain {
    public static void main(String[] args) {
        OldPrinter oldPrinter = new OldPrinter();
        Printer printer = new PrinterAdapter(oldPrinter);

        printer.print("Hello, Adapter Pattern!");
    }
}