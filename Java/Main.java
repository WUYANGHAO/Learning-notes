import java.util.Scanner;

public class Main {

	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		String input=sc.nextLine().trim();
		String a=input.replaceAll(" ", "");
		StringBuilder daoxu=new StringBuilder();
		for(int i=a.length();i>0;i--){
			daoxu.append(a.charAt(i-1));
		}
		
		StringBuilder output=new StringBuilder();
		for(int i=0;i<daoxu.length();i++){
			if(Character.isUpperCase(daoxu.charAt(i))){
				output.append(Character.toLowerCase(daoxu.charAt(i)));
			}else {
				output.append(Character.toUpperCase(daoxu.charAt(i)));
			}
		}
		System.out.println(output.toString());
	}
	
}
