#include "AMNOI.h"
using namespace std;

//Function to check if the method with the name is present or not
bool check_method(string name,list_of_methods *temp_list){
	for(int i=0;i<temp_list->list.size();i++){	//Loop to iterate through the list of methods
		if(temp_list->list[i]->method_name==name){
			return true;
		}
	}
	return false;
}

//Function to check if a method with a particular return type is present or not
bool check_return_type(string type,method *temp_method){
	for(int i=0;i<temp_method->return_list.size();i++){	//Loop to iterate through the list of all return types of a method
		if(temp_method->return_list[i]==type){
			return true;
		}
	}
	return false;
}

////Function to retrieve the information of method with the name in the list of methods
method* get_method(string name,list_of_methods *temp_list){
	for(int i=0;i<temp_list->list.size();i++){	//Loop to iterate through the list of methods
		if(temp_list->list[i]->method_name==name){
			return temp_list->list[i];
		}
	}
}

//Funciton to print the output neatly
void print_sequence(int count){
	cout<<"+";
	for(int i=0;i<count-2;i++) cout<<"-";
	cout<<"+"<<endl;
}

//Funciton to print the output neatly
void print_format(int count,string s){
	int l = count-s.length()-2;
	cout<<"|";
	if(l%2==0){
		for(int j=0;j<l/2;j++) cout<<" ";
	}
	else{
		for(int j=0;j<l/2+1;j++) cout<<" ";
	}
	cout<<s;
	for(int j=0;j<l/2;j++) cout<<" ";
	cout<<"|";
}
