import java.io.*;
import java.util.*;
import java.util.stream.*;

public class Hello {

  public static void main(String[] args) throws IOException {
    int n = nextInt();
    System.out.println(n);
  }
   
  //==================================================================
  // HELPERS
  //==================================================================

  static Scanner stdin = new Scanner(System.in);

  static double lastFloat() throws IOException {
    double d = nextFloat();
    stdin.nextLine();
    return d;
  }

  static int lastInt() throws IOException {
    int d = nextInt();
    stdin.nextLine();
    return d;
  }

  static String next() throws IOException {
    return stdin.next();
  }

  static double nextFloat() throws IOException {
    return stdin.nextDouble();
  }

  static int nextInt() throws IOException {
    return stdin.nextInt();
  }

  static String nextLine() throws IOException {
    return stdin.nextLine();
  }

  static int[] nextList() throws IOException {
    return Arrays
        .stream(stdin.nextLine().split(" "))
        .mapToInt(Integer::parseInt)
        .toArray();
  }

  static record Tuple(int left, int right) {}

  static Tuple nextTuple() throws IOException {
    return new Tuple(nextInt(), lastInt());
  }
}
