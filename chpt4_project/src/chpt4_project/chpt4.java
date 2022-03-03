//.Author(s)
//Tony_Valtinson
//.Date
//02/16/2022
package chpt4_project;

import java.util.Scanner;


public class chpt4 {

	public static void main(String[] args) {
		try (// TODO Auto-generated method stub
		Scanner input = new Scanner(System.in)) {
			// the team name is requested
			System.out.print("what is the name of the team?: ");
			String TeamName = input.nextLine();
			
			// the first member
			System.out.print("What is the name of the first team member? ");
			String member1 = input.nextLine();
			System.out.print("Please enter the first team members weight in lbs as a decimal. ");
			String lbs11 = input.nextLine();
			
			// now the second member
			System.out.print("What is the name of the second team member? ");
			String member2 = input.nextLine();
			System.out.print("Please enter the second team members weight in lbs as a decimal. ");
			String lbs22 = input.nextLine();
			
			// now the third member
			System.out.print("What is the name of the third team member? ");
			String member3 = input.nextLine();
			System.out.print("Please enter the third team members weight in lbs as a decimal. ");
			String lbs33 = input.nextLine();
			
			// first output according to instructions
			System.out.print("Team " + TeamName + " members: " + member1 + " and " + member2 + " and " + member3);
			input.nextLine();
			
			
			// math times?!?!?! We need to convert our strings to doubles per instructions... then make them kilograms. kg = 1/2.2043
			double kg1 = Double.parseDouble(lbs11) / 2.2043;
			double kg2 = Double.parseDouble(lbs22) / 2.2043;
			double kg3 = Double.parseDouble(lbs33) / 2.2043;
			// k now we need to add up the kg into what? an array? i dont think this is an array but hey, who am i to argue with my self.
			double amount = (int)(kg1 + kg2 + kg3);
			System.out.printf("The total weight of the team is " + amount + " ");
			if (amount <= 272.16)System.out.printf("is under the maximum");
			// i could not get else to work here and when I read into the printf it confuses me a bit. 
			if (amount > 272.16)System.out.printf("is above the maximum");
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
	}

}
