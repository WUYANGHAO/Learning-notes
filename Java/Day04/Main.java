import java.util.*;
public class Main {

	public static void main(String[] args) {
//		使用标准输入（standard input）和标准输出（standard output）
//		表示手机电量
//		输入仅限：0,10,20,30,40,50,60,70,80,90,100
//		在输出电量上下加上“+---------------+”
		Scanner sc=new Scanner(System.in);
//		while (sc.hasNext()) {
//			String str = sc.next();
//			String[] mo={"0","10","20","30","40","50","60","70","80","90","100"};
//			List<String> list=Arrays.asList(mo);
//			String[] instr=str.split("\\s+");
//			int num=1;
//			for(int i=0;i<instr.length;i++){
//				if(list.contains(instr[i])){
//					num++;
//					System.out.println("+----------+");
//					int d=Integer.parseInt(instr[i]);
//					for(int j=0;j<10-d/10;j++){
//						System.out.println("1----------1");
//					}
//					for(int k=0;k<d/10;k++){
//						System.out.println("1++++++++++1");
//					}
//					System.out.println("+----------+");
//					if(num>=2){
//						System.out.println("===============");
//					}
//				}
//			}
//		}
		int num=0;
		while (sc.hasNextLine()) {
			String str = sc.nextLine();
			String[] mo={"0","10","20","30","40","50","60","70","80","90","100"};
			List<String> list=Arrays.asList(mo);
			if(list.contains(str)){
				num++;
				if(num>=2){
					System.out.println("===============");
				}
				System.out.println("+----------+");
				int d=Integer.parseInt(str);
				for(int j=0;j<10-d/10;j++){
					System.out.println("1----------1");
				}
				for(int k=0;k<d/10;k++){
					System.out.println("1++++++++++1");
				}
				System.out.println("+----------+");
			}else {
				System.out.println("ERROR:退出程序");
				System.out.println("输入值限制【0,10,20,30,40,50,60,70,80,90,100");
				break;
			}
		}
	}

}
