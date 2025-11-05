public class CPU{
    public void start(){
        System.out.println("CPU started");
    }
}

public class Memory{
    public void load(){
        System.out.println("Memory loaded");
    }
}

public class HardDisk{
    public void read(){
        System.out.println("HardDisk read");
    }
}

public class ComputerFacade{
    public CPU cpu;
    public Memory memory;
    public HardDisk hardDisk;

    public ComputerFacade(){
        cpu = new CPU();
        memory = new Memory();
        hardDisk = new HardDisk();
    }

    public void startComputer(){
        cpu.start();
        memory.load();
        hardDisk.read();
        System.out.println("Computer started");
    }   
}

public class FacadeMain{
    public static void main(String[] args){
        ComputerFacade computerFacade = new ComputerFacade();
        computerFacade.startComputer();
    }
}

// OutPut:
// CPU started
// Memory loaded
// HardDisk read
// Computer started