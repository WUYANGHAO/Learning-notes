import java.util.Scanner;

public class Main {

	public static void main(String[] args) {
//		输入两个两位正整数a,b，将a的十位和个位分别放到c的个位和百位，将b的十位和个位分别放到c的千位和十位，组成一个新的四位正整数c，输出
		Scanner sc=new Scanner(System.in);
		System.out.print("请输入两位数的正整数a=");
		int a=sc.nextInt();
		System.out.print("请输入两位数的正整数b=");
		int b=sc.nextInt();
		String tmpa=Integer.toString(a);
		String tmpb=Integer.toString(b);
		StringBuilder c=new StringBuilder();
		c.append(tmpb.charAt(0));
		c.append(tmpa.charAt(1));
		c.append(tmpb.charAt(1));
		c.append(tmpa.charAt(0));
		System.out.println("合成新的四位数正整数c="+c);
		
	}

}
