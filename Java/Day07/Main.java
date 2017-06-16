
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;

import sun.font.StrikeCache;

public class Main {

	public static void main(String[] args) {
//		真正的扑克牌排序，取消1,11,12,13，直接使用A,J,Q,K
		Scanner sc=new Scanner(System.in);
		System.out.print("输入扑克牌，以逗号隔开（最多52位,大小王除外）：");
		String str=sc.nextLine();
		String[] strlist=str.split(",");
		while(strlist.length>52){
			Scanner sc1=new Scanner(System.in);
			System.out.print("输入超过52位,请重新输入：");
			String str1=sc1.nextLine();
			strlist=str1.split(",");
		}
		int[] arr=new int[strlist.length];
		for(int i=0;i<strlist.length;i++){
			if(strlist[i].matches("[3-9]")){
				arr[i]=Integer.valueOf(strlist[i]);
			}else if (strlist[i].equals("10")) {
				arr[i]=10;
			}else {
				if(strlist[i].equals("J")){
					arr[i]=11;
				}else if (strlist[i].equals("Q")) {
					arr[i]=12;
				}else if (strlist[i].equals("K")) {
					arr[i]=13;
				}else if (strlist[i].equals("A")) {
					arr[i]=14;
				}else if (strlist[i].equals("2")) {
					arr[i]=15;
				}
			}
		}
		Arrays.sort(arr);
		
		String[] output=new String[arr.length];
		for(int i=0;i<arr.length;i++){
			if(arr[i]==11){
				output[i]="J";
			}else if (arr[i]==12) {
				output[i]="Q";
			}else if (arr[i]==13) {
				output[i]="K";
			}else if (arr[i]==14) {
				output[i]="A";
			}else if (arr[i]==15) {
				output[i]="2";
			}else {
				output[i]=Integer.toString(arr[i]);
			}
		}
		
		for(int j=0;j<output.length;j++){
			System.out.print(output[j]);
			if(j<output.length-1){
				System.out.print(",");
			}
		}
		
	}

}
