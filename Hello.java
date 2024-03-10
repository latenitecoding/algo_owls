import java.io.*;
import java.util.*;
import java.util.stream.*;

public class Hello {
  
  // ========================================================
  // Solution
  // ========================================================

  public static void main(String[] args) throws IOException {
    String line = reader.readLine();
    System.out.println(line);
  }

  // ========================================================
  // Helpers
  // ========================================================

  private static BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));

  private static class Tuple {
    int n, m;

    public Tuple(int... args) {
      this.n = args[0];
      this.m = args[1];
    }

    // public boolean equals(Object o) {
    //   if (o instanceof Tuple) {
    //     Tuple t = (Tuple) o;
    //     return t.n == n && t.m == m;
    //   }
    //   return false;
    // }

    public String toString() {
      return String.format("Tuple(%d, %d)", n, m);
    }
  }

  @SuppressWarnings("unused")
  private static int next() throws IOException {
    return Integer.parseInt(reader.readLine());
  }

  @SuppressWarnings("unused")
  private static int[] nextArray() throws IOException {
    return Arrays.stream(reader.readLine().split(" ")).mapToInt(Integer::parseInt).toArray();
  }

  @SuppressWarnings("unused")
  private static String nextLine() throws IOException {
    return reader.readLine();
  }

  @SuppressWarnings("unused")
  private static Tuple nextTuple() throws IOException {
    return new Tuple(nextArray());
  }
}
