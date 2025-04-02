public class HelloWorld {
    public static void main(String[] args) {
        while (true) { // Infinite loop to keep the app running
            System.out.println("Hello, World!");
            try {
                Thread.sleep(5000); // Wait for 5 seconds before printing again
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
