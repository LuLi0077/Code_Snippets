// A simple program demonstrating the use of pointers.

#include <iostream>
using namespace std;

int main()
{
	// declare an integer and a float variable
	int IntNum; 
	float FloatNum;
	
	// declare integer and float pointers
	int *pIntNum;
	float *pFloatNum;
	
	// initialize the integer and float variables
	IntNum = 10;
	FloatNum = 12.34;
	
	// store addresses in pointers
	pIntNum = &IntNum;
	pFloatNum = &FloatNum;

	// print out the original values
    cout << "Before increment: " << endl;
	cout << "\t IntNum is: " << IntNum << endl;
	cout << "\t FloatNum is: " << FloatNum << endl;
	
	// note that we need to dereference a pointer in order
	// to extract the value it contains.
	cout << "\t pIntNum contains: " << *pIntNum << endl;
	cout << "\t pFloatNum contains: " << *pFloatNum << endl;

	// increment values of the integer and float variables 
	(*pIntNum)++;  // dereference and then increment
	(*pFloatNum)++;

	// print out the values after increment
    cout << "After increment: " << endl;
	cout << "\t IntNum is: " << IntNum << endl;
	cout << "\t FloatNum is: " << FloatNum << endl;

	cout << "\t pIntNum contains: " << *pIntNum << endl;
	cout << "\t pFloatNum contains: " << *pFloatNum << endl;

	return 0;
}

