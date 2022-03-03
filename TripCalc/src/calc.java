/*
.Author(s)
Tony Valtinson
.Date
01/29/22
.Version
Java
.Synopsis
This calculates the time a trip will take. This is Assignment Project 2
.EXAMPLE
Open the console and run.
.OUTPUTS
Will get specified metrics.
.NOTES
You need valid permissions to run this.
.COMPONENT
Trip Calculator
.ROLE
Student
.FUNCTIONALITY
Student work
*/

import java.util.Scanner;


// gathering the scanner utility for use.
public class calc {
// Our main class. Required in Java
	public static void main(String[] args) {
		Scanner input = new Scanner (System.in);
		// the speed of the car in mph
		System.out.print("How many miles per hour as an integer?");
		int mph = input.nextInt();
		// the distance of the trip in miles as a double		
		System.out.print("Enter the distance of the trip in miles, this must be a double?");
		double miles = input.nextDouble();
				// calculate the trip time in hours.
		double trip_time = miles / mph;
		System.out.print(" Your trip will take" + " " + trip_time + "hours");
	}

}