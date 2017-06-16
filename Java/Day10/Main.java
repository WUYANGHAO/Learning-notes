import java.util.Scanner;

public class Main {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner sc = new Scanner(System.in);
		String str = sc.nextLine();
		do_2(str);
	}

	public static void do_2(String str) {
		int count = 1;
		String s = str.charAt(0) + "";
		String output = "";

		for (int i = 1; i < str.length(); i++) {
			if (s.equals(str.charAt(i) + "")) {
				count++;
				if (i == str.length() - 1) {
					if(count==1){
						output = output + s;
					}else {
						output = output + count + s;
					}
				}
			} else {
				if (count == 1){
					output=output+s;
				}else{
					output = output + count + s;
				}
				s = str.charAt(i) + "";
				count = 1;
			}
		}
		System.out.println(output);
	}

}
