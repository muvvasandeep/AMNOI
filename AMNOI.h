#include <iostream>
#include <fstream>
#include <string>
#include <queue>
#include <stack>
#include <vector>
#include <sstream>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
using namespace std;

struct method {
	string method_name;
	vector <string> temp_count;
	vector <string> return_list;
	float AMNOI;
};

struct list_of_methods {
	vector<method*> list;
};

bool check_method(string name,list_of_methods *temp_list);
bool check_return_type(string type,method *temp_method);
method* get_method(string name,list_of_methods *temp_list);
void print_sequence(int count);
void print_format(int count,string s);
