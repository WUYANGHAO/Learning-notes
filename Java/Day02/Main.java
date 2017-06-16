import java.util.*;
public class Main {

	public static void main(String[] args) {
//		输入一个字符串，字符串是字母和数字的组合，编程实现输出一个新的字符串，
//		要求字母在前面，数字在后面，顺序不变，字符串长度不大于128.例如：2s7ess83a 变成sessa2783
		Scanner sc =new Scanner(System.in);
		
		while (sc.hasNext()) {
			String str=sc.next();
			if (str.length()<=128) {
				String num=str.replaceAll("[^0-9]", "");
				String apa=str.replaceAll("[^A-z]", "");
				System.out.println(apa+num);
			}else {
				System.out.println("ERROR：输出参数长度错误");
			}
		}
	}

}
