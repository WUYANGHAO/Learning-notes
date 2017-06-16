import java.util.Scanner;

public class Main {

	public static void main(String[] args) {
		// 将输入的字符串如aAbBcC..R进行筛选，输出全大写字符串如：ABCR
		Scanner sc = new Scanner(System.in);
		while (sc.hasNext()) {
			String str = sc.next();
			String out = str.replaceAll("[^A-Z]", "");
			System.out.println(out);

		}
		
	}

}
