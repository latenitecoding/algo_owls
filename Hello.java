import java.io.*;
import java.util.*;
import java.util.stream.*;

public class Hello {
  
  private static final boolean DEBUG = false;
  private static BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));

  // ========================================================
  // Helpers
  // ========================================================

  private static class Tuple {
    int n, m;

    public Tuple(int n, int m) {
      this.n = n;
      this.m = m;
    }

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
  private static Tuple nextTuple() throws IOException {
    String[] line = reader.readLine().split(" ");
    return new Tuple(
        Integer.parseInt(line[0]),
        Integer.parseInt(line[1])
      );
  }

  @SuppressWarnings("unused")
  private static void print(String label, int[] arr) {
    if (!DEBUG) return;
    System.out.println("");
    System.out.println("> " + label);
    System.out.println(Arrays.toString(arr));
    System.out.println("");
  }

  @SuppressWarnings("unused")
  private static void print(String label, int[][] arr) {
    if (!DEBUG) return;
    System.out.println("");
    System.out.println("> " + label);
    for (int[] row : arr) System.out.println(Arrays.toString(row));
    System.out.println("");
  }

  @SuppressWarnings("unused")
  private static <E> void print(String label, E e) {
    if (!DEBUG) return;
    System.out.println("");
    System.out.println("> " + label);
    System.out.println(e);
    System.out.println("");
  }

  @SuppressWarnings("unused")
  private static <E> void print(String label, E[] arr) {
    if (!DEBUG) return;
    System.out.println("");
    System.out.println("> " + label);
    for (E e : arr) System.out.println(e);
    System.out.println("");
  }

  // ========================================================
  // Solution
  // ========================================================

  public static void main(String[] args) throws IOException {
    String line = reader.readLine();
    System.out.println(line);
  }
}
