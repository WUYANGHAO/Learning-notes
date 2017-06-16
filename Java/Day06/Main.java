import java.util.*;
import java.util.List;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Main {

	public static void main(String[] args) {
//		在给定的一组数字中（15个，用例保证只有15个），如果有连续三个及以上的数字相同，则将这些数字消除，
//		同时如果前一次消除后导致后面连在一起的也有三个及以上的数字相同，需继续消除，最终输出不能消除的剩余的数字，如果所有数字都消除，则输出none
		Scanner sc=new Scanner(System.in);
		System.out.print("请输入15位数的数组,空格隔开");
		String str=sc.nextLine();		
		str=str.replaceAll("[^\\d]", "");
		
		Pattern pattern = Pattern.compile("([\\d])\\1{2,}");
		//System.out.println(pattern);
		Matcher matcher = pattern.matcher(str);
		
		while (matcher.find()){
		    str=str.replace(matcher.group(), "");
		    matcher = pattern.matcher(str);
		}
		System.out.println(str);
	}

}
