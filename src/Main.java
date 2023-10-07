import java.io.IOException;

public class Main {

  public static void main(String[] args) throws IOException {
    if (args.length > 0 && (args[0].equals("-h") || args[0].equals("--help"))) {
      System.out.println("Usage: algo_owls --solution <SOLUTION>");
      System.out.println();
      System.out.println("Options:");
      System.out.printf("%-30s %s\n", "  -s, --solution <SOLUTION>", "");
      System.out.printf("%-30s %s\n", "  -h, --help", "Print help");
      System.out.printf("%-30s %s\n", "  -V, --version", "Print version");
      System.exit(0);
    }
    if (args.length > 0 && (args[0].equals("-V") || args[0].equals("--version"))) {
      System.out.println("algo_owls 0.1.0");
      System.exit(0);
    }
    if (args.length > 1 && (args[0].equals("-s") || args[0].equals("--solution"))) {
      Solutions.callSolution(args[1]);
      System.exit(0);
    }
    System.out.println("Usage: algo_owls --solution <SOLUTION>");
    System.out.println();
    System.out.println("For more information, try '--help'.");
    System.exit(1);
  }
}
