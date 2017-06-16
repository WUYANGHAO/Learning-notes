import java.util.Scanner;

public class Main {

	public static void main(String[] args) {
//		将输入的秒转换成DDD:HH:MM:SS格式 
//		用例1： 
//		输入：-1111111 
//		输出：0:00:00:00 
//		用例2： 
//		输入：90066 
//		输出：1:01:01:06 
//		用例3： 
//		输入: 13419006 
//		输出：155:07:30:06
		Scanner sc=new Scanner(System.in);
		System.out.print("请输入秒：");
		String str=sc.nextLine();
		int insec=Integer.parseInt(str);
		if(insec<=0){
			System.out.println("0:00:00:00");
		}else {
			int day=insec/86400;
			int hour=(insec%86400)/3600;
			int minu=((insec%86400)%3600)/60;
			int sec=((insec%86400)%3600)%60;
			String output=day+":";
			if(hour<10){
				output+="0"+hour+":";
			}else {
				output+=hour+":";
			}
			if(minu<10){
				output+="0"+minu+":";
			}else {
				output+=minu+":";
			}
			if(sec<10){
				output+="0"+sec;
			}else {
				output+=sec;
			}
			System.out.println(output);
		}
		
	}

}
