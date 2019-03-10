package bojEX;
import java.util.Scanner;

public class BOJ2577 {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int times = sc.nextInt() * sc.nextInt() * sc.nextInt();
		int []inum = new int[10];
		while(times > 0) {
			inum[times%10] ++;
			times = times/10;
		}
		for(int ir : inum) {
			System.out.println(ir);
		}
	}

}
