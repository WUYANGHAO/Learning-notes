import java.util.*;

import sun.security.util.Length;
public class Main {

	public static void main(String[] args) {
//		输入数字字符串，字符串长度不能超过128，用,分隔放入int数组中，得出最大值和次最大值，什么都不输时输出0，
//		只输入一个，最大值、次最大值都一样为输入数，输入两个值相同的，
//		同上结果，否则，输出最大值、次最大值。（简而言之，取一组数组中最大的前两个数。）
		Scanner sc=new Scanner(System.in);
		while (sc.hasNext()) {
			String str=sc.nextLine();
			if(str.length()>0 && str.length()<=128){
				String[] list=str.split(",");
				int[] arr=new int[list.length];
				for(int i=0;i<list.length;i++){
					arr[i]=Integer.valueOf(list[i]);
				}
				Arrays.sort(arr);
				if(arr.length==1){
					System.out.println("最大值和次大值相等，为"+arr[1]);
				}else {
					System.out.println("最大值为："+arr[arr.length-1]);
					System.out.println("次大值为："+arr[arr.length-2]);
				}
			}else if (str.length()==0) {
				System.out.println("0");
			}else {
				System.out.println("ERROR:输入字符串长度超过128");
			}
		}
	}

}
/**
 * Scanner 有几个方法
 * scan.next()      获取输入，遇到空格截止
 * scan.nextLine()  获取一行
 * scan.nextInt()   获取输入int值
 * scan.nextLong()  获取输入long值
 * ....
 * 
 * 输入数字字符串，分割放到数组中去
 * 
 * String str = scan.nextLine()  获取到一行
 * str.trim()                    去掉首位的空格
 * String[] arr = str.split(",") 以逗号作分割，返回一个字符串数组
 * 
 * 接下来就是放到整形数组中
 * 先初始化一个整形数组
 * int[] b = new int[arr.length]
 * 在逐个进行赋值
 * for(int i = 0 ;i < arr.length; i++){
 * 	b[i] = Integer.parseInt(arr[i]);
 * }
 * 
 */
