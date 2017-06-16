import java.util.Arrays;
import java.util.List;
import java.util.Scanner;

public class Main {

	public static void main(String[] args) {
//		在给定的一组数字中（15个，用例保证只有15个），如果有连续三个及以上的数字相同，则将这些数字消除，
//		同时如果前一次消除后导致后面连在一起的也有三个及以上的数字相同，需继续消除，最终输出不能消除的剩余的数字，如果所有数字都消除，则输出none
		Scanner sc=new Scanner(System.in);
		System.out.print("请输入15位数的数组");
		String str=sc.nextLine();
		String[] list=str.split("\\s+");
		List<String> aa=Arrays.asList(list);
		if(list.length != 15){
			System.out.println("输入错误");
		}else {
			for(int i=1;i<list.length-1;i++){
				for(int j=0;j<list.length;j++){
					if(list[j].equals(list[j+1])){
						i++;
					}
					if(i>=3){
						aa.remove(list[i]);
						list.length=list.length-i;
					}
				}
			}
			System.out.println(aa.toString());
		}
	}

}
