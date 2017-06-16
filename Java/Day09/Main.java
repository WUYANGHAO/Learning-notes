import java.util.*;

import com.sun.org.apache.bcel.internal.generic.ARRAYLENGTH;

public class Main {

	public static void main(String[] args) {
//		键盘输入一句话,输出一句话中最长的单词，空格隔开，如果最长的出现多次，返回最后一个。
//		这句话只包含数字字母和标点。
//		输入：Genetics To undergo or cause recombination; form new combinations.
//		输出：recombination
		Scanner sc=new Scanner(System.in);
		String str=sc.nextLine();
		String[] list=str.split(" ");
		int[] un=new int[list.length];
		ArrayList aa=new ArrayList();
		for(int i=0;i<list.length;i++){
			String tmp=list[i].replaceAll("[^A-z0-9]", "");
			un[i]=tmp.length();
			aa.add(un[i]);
//			System.out.print(un[i]+",");
		}
		int maxaa=(int) aa.get(0);
		for(int j=1;j<list.length;j++){
			if((int) aa.get(j)>maxaa){
				maxaa=(int) aa.get(j);
			}
		}
		int maxnum=0;
		for(int i=0;i<list.length;i++){
			if((int) aa.get(i)==maxaa){
				maxnum=i;
			}
		}
		System.out.println(aa.toString());
		System.out.println(list[maxnum].replaceAll("[^A-z0-9]", ""));

	}

}
