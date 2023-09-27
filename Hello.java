import java.io.*;
import java.util.*;

public class Hello {
  
  private static BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));

  //========================================================
  // StdIn Helpers
  //========================================================

  @SuppressWarnings("unused")
  private static int next() throws IOException {
    return Integer.parseInt(reader.readLine());
  }

  @SuppressWarnings("unused")
  private static int[] nextTuple() throws IOException {
    return Arrays.stream(reader.readLine().split(" "))
      .mapToInt(Integer::parseInt)
      .toArray();
  }

  //========================================================
  // Solution
  //========================================================

  public static void main(String[] args) throws IOException {
    System.out.print("Hello, World!");
  }
}
