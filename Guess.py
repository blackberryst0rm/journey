# This is a basic guess the number game.
import random

guessesTaken = 0

print('Hello player! What is your name?')
player = input()

number = random.randint(1, 20)
print('Well hi there ' + player + ', I am thinking of a number between 1 and 20. Can you Guess which number that is?')

for guessesTaken in range(6): # Make sure to nest the indentations correctly or it can change everything.
    print( 'Take a guess..')
    guess = input()
    guess = int(guess)

    if guess < number:
        print('your guess is too low.') #Eight spaces infront of "print"

    if guess > number:
        print('Your guess is too high!')

    if guess == number:
        break

if guess == number:
        guessesTaken =str(guessesTaken +1)
        print('Good job, ' + player + '! You guessed my number in ' + guessesTaken + 'Guesses!')

if guess != number:
        number = str(number)
        print('Nope. The number I was thinking of was ' + number + '.')
