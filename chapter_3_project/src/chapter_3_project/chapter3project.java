//.Author(s)
//Tony_Valtinson
//.Date
//02/11/2022
package chapter_3_project;
import java.util.Scanner;
import java.util.Random;

public class chapter3project {

	public static void main(String[] args) {
		// we need random and a scanner
		Scanner input = new Scanner(System.in);
		//we need user input per the request.
		System.out.print("Please enter the temprature in Celsius that beans cook at:");
		
		// we need random numbers.
		Random number = new Random();
		int low = 50;
		int high = 150;
		int result = number.nextInt(high-low) + low;
		
		
		//evaluate
		if (result < 100)
			System.out.print("The water temperature is " + result + " Celsius and is not hot enough to cook beans.");
		else if (result > 150)
			System.out.print("The water temperature is " + result + " Celsius and is too hot enough to cook beans.");
		else if (result >= 100)
			System.out.print("The water temperature is " + result + " Celsius and cooked the beans.");
		//close?
		
		
		input.close();
	}

}
